import 'package:flutter/material.dart';
import 'package:lab_simulation_app/components/customized_text_form_field.dart';
import 'package:lab_simulation_app/model/user.dart';
import 'package:lab_simulation_app/services/helper.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, required this.user, }) : super(key: key);
  final User user;


  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding:  EdgeInsets.only(left: size.width*0.05,right: size.width*0.05),
      child: Column(children: [
        SizedBox(height: size.height*0.03,),
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
          height: size.height * 0.001,
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
        Text(
          'Index 2: Profile',
        ),
      ],),
    );
  }
}
