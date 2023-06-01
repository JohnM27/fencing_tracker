import 'package:fencing_tracker/presentation/screens/create_user_screen.dart';
import 'package:fencing_tracker/presentation/screens/home_screen.dart';
import 'package:fencing_tracker/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/createuser',
      builder: (context, state) => const CreateUserScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/currentpractice',
          builder: (context, state) => const Center(
            child: Text('Current Practice'),
          ),
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
  redirect: (context, state) {
    // If there is no user, go to the create user page
    // if (!UserService().userExist) {
    //   return '/createuser';
    // }

    return null;
  },
);
