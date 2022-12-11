import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_simulation_app/components/left_drawer.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/model/user.dart';
import 'package:lab_simulation_app/services/helper.dart';
import 'package:lab_simulation_app/ui/auth/authentication_bloc.dart';
import 'package:lab_simulation_app/ui/auth/welcome/welcome_screen.dart';
import 'package:lab_simulation_app/ui/coming_soon_screen.dart';
import 'package:lab_simulation_app/ui/home/profile_screen.dart';
import 'package:lab_simulation_app/ui/labsScreen/labs_sub_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;

  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late User user;

  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

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
    List<Widget> widgetOptions = <Widget>[
      Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            children: [
              SizedBox(
                width: size.width * 0.02,
              ),
              Card(
                elevation: 8,
                child: Container(
                  width: size.width * 0.45,
                  height: size.height * 0.227,
                  child: Column(
                    children: [
                      Container(
                          width: size.width * 0.45,
                          child: Image.asset('assets/images/mechanical.png')),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.02, right: size.width * 0.02),
                        child: Text(
                          'Mechanical Engineering',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        'Number of Labs: xx',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ComingSoonScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.01))),
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.01),
                            child: Text(
                              'Learn More',
                              style: TextStyle(
                                  fontFamily: 'Poppins', color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Card(
                elevation: 8,
                child: Container(
                  width: size.width * 0.45,
                  height: size.height * 0.227,
                  child: Column(
                    children: [
                      Container(
                          width: size.width * 0.45,
                          child: Image.asset('assets/images/electrical.png')),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.02, right: size.width * 0.02),
                        child: Text(
                          'Electrical Engineering',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        'Number of Labs: xx',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const LabsSubScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.01))),
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.01),
                            child: Text(
                              'Learn More',
                              style: TextStyle(
                                  fontFamily: 'Poppins', color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: size.width * 0.02,
              ),
              Card(
                elevation: 8,
                child: Container(
                  width: size.width * 0.45,
                  height: size.height * 0.227,
                  child: Column(
                    children: [
                      Container(
                          width: size.width * 0.45,
                          child: Image.asset('assets/images/civil.png')),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.02, right: size.width * 0.02),
                        child: Text(
                          'Civil Engineering',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        'Number of Labs: xx',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ComingSoonScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.01))),
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.01),
                            child: Text(
                              'Learn More',
                              style: TextStyle(
                                  fontFamily: 'Poppins', color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width * 0.02,
              ),
              Card(
                elevation: 8,
                child: Container(
                  width: size.width * 0.45,
                  height: size.height * 0.227,
                  child: Column(
                    children: [
                      Container(
                          width: size.width * 0.45,
                          child: Image.asset('assets/images/computer.png')),
                      Padding(
                        padding: EdgeInsets.only(
                            left: size.width * 0.02, right: size.width * 0.02),
                        child: Text(
                          'Computer Science',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      Text(
                        'Number of Labs: xx',
                        style: TextStyle(
                            fontFamily: 'Poppins', fontWeight: FontWeight.w200),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const ComingSoonScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(size.width * 0.01))),
                          child: Padding(
                            padding: EdgeInsets.all(size.width * 0.01),
                            child: Text(
                              'Learn More',
                              style: TextStyle(
                                  fontFamily: 'Poppins', color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          // user.profilePictureURL == ''
          //     ? CircleAvatar(
          //   radius: 35,
          //   backgroundColor: Colors.grey.shade400,
          //   child: ClipOval(
          //     child: SizedBox(
          //       width: 70,
          //       height: 70,
          //       child: Image.asset(
          //         'assets/images/placeholder.jpg',
          //         fit: BoxFit.cover,
          //       ),
          //     ),
          //   ),
          // )
          //     : displayCircleImage(user.profilePictureURL, 80, false),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.fullName),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.email),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(user.userID),
          ),
        ],
      ),
      Text(
        'Index 1: ---',
        style: optionStyle,
      ),
      ProfileScreen()
    ];
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        }
      },
      child: Scaffold(
        drawer: const LeftDrawer(),
        appBar: AppBar(
          title: const Text(
            'Lab Simulation App',
            style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: kPrimaryColor,
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
              icon: Icon(Icons.wallet),
              label: '---',
            ),
            BottomNavigationBarItem(
              activeIcon: Icon(Icons.account_circle),
              icon: Icon(Icons.account_circle_outlined),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: kPrimaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
