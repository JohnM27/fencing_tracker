import 'package:fencing_tracker/presentation/components/custom_bottom_navbar_item.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatelessWidget {
  final Widget child;
  final List<CustomBottomNavbarItem> _navItems = [
    CustomBottomNavbarItem(
      icon: const Icon(Icons.home),
      label: 'Home',
      path: '/',
    ),
    CustomBottomNavbarItem(
      icon: const Icon(Icons.add_circle_outline),
      label: 'Practice',
      path: '/currentpractice',
    ),
    CustomBottomNavbarItem(
      icon: const Icon(Icons.list),
      label: 'Lists',
      path: '/list',
    ),
    CustomBottomNavbarItem(
      icon: const Icon(Icons.show_chart),
      label: 'Stats',
      path: '/stats',
    ),
  ];

  MainScreen({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    int currentIndex = _navItems
        .indexWhere((item) => item.path == GoRouter.of(context).location);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        // backgroundColor: Colors.deepPurple[100],
        currentIndex: currentIndex,
        items: _navItems,
        onTap: (index) {
          if (currentIndex != index) {
            context.go(_navItems[index].path);
          }
        },
      ),
    );
  }
}
