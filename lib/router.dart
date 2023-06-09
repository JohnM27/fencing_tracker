import 'package:fencing_tracker/application/authentication_service.dart';
import 'package:fencing_tracker/presentation/screens/auth/login_screen.dart';
import 'package:fencing_tracker/presentation/screens/create_match_screen.dart';
import 'package:fencing_tracker/presentation/screens/home_screen.dart';
import 'package:fencing_tracker/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// class MyRouter {
// final AuthenticationService authenticationService;
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

// MyRouter(this.authenticationService);

final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/currentpractice',
          builder: (context, state) => const CreateMatchScreen(),
        ),
        GoRoute(
          path: '/list',
          builder: (context, state) => const Center(
            child: Text('List'),
          ),
        ),
        GoRoute(
          path: '/stats',
          builder: (context, state) => const Center(
            child: Text('Stats'),
          ),
        ),
      ],
    )
  ],
  redirect: (context, state) async {
    AuthenticationService authenticationService =
        AuthenticationService.fromProvider(context, listen: false);

    if (!authenticationService.tryRefresh) {
      await authenticationService.refresh();
    }

    if (authenticationService.status == AuthenticationStatus.unauthenticated) {
      return '/login';
    }

    if (state.location == '/login') {
      return '/';
    }

    return null;
  },
);
// }
