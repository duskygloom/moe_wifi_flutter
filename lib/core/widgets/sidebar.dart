import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  const Sidebar(
      {super.key, required this.selected, required this.onDestinationSelected});

  final int selected;
  final void Function(int) onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.login),
          label: Text('Login'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.logout),
          label: Text('Logout'),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.person),
          label: Text('Users'),
        ),
      ],
      labelType: NavigationRailLabelType.all,

      // groupAlignment: 1,
      // backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      selectedIndex: selected,
      onDestinationSelected: onDestinationSelected,
    );
  }
}
