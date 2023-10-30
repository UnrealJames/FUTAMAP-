import 'package:flutter/material.dart';
import 'package:futamap/screens/home/places.dart';
import 'package:futamap/screens/home/saved.dart';
import '../../theme/colors.dart' as futa_map_colors;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double _deviceHeight, _deviceWidth;
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: futa_map_colors.Colors.surface,
      bottomNavigationBar: NavigationBar(
        backgroundColor: futa_map_colors.Colors.surface,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: futa_map_colors.Colors.primaryContainer,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(
              Icons.bookmark,
              color: futa_map_colors.Colors.onPrimaryContainer,
            ),
            icon: Icon(
              Icons.bookmark_border,
              color: futa_map_colors.Colors.onPrimaryContainer,
            ),
            label: 'Saved',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.map,
              color: futa_map_colors.Colors.onPrimaryContainer,
            ),
            icon: Icon(
              Icons.map_outlined,
              color: futa_map_colors.Colors.onPrimaryContainer,
            ),
            label: 'Navigation',
          ),
          NavigationDestination(
            selectedIcon: Icon(
              Icons.location_on,
              color: futa_map_colors.Colors.onPrimaryContainer,
            ),
            icon: Icon(
              Icons.location_on_outlined,
              color: futa_map_colors.Colors.onPrimaryContainer,
            ),
            label: 'Places',
          ),
        ],
      ),
      body: <Widget>[
        const SavedScreen(),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        const PlacesScreen(),
      ][currentPageIndex],
    );
  }
}
