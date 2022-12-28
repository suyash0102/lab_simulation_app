import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/about_us.dart';
import 'package:lab_simulation_app/ui/auth/authentication_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../model/user.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: size.height * 0.08,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.08),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.close,
                      color: kPrimaryColor,
                      size: size.width * 0.1,
                    ))),
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          Row(
            children: [
              Container(
                  padding: EdgeInsets.only(left: size.width * 0.02),
                  width: size.width * 0.25,
                  child: Image.asset('assets/images/profile.png')),
              SizedBox(
                width: size.width * 0.03,
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: size.width * 0.035),
                    child: Text(
                      user.fullName,
                      style: TextStyle(
                          fontFamily: "Poppins",
                          color: Colors.black,
                          fontSize: size.width * 0.04,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Text(
                    user.email,
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: Colors.black,
                        fontSize: size.width * 0.02,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          const Divider(
            thickness: 1.5,
            indent: 20,
            endIndent: 20,
            color: Colors.black26,
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.settings,
                    size: size.width * 0.09,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    "Settings",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: kPrimaryColor,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: GestureDetector(
              onTap: () {},
              child: Row(
                children: [
                  Icon(
                    Icons.notifications,
                    size: size.width * 0.09,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    "Notification",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: kPrimaryColor,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: GestureDetector(
              onTap: () => onButtonTap(Share.whatsapp),
              child: Row(
                children: [
                  Icon(
                    Icons.share_outlined,
                    size: size.width * 0.09,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    "Share App",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: kPrimaryColor,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: GestureDetector(
              onTap:_launchURL,
              child: Row(
                children: [
                  Icon(
                    Icons.web,
                    size: size.width * 0.09,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    "Our Website",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: kPrimaryColor,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Padding(
            padding: EdgeInsets.only(left: size.width * 0.05),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const AboutUs();
                    },
                  ),
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.people_rounded,
                    size: size.width * 0.09,
                    color: kPrimaryColor,
                  ),
                  SizedBox(
                    width: size.width * 0.03,
                  ),
                  Text(
                    "About Us",
                    style: TextStyle(
                        fontFamily: "Poppins",
                        color: kPrimaryColor,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<AuthenticationBloc>().add(LogoutEvent());
              },
              child: Text(
                "LOGOUT",
                style: TextStyle(
                    fontFamily: "Poppins", fontSize: size.width * 0.065),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.025,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              'UI is under development',
              style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w300,
                fontSize: size.width * 0.03,
              ),
            ),
          ),
          // ListTile(
          //   title: Text(
          //     'Logout',
          //     style: TextStyle(
          //         color: isDarkMode(context)
          //             ? Colors.grey.shade50
          //             : Colors.grey.shade900),
          //   ),
          //   leading: Transform.rotate(
          //     angle: pi / 1,
          //     child: Icon(
          //       Icons.exit_to_app,
          //       color: isDarkMode(context)
          //           ? Colors.grey.shade50
          //           : Colors.grey.shade900,
          //     ),
          //   ),
          //   onTap: () {
          //     context.read<AuthenticationBloc>().add(LogoutEvent());
          //   },
          // ),
          // ListTile(
          //   title: Text(
          //     'About Us',
          //     style: TextStyle(
          //         color: isDarkMode(context)
          //             ? Colors.grey.shade50
          //             : Colors.grey.shade900),
          //   ),
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) {
          //           return const AboutUs();
          //         },
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
  Future<void> onButtonTap(Share share) async {
    String msg =
        'Pocket Friendly Lab Simulation App!!\nCheck out the app now \nhttps://play.google.com/store/apps/details?id=com.synchronizers.lab_simulation_app';
    String? response;
    final FlutterShareMe flutterShareMe = FlutterShareMe();
    switch (share) {
      case Share.whatsapp:
        response = await flutterShareMe.shareToWhatsApp(msg: msg);
        break;
      case Share.whatsapp_business:
        response = await flutterShareMe.shareToWhatsApp(msg: msg);
        break;
      case Share.share_system:
        response = await flutterShareMe.shareToSystem(msg: msg);
        break;
      case Share.whatsapp_personal:
        response = await flutterShareMe.shareWhatsAppPersonalMessage(
            message: msg, phoneNumber: 'phone-number-with-country-code');
        break;
      case Share.share_instagram:
      // TODO: Handle this case.
        break;
      case Share.share_telegram:
      // TODO: Handle this case.
        break;
    }
    debugPrint(response);
  }
}
enum Share {
  whatsapp,
  whatsapp_personal,
  whatsapp_business,
  share_system,
  share_instagram,
  share_telegram
}


_launchURL() async {
  const url = 'https://synchronizers.xyz';
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri,mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch $url';
  }
}