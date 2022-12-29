import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_simulation_app/components/left_drawer.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/model/user.dart';
import 'package:lab_simulation_app/services/helper.dart';
import 'package:lab_simulation_app/ui/auth/authentication_bloc.dart';
import 'package:lab_simulation_app/ui/auth/welcome/welcome_screen.dart';
import 'package:lab_simulation_app/ui/coming_soon_screen.dart';
import 'package:lab_simulation_app/ui/faculty_module/screens/fm_home_screen.dart';
import 'package:lab_simulation_app/ui/home/dashboard/dashboard_screen.dart';
import 'package:lab_simulation_app/ui/home/profileScreen/profile_screen.dart';
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
        // mainAxisAlignment: MainAxisAlignment.center,
        // mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: orientation == Orientation.portrait
                ? size.height * 0.02
                : size.height * 0.01,
          ),
          Row(
            children: [
              SizedBox(
                width: orientation == Orientation.portrait
                    ? size.width * 0.02
                    : size.width * 0.01,
              ),
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
                          child: Image.asset('assets/images/mechanical.png')),
                      Padding(
                        padding: EdgeInsets.only(
                            left: orientation == Orientation.portrait
                                ? size.width * 0.02
                                : size.width * 0.005,
                            right: orientation == Orientation.portrait
                                ? size.width * 0.02
                                : size.width * 0.005),
                        child: Text(
                          'Mechanical Engineering',
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
                                return const ComingSoonScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
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
              SizedBox(
                width: orientation == Orientation.portrait
                    ? size.width * 0.02
                    : size.width * 0.01,
              ),
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
                                return const LabsSubScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
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
                : size.height * 0.01,
          ),
          Row(
            children: [
              SizedBox(
                width: orientation == Orientation.portrait
                    ? size.width * 0.02
                    : size.width * 0.01,
              ),
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
                          child: Image.asset('assets/images/civil.png')),
                      Padding(
                        padding: EdgeInsets.only(
                            left: orientation == Orientation.portrait
                                ? size.width * 0.02
                                : size.width * 0.005,
                            right: orientation == Orientation.portrait
                                ? size.width * 0.02
                                : size.width * 0.005),
                        child: Text(
                          'Civil Engineering',
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
                                return const ComingSoonScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
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
              SizedBox(
                width: orientation == Orientation.portrait
                    ? size.width * 0.02
                    : size.width * 0.01,
              ),
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
                          child: Image.asset('assets/images/computer.png')),
                      Padding(
                        padding: EdgeInsets.only(
                            left: orientation == Orientation.portrait
                                ? size.width * 0.02
                                : size.width * 0.005,
                            right: orientation == Orientation.portrait
                                ? size.width * 0.02
                                : size.width * 0.005),
                        child: Text(
                          'Computer Science',
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
                                return const ComingSoonScreen();
                              },
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
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
                            ? size.height * 0.01
                            : size.height * 0.01,
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
          SizedBox(
            height: orientation == Orientation.portrait
                ? size.height * 0.01
                : size.height * 0.00,
          ),
          orientation == Orientation.portrait
              ? Text(
                  user.fullName,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                  ),
                )
              : const Text(
                  '',
                  style: TextStyle(
                    fontSize: 0,
                  ),
                ),
          orientation == Orientation.portrait
              ? Text(user.email,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                  ))
              : const Text(
                  '',
                  style: TextStyle(fontSize: 0),
                ),
          // orientation == Orientation.portrait
          //     ? Text(user.userID,
          //         style: const TextStyle(
          //           fontFamily: 'Poppins',
          //         ))
          //     : const Text(
          //         '',
          //         style: TextStyle(fontSize: 0),
          //       ),
          SizedBox(height: size.height*0.03,),
          Text('You are an Admin',style: TextStyle(color: kPrimaryColor, fontFamily: "Poppins",fontSize: size.width*0.05,fontWeight: FontWeight.w700),),
          SizedBox(height: size.height*0.04,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
            child: SizedBox(
              height: size.height * 0.05,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return FMHomeScreen(user: user);
                      },
                    ),
                  );                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor, elevation: 0),
                child: Text(
                  "Faculty Dashboard",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Poppins",
                      fontSize: size.width * 0.04),
                ),
              ),
            ),
          ),
        ],
      ),
      DashboardScreen(user: widget.user),
      ProfileScreen(
        user: widget.user,
      )
    ];
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state.authState == AuthState.unauthenticated) {
          pushAndRemoveUntil(context, const WelcomeScreen(), false);
        }
      },
      child: Scaffold(
          drawer: LeftDrawer(
            user: user,
          ),
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
                activeIcon: Icon(Icons.dashboard),
                icon: Icon(Icons.dashboard_outlined),
                label: 'Dashboard',
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
            selectedLabelStyle: const TextStyle(
              fontFamily: 'Poppins',
              color: kPrimaryColor,
            ),
            unselectedLabelStyle:  const TextStyle(
              fontFamily: 'Poppins',
              color: kPrimaryColor,
            ),
          )),
    );
  }
}
