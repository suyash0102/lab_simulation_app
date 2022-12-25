import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_simulation_app/components/customized_text_form_field.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/model/user.dart';
import 'package:lab_simulation_app/services/helper.dart';
import 'package:lab_simulation_app/ui/auth/authentication_bloc.dart';
import 'package:lab_simulation_app/ui/home/profileScreen/edit_profile.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
    required this.user,
  }) : super(key: key);
  final User user;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding:
          EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.03,
          ),
          Image.asset('assets/images/profile.png'),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Name:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.purple,
                fontFamily: "Poppins",
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.008,
          ),
          CustomizedTextFormField(
            readOnly: true,
            validator: validateName,
            onSaved: (String? val) {
              // fullName = val;
            },
            hintText: widget.user.fullName,
            obscureText: false,
          ),
          SizedBox(
            height: size.height * 0.008,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "College Email ID:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.purple,
                fontFamily: "Poppins",
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.008,
          ),
          CustomizedTextFormField(
            readOnly: true,
            validator: validateName,
            onSaved: (String? val) {
              // fullName = val;
            },
            hintText: widget.user.email,
            obscureText: false,
          ),
          SizedBox(
            height: size.height * 0.008,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Year:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.purple,
                fontFamily: "Poppins",
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.008,
          ),
          CustomizedTextFormField(
            readOnly: true,
            validator: validateName,
            onSaved: (String? val) {
              // fullName = val;
            },
            hintText: widget.user.year,
            obscureText: false,
          ),
          SizedBox(
            height: size.height * 0.008,
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Branch:",
              style: TextStyle(
                fontSize: 18,
                color: Colors.purple,
                fontFamily: "Poppins",
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.008,
          ),
          Column(
            children: [
              CustomizedTextFormField(
                readOnly: true,
                validator: validateName,
                onSaved: (String? val) {
                  // fullName = val;
                },
                hintText: widget.user.branch,
                obscureText: false,
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return EditProfileDetails(user: widget.user,);
                  },
                ),
              );
            },
            child: Text(
              "Edit Profile",
              style: TextStyle(fontFamily: "Poppins", fontSize: 21),
            ),
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          ElevatedButton(
            onPressed: () {
              context.read<AuthenticationBloc>().add(LogoutEvent());
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryLightColor, elevation: 0),
            child: Text(
              "LogOut".toUpperCase(),
              style: const TextStyle(
                  color: Colors.black, fontFamily: "Poppins", fontSize: 21),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            'UI is under development',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w300,
              fontSize: size.width * 0.03,
            ),
          ),
        ],
      ),
    );
  }
}
