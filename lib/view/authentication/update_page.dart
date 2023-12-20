import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plus_it_park_machine_test/providers/authentication_provider.dart';
import 'package:plus_it_park_machine_test/utils/dynamic_size.dart';
import 'package:plus_it_park_machine_test/utils/snackbar_util.dart';

class UpdatePage extends HookConsumerWidget {
  static const routePath = "/update";
  const UpdatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final passwordController = useTextEditingController();

    Future<void> updateUser() async {
      ref
          .read(authenticationProvider.notifier)
          .update(name: nameController.text, password: passwordController.text)
          .then((value) => SnackbarUtil.showError(value, context));
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            SizedBox(
              height: R.width(50, context),
            ),
            Text(
              "Update User Details",
              style: TextStyle(
                  fontSize: R.width(25, context), fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: R.width(60, context),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(
              height: R.width(10, context),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: "Password",
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
            ),
            SizedBox(
              height: R.width(20, context),
            ),
            ElevatedButton(
              onPressed: updateUser,
              style: ElevatedButton.styleFrom(
                fixedSize: Size(
                  R.width(200, context),
                  R.width(50, context),
                ),
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    R.width(20, context),
                  ),
                ),
              ),
              child: Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: R.width(
                    18,
                    context,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
