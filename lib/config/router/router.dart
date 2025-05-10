import 'package:adhdo_it_mob/data/models/task_model.dart';
import 'package:adhdo_it_mob/ui/screens/auth/login_screen.dart';
import 'package:adhdo_it_mob/ui/screens/auth/verification_code_screen.dart';
import 'package:adhdo_it_mob/ui/screens/edit_task/edit_task_screen.dart';
import 'package:adhdo_it_mob/ui/screens/filter/filter_screen.dart';
import 'package:adhdo_it_mob/ui/screens/home/home_screen.dart';
import 'package:adhdo_it_mob/ui/screens/intro/intro_screen.dart';
import 'package:adhdo_it_mob/ui/screens/tariff_selection/tariff_selection_screen.dart';
import 'package:adhdo_it_mob/ui/screens/task_in_progress/task_in_progress_screen.dart';
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
          return LoginScreen();
        },
      ),
      GoRoute(
        path: Routes.verificationCode.path,
        builder:
            (context, state) => VerificationCodeScreen(state.extra as String),
      ),
      GoRoute(
        path: Routes.intro.path,
        builder: (context, state) => const IntroScreen(),
      ),
      GoRoute(
        path: Routes.tariffSelection.path,
        builder: (context, state) => const TariffSelectionScreen(),
      ),
      GoRoute(
        path: Routes.home.path,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: Routes.filter.path,
        builder: (context, state) => const FilterScreen(),
      ),
      GoRoute(
        path: Routes.taskInProgress.path,
        builder:
            (context, state) => TaskInProgressScreen(state.extra as TaskModel),
      ),
      GoRoute(
        path: Routes.editTask.path,
        builder: (context, state) => EditTaskScreen(state.extra as TaskModel),
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(child: Text('Route not found ${state.path}')),
      );
    },
  );
}
