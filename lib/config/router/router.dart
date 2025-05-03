import 'package:adhdo_it_mob/ui/screens/auth/login_screen.dart';
import 'package:adhdo_it_mob/ui/screens/auth/verification_code_screen.dart';
import 'package:adhdo_it_mob/ui/screens/home/home_screen.dart';
import 'package:adhdo_it_mob/ui/screens/intro/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'app_route.dart';

GoRouter buildRouter(BuildContext context, String initialLocation) {
  return GoRouter(
    initialLocation: Routes.home(), //initialLocation,
    routes: [
      GoRoute(
        path: Routes.login.path,
        builder: (context, state) {
          return LoginScreen();
        },
      ),
      GoRoute(
        path: Routes.verificationCode.path,
        builder:
            (context, state) => VerificationCodeScreen(state.extra as String),
      ),
      GoRoute(
        path: Routes.home.path,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.intro.path,
        builder: (context, state) => const IntroScreen(),
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(child: Text('Route not found ${state.path}')),
      );
    },
  );
}
