import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar(
      {super.key, required this.selected, required this.onDestinationSelected});

  final int selected;
  final void Function(int) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: const [
        NavigationDestination(icon: Icon(Icons.login), label: 'Login'),
        NavigationDestination(icon: Icon(Icons.logout), label: 'Logout'),
        NavigationDestination(icon: Icon(Icons.person), label: 'Users'),
      ],
      selectedIndex: selected,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
