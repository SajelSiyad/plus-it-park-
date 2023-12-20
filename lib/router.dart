import 'package:go_router/go_router.dart';
import 'package:plus_it_park_machine_test/view/authentication/login_page.dart';
import 'package:plus_it_park_machine_test/view/authentication/signup_page.dart';
import 'package:plus_it_park_machine_test/view/authentication/update_page.dart';
import 'package:plus_it_park_machine_test/view/home/home_page.dart';

final router = GoRouter(
  initialLocation: HomePage.routePath,
  routes: [
    GoRoute(
      path: HomePage.routePath,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: LoginPage.routePath,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: SignUP.routePath,
      builder: (context, state) => const SignUP(),
    ),
    GoRoute(
      path: UpdatePage.routePath,
      builder: (context, state) => const UpdatePage(),
    ),
  ],
);
