import 'package:flutter/material.dart';
import 'package:lab_simulation_app/components/left_drawer.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/model/user.dart';
import 'package:lab_simulation_app/ui/faculty_module/screens/fm_lab_dashboard.dart';
import 'package:lab_simulation_app/ui/faculty_module/screens/fm_lab_sub_screen.dart';
import 'package:lab_simulation_app/ui/faculty_module/screens/viva_voice_marking_screen.dart';
import 'package:lab_simulation_app/ui/home/profileScreen/profile_screen.dart';

class FMHomeScreen extends StatefulWidget {
  final User user;

  const FMHomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<FMHomeScreen> {
  late User user;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    user = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    List<Widget> widgetOptions = <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: orientation == Orientation.portrait
                ? size.height * 0.02
                : size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                elevation: 8,
                child: SizedBox(
                  width: orientation == Orientation.portrait
                      ? size.width * 0.45
                      : size.width * 0.14,
                  height: orientation == Orientation.portrait
                      ? size.height * 0.227
                      : size.height * 0.29,
                  child: Column(
                    children: [
                      SizedBox(
                          width: orientation == Orientation.portrait
                              ? size.width * 0.45
                              : size.width * 0.14,
                          child: Image.asset('assets/images/electrical.png')),
                      Padding(
                        padding: EdgeInsets.only(
                            left: orientation == Orientation.portrait
                                ? size.width * 0.02
                                : size.width * 0.005,
                            right: orientation == Orientation.portrait
                                ? size.width * 0.02
                                : size.width * 0.005),
                        child: Text(
                          'Electrical Engineering',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: orientation == Orientation.portrait
                                  ? size.width * 0.031
                                  : size.width * 0.01,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        'Number of Labs: xx',
                        style: TextStyle(
                            fontSize: orientation == Orientation.portrait
                                ? size.width * 0.03
                                : size.width * 0.01,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: orientation == Orientation.portrait
                            ? size.height * 0.02
                            : size.height * 0.01,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const FMLabsSubScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kfmPrimaryColor,
                              borderRadius: BorderRadius.all(Radius.circular(
                                  orientation == Orientation.portrait
                                      ? size.width * 0.01
                                      : size.width * 0.01))),
                          child: Padding(
                            padding: EdgeInsets.all(
                                orientation == Orientation.portrait
                                    ? size.width * 0.01
                                    : size.width * 0.005),
                            child: Text(
                              'Learn More',
                              style: TextStyle(
                                  fontSize: orientation == Orientation.portrait
                                      ? size.width * 0.035
                                      : size.width * 0.014,
                                  fontFamily: 'Poppins',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: orientation == Orientation.portrait
                            ? size.height * 0.02
                            : size.height * 0.01,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: orientation == Orientation.portrait
                ? size.height * 0.01
                : size.height * 0.00,
          ),
        ],
      ),
      FMDashboardScreen(user: widget.user),
     VivaVoiceMarkingScreen()
    ];
    return Scaffold(
        drawer: LeftDrawer(
          user: user,
        ),
        appBar: AppBar(
          title: const Text(
            'Lab Simulation App',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kfmPrimaryColor,
          centerTitle: true,
        ),
        body: widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
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
        ));
  }
}
