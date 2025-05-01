import 'package:adhdo_it_mob/ui/screens/auth/login_page.dart';
import 'package:adhdo_it_mob/ui/screens/auth/verification_code_page.dart';
import 'package:adhdo_it_mob/ui/screens/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_route.dart';

GoRouter buildRouter(BuildContext context, String initialLocation) {
  return GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: Routes.login.path,
        builder: (context, state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: Routes.verificationCode.path,
        builder:
            (context, state) => VerificationCodePage(state.extra as String),
      ),
      GoRoute(
        path: Routes.home.path,
        builder: (context, state) => const HomePage(),
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(child: Text('Route not found ${state.path}')),
      );
    },
  );
}
