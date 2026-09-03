import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:veyra/core/router/route_names.dart';
import 'package:veyra/features/activity_details/presentation/pages/activity_details_page.dart';
import 'package:veyra/features/add_activity/data/models/activity_model.dart';
import 'package:veyra/features/add_activity/presentation/pages/add_activity_page.dart';
import 'package:veyra/features/auth/presentation/pages/auth_page.dart';
import 'package:veyra/features/history/presentation/pages/history_page.dart';
import 'package:veyra/features/home/presentation/pages/home_page.dart';
import 'package:veyra/features/main_layout/presentation/pages/main_layout.dart';
import 'package:veyra/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:veyra/features/profile/presentation/pages/profile_page.dart';
import 'package:veyra/features/splash/presentation/pages/splash_page.dart';
import 'package:veyra/features/status/presentation/pages/states_page.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: RouteNames.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        name: RouteNames.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: RouteNames.auth,
        name: RouteNames.auth,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: RouteNames.addActivity,
        name: RouteNames.addActivity,
        builder: (context, state) => const AddActivityPage(),
      ),
      GoRoute(
        path: RouteNames.activityDetails,
        name: RouteNames.activityDetails,
        builder: (context, state) {
          final activityModel = state.extra as ActivityModel;
          return ActivityDetailsPage(activityModel: activityModel);
        },
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => MainLayout(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                name: RouteNames.home,
                builder: (context, state) => const HomePage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.history,
                name: RouteNames.history,
                builder: (context, state) => const HistoryPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.states,
                name: RouteNames.states,
                builder: (context, state) => const StatesPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.profile,
                name: RouteNames.profile,
                builder: (context, state) => const ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const Scaffold(body: Center(child: Text('No Route Found'))),
  );
}
