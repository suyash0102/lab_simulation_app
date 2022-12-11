import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/services/helper.dart';
import 'package:lab_simulation_app/ui/about_us.dart';
import 'package:lab_simulation_app/ui/auth/authentication_bloc.dart';

class LeftDrawer extends StatelessWidget {
  const LeftDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: kPrimaryColor,
            ),
            child: Text(
              'Name',
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            title: Text(
              'Logout',
              style: TextStyle(
                  color: isDarkMode(context)
                      ? Colors.grey.shade50
                      : Colors.grey.shade900),
            ),
            leading: Transform.rotate(
              angle: pi / 1,
              child: Icon(
                Icons.exit_to_app,
                color: isDarkMode(context)
                    ? Colors.grey.shade50
                    : Colors.grey.shade900,
              ),
            ),
            onTap: () {
              context.read<AuthenticationBloc>().add(LogoutEvent());
            },
          ),
          ListTile(
            title: Text(
              'About Us',
              style: TextStyle(
                  color: isDarkMode(context)
                      ? Colors.grey.shade50
                      : Colors.grey.shade900),
            ),
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
          ),
        ],
      ),
    );
  }
}
