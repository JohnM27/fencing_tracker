import 'package:fencing_tracker/application/authentication_service.dart';
import 'package:fencing_tracker/presentation/components/custom_bottom_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  final List<CustomBottomNavbarItem> _navItems = [
    CustomBottomNavbarItem(
      icon: const Icon(Icons.home),
      label: 'Accueil',
      path: '/',
    ),
    CustomBottomNavbarItem(
      icon: const Icon(Icons.add_circle_outline),
      label: 'Entraînement',
      path: '/currentpractice',
    ),
    CustomBottomNavbarItem(
      icon: const Icon(Icons.list),
      label: 'Listes',
      path: '/list',
    ),
    CustomBottomNavbarItem(
      icon: const Icon(Icons.admin_panel_settings),
      label: 'Admin',
      path: '/admin',
    ),
  ];

  MainScreen({
    super.key,
    required this.child,
  });

  String? getAppbarTitle(BuildContext context) {
    AuthenticationService authenticationService =
        AuthenticationService.fromProvider(context, listen: false);
    final DateTime currentDate = DateTime.now();

    switch (GoRouter.of(context).location) {
      case '/':
        return authenticationService.user.username;
      case '/currentpractice':
        return 'Entraînement du ${currentDate.day}/${currentDate.month}/${currentDate.year}';

      case '/currentpractice/creatematch':
        return 'Nouveau match';
      default:
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    List<String> routeLocation =
        GoRouter.of(context).location.substring(1).split('/');
    int currentIndex =
        _navItems.indexWhere((item) => item.path == '/${routeLocation.first}');

    String? appbarTitle = getAppbarTitle(context);

    return Scaffold(
      appBar: appbarTitle == null
          ? null
          : AppBar(
              title: Text(appbarTitle),
            ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: _navItems,
        onTap: (index) {
          if (GoRouter.of(context).location != _navItems[index].path) {
            context.go(_navItems[index].path);
          }
        },
      ),
    );
  }
}
