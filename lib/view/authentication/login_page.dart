import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plus_it_park_machine_test/providers/authentication_provider.dart';
import 'package:plus_it_park_machine_test/providers/provider.dart';
import 'package:plus_it_park_machine_test/utils/dynamic_size.dart';
import 'package:plus_it_park_machine_test/utils/snackbar_util.dart';
import 'package:plus_it_park_machine_test/view/authentication/signup_page.dart';
import 'package:plus_it_park_machine_test/view/home/home_page.dart';

class LoginPage extends HookConsumerWidget {
  static const routePath = '/login';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    Future<void> login() async {
      final data = ref.read(authenticationProvider.notifier).login(
            email: emailController.text,
            password: passwordController.text,
          );

      data.then((value) {
        SnackbarUtil.showError(value, context);
      });
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.watch(authenticationProvider).token != null) {
        context.go(HomePage.routePath);
      }
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(
            R.width(10, context),
          ),
          child: Column(
            children: [
              SizedBox(
                height: R.width(100, context),
              ),
              Image.asset(
                "assets/images/login_img.png",
              ),
              Text(
                "Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: R.width(30, context),
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: R.width(15, context),
                  right: R.width(15, context),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: R.width(30, context),
                    ),
                    TextField(
                      cursorColor: Colors.white,
                      controller: emailController,
                      style: const TextStyle(color: Colors.white),
                      decoration: const InputDecoration(
                        fillColor: Colors.white38,
                        filled: true,
                        border: OutlineInputBorder(borderSide: BorderSide.none),
                        prefixIcon: Icon(
                          Icons.email_outlined,
                          color: Colors.white70,
                        ),
                        hintText: "Email or Phone",
                        hintStyle: TextStyle(color: Colors.white70),
                      ),
                    ),
                    SizedBox(
                      height: R.width(10, context),
                    ),
                    TextField(
                      controller: passwordController,
                      cursorColor: Colors.white,
                      obscureText: ref.watch(visibleProvider),
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        fillColor: Colors.white38,
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.white70,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            ref.read(visibleProvider.notifier).state =
                                !ref.read(visibleProvider.notifier).state;
                          },
                          color: Colors.white54,
                          icon: Icon(
                            ref.watch(visibleProvider)
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                        ),
                        filled: true,
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none),
                        hintText: "Password",
                        hintStyle: const TextStyle(color: Colors.white70),
                      ),
                    ),
                    SizedBox(
                      height: R.width(20, context),
                    ),
                    InkWell(
                      onTap: () {
                        login();
                      },
                      child: Container(
                        width: MediaQuery.sizeOf(context).width,
                        height: R.width(60, context),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white60,
                            width: R.width(2, context),
                          ),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              R.width(10, context),
                            ),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: R.width(20, context),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: R.width(10, context),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Not have an account?",
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: R.width(16, context),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            context.go(SignUP.routePath);
                          },
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: R.width(17, context),
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
