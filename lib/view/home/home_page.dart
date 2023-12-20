import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:plus_it_park_machine_test/models/api_model.dart';
import 'package:plus_it_park_machine_test/providers/api_provider.dart';
import 'package:plus_it_park_machine_test/providers/authentication_provider.dart';
import 'package:plus_it_park_machine_test/utils/dynamic_size.dart';
import 'package:plus_it_park_machine_test/utils/snackbar_util.dart';
import 'package:plus_it_park_machine_test/view/authentication/login_page.dart';
import 'package:plus_it_park_machine_test/view/authentication/update_page.dart';

class HomePage extends ConsumerWidget {
  static const routePath = '/';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.watch(authenticationProvider).token == null) {
        context.go(LoginPage.routePath);
      }
    });

    final provider = ref.watch(getDatasProvider);

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            SizedBox(
              height: R.width(50, context),
            ),
            ListTile(
              onTap: () {
                context.push(UpdatePage.routePath);
              },
              leading: const Icon(Icons.update),
              title: const Text("Update User Details"),
            ),
            const Divider(),
            ListTile(
              onTap: () {
                ref
                    .read(authenticationProvider.notifier)
                    .deleteUser()
                    .then((value) => SnackbarUtil.showError(value, context));
              },
              leading: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              title: const Text(
                "Delete User",
                style: TextStyle(color: Colors.red),
              ),
            ),
            const Divider(),
            ListTile(
              onTap: () => ref.read(authenticationProvider.notifier).logout(),
              leading: const Icon(
                Icons.logout,
                color: Colors.red,
              ),
              title: const Text("Log Out", style: TextStyle(color: Colors.red)),
            )
          ],
        ),
      ),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue[900],
        title: const Text(
          "Plus It Park",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.sizeOf(context).width,
                height: R.width(150, context),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      R.width(15, context),
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      "Message",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: R.width(20, context),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: R.width(20, context),
                    ),
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Text(
                            snapshot.data!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: R.width(17, context),
                                fontWeight: FontWeight.w500),
                          );
                        }
                      },
                      future:
                          ref.read(authenticationProvider.notifier).protected(),
                    ),
                  ],
                ),
              ),
              provider.when(
                data: (data) {
                  if (data == null) {
                    return const Center(
                      child: Text("Nothing to show."),
                    );
                  }

                  final products = <String, List<ApiModel>>{};
                  for (final product in data) {
                    if (!products.containsKey(product.category)) {
                      products[product.category] = [];
                    }

                    products[product.category]!.add(product);
                  }

                  final column = <Widget>[];

                  for (final productFiltered in products.entries) {
                    column.add(Text(
                      '${productFiltered.key[0].toUpperCase()}${productFiltered.key.substring(1)}',
                      style: TextStyle(
                          fontSize: R.width(20, context),
                          fontWeight: FontWeight.w700),
                    ));
                    column.add(const Divider());
                    column.add(
                      ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        physics: const ClampingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: R.width(100, context)),
                                child: Image.network(
                                    productFiltered.value[index].image),
                              ),
                              SizedBox(
                                width: R.width(24, context),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: R.width(180, context),
                                    child: Text(
                                      productFiltered.value[index].title,
                                      style: TextStyle(
                                          fontSize: R.width(16, context),
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Text(
                                    "Price: ${productFiltered.value[index].price}",
                                    style: TextStyle(
                                        fontSize: R.width(15, context),
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      Text(
                                        "${productFiltered.value[index].rating.rate} (${productFiltered.value[index].rating.count})",
                                        style: TextStyle(
                                            fontSize: R.width(15, context),
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: R.width(20, context),
                          );
                        },
                        itemCount: productFiltered.value.length,
                      ),
                    );
                  }

                  return Column(
                    children: column,
                  );
                },
                error: (error, stackTrace) {
                  return const Center(
                    child: Text("Something went wrong"),
                  );
                },
                loading: () {
                  return const Center(child: CircularProgressIndicator());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
