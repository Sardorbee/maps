import 'package:dio_example/services/location_service.dart';
import 'package:dio_example/services/provider/tab_provider.dart';
import 'package:dio_example/ui/contribute_screen/contribute.dart';
import 'package:dio_example/ui/go_screen/go_screen.dart';
import 'package:dio_example/ui/maps_screen/maps_screen.dart';
import 'package:dio_example/ui/saved_screen/saved_screen.dart';
import 'package:dio_example/ui/updates_screen/updates.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({super.key, required this.lat, required this.long});
  final double lat;
  final double long;

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  initLocation() async {
    await initLocationService(context);
  }


  late List<Widget> screens;

  @override
  void initState() {
    initLocation();

    screens = [
      MapScreen(lat: widget.lat, long: widget.long),
      const GoScreen(),
      const SavedScreen(),
      const ContributeScreen(),
      const UpdatesScreen(),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: context.watch<TabProvider>().currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 30,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: context.watch<TabProvider>().currentIndex,
        onTap: (index) {
          context.read<TabProvider>().updateTab(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.explore,
              color: Colors.grey,
            ),
            label: 'Explore',
            activeIcon: Icon(
              Icons.explore,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_bus,
              color: Colors.grey,
            ),
            label: "Go",
            activeIcon: Icon(
              Icons.directions_bus,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.bookmark_outline,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.bookmark_outline,
              color: Colors.blue,
            ),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.grey,
            ),
            label: 'Contribute',
            activeIcon: Icon(
              Icons.add_circle_outline,
              color: Colors.blue,
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
              color: Colors.grey,
            ),
            label: 'Updates',
            activeIcon: Icon(
              Icons.notifications,
              color: Colors.blue,
            ),
          ),
        ],
      ),
    );
  }
}
