import 'package:fencing_tracker/application/authentication_service.dart';
import 'package:fencing_tracker/presentation/screens/admin_screen.dart';
import 'package:fencing_tracker/presentation/screens/auth/login_screen.dart';
import 'package:fencing_tracker/presentation/screens/auth/password_screen.dart';
import 'package:fencing_tracker/presentation/screens/help_screen.dart';
import 'package:fencing_tracker/presentation/screens/history/history_opponent.dart';
import 'package:fencing_tracker/presentation/screens/history/history_practice.dart';
import 'package:fencing_tracker/presentation/screens/history/history_screen.dart';
import 'package:fencing_tracker/presentation/screens/home/home_screen.dart';
import 'package:fencing_tracker/presentation/screens/main_screen.dart';
import 'package:fencing_tracker/presentation/screens/practice/create_match_screen.dart';
import 'package:fencing_tracker/presentation/screens/practice/practice_match_detail.dart';
import 'package:fencing_tracker/presentation/screens/practice/practice_screen.dart';
import 'package:fencing_tracker/presentation/screens/standings/standings_screen.dart';
import 'package:fencing_tracker/presentation/screens/stats/stats_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  navigatorKey: GlobalKey<NavigatorState>(),
  routes: [
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(
        code: state.queryParameters['code'],
      ),
    ),
    GoRoute(
      path: '/password',
      builder: (context, state) => PasswordScreen(),
    ),
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) => MainScreen(child: child),
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) => const HomeScreen(),
            routes: [
              GoRoute(
                path: 'fullstandings',
                builder: (context, state) => StandingsScreen(
                  displayRatio: state.extra,
                ),
              ),
              GoRoute(
                path: 'help',
                builder: (context, state) => const HelpScreen(),
              ),
              GoRoute(
                path: 'admin',
                builder: (context, state) => const AdminScreen(),
              ),
            ]),
        GoRoute(
          path: '/currentpractice',
          builder: (context, state) => PracticeScreen(),
          routes: [
            GoRoute(
              path: 'creatematch',
              builder: (context, state) => const CreateMatchScreen(),
            ),
            GoRoute(
              path: 'matchdetail',
              builder: (context, state) =>
                  PracticeMatchDetail(matchesObject: state.extra!),
            ),
          ],
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const Center(
            child: HistoryScreen(),
          ),
          routes: [
            GoRoute(
              path: 'practice',
              redirect: (context, state) =>
                  state.extra == null ? '/history' : null,
              builder: (context, state) =>
                  HistoryPracticeScreen(dateObject: state.extra!),
            ),
            GoRoute(
              path: 'opponent',
              redirect: (context, state) =>
                  state.extra == null ? '/history' : null,
              builder: (context, state) =>
                  HistoryOpponent(opponentObject: state.extra!),
            ),
          ],
        ),
        GoRoute(
          path: '/stats',
          builder: (context, state) => const StatsScreen(),
        ),
      ],
    ),
  ],
  redirect: (context, state) async {
    AuthenticationService authenticationService =
        AuthenticationService.fromProvider(context, listen: false);

    if (!authenticationService.tryRefresh) {
      await authenticationService.refresh();
    }

    if (authenticationService.status == AuthenticationStatus.unauthenticated) {
      return state.location.split('?')[0] == '/login' ? null : '/login';
    }

    if (!authenticationService.userHasPassword) {
      return '/password';
    }

    //LOGIN GUARD
    if (state.location == '/login') {
      return '/';
    }

    if (state.location == '/password') {
      return '/';
    }

    //ADMIN GUARD
    if (state.location == '/admin' && authenticationService.user.id != 1) {
      return '/';
    }

    return null;
  },
);
