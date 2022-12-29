import 'package:flutter/material.dart';
import 'package:lab_simulation_app/constants.dart';

class FMBottomNavBar extends StatefulWidget {
  const FMBottomNavBar({Key? key}) : super(key: key);

  @override
  State<FMBottomNavBar> createState() => _FMBottomNavBarState();
}


class _FMBottomNavBarState extends State<FMBottomNavBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home_filled),
          icon: Icon(Icons.home_filled),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_outlined),
          activeIcon: Icon(Icons.dashboard),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.account_circle),
          icon: Icon(Icons.account_circle_outlined),
          label: 'Profile',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: kfmPrimaryColor,
      onTap: _onItemTapped,
      selectedLabelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: kfmPrimaryColor,
      ),
      unselectedLabelStyle: const TextStyle(
        fontFamily: 'Poppins',
        color: kfmPrimaryColor,
      ),
    );
  }
}
