import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:plus_it_park_machine_test/providers/authentication_provider.dart';
import 'package:plus_it_park_machine_test/utils/dynamic_size.dart';
import 'package:plus_it_park_machine_test/utils/snackbar_util.dart';
import 'package:plus_it_park_machine_test/view/authentication/login_page.dart';
import 'package:plus_it_park_machine_test/view/home/home_page.dart';

class SignUP extends HookConsumerWidget {
  static const routePath = '/register';

  const SignUP({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();

    Future<void> signUp() async {
      final data = ref.read(authenticationProvider.notifier).signup(
            name: nameController.text,
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
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/sign_up_img.png",
                  scale: 3,
                ),
              ],
            ),
            Text(
              "Sign Up",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: R.width(30, context),
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: R.width(10, context),
            ),
            Text(
              textAlign: TextAlign.center,
              "Enter yor email to create or sign in to your\naccount.",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                letterSpacing: R.width(1, context),
              ),
            ),
            SizedBox(
              height: R.width(20, context),
            ),
            Padding(
              padding: EdgeInsets.all(R.width(20, context)),
              child: Column(
                children: [
                  TextField(
                    controller: nameController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      fillColor: Colors.white38,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.white70,
                      ),
                      hintText: "Name",
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: R.width(13, context),
                  ),
                  TextField(
                    controller: emailController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      fillColor: Colors.white38,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: Colors.white70,
                      ),
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: R.width(13, context),
                  ),
                  TextField(
                    controller: passwordController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      fillColor: Colors.white38,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.white70,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: R.width(13, context),
                  ),
                  TextField(
                    controller: confirmPasswordController,
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      fillColor: Colors.white38,
                      filled: true,
                      border: OutlineInputBorder(borderSide: BorderSide.none),
                      prefixIcon: Icon(
                        Icons.lock_person_rounded,
                        color: Colors.white70,
                      ),
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(color: Colors.white70),
                    ),
                  ),
                  SizedBox(
                    height: R.width(30, context),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      signUp();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            R.width(5, context),
                          ),
                        ),
                      ),
                      fixedSize: Size(
                        R.width(180, context),
                        R.width(50, context),
                      ),
                    ),
                    child: ref.watch(authenticationProvider).isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Text(
                            "Create Account",
                            style: TextStyle(
                              color: const Color(0xFF3C3A3A),
                              fontWeight: FontWeight.w600,
                              fontSize: R.width(16, context),
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
                        "Already have an account?",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: R.width(16, context),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.go(LoginPage.routePath);
                        },
                        child: Text(
                          "Login",
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
    );
  }
}
