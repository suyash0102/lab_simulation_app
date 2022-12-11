import 'package:flutter/material.dart';
import 'package:lab_simulation_app/components/customized_text_form_field.dart';
import 'package:lab_simulation_app/model/user.dart';
import 'package:lab_simulation_app/services/helper.dart';


class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key, }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
late User user;
  @override
  void initState() {
    super.initState();
    // print("Name : ${user.fullName}");
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        child: Column(children: [
          SizedBox(height: size.height*0.03,),
          Image.asset('assets/images/profile.png'),
          Padding(
            padding: EdgeInsets.only(
              right: size.width * 0.54,
            ),
            child: Text(
              "Enter Name:",
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
          Padding(
              padding: EdgeInsets.symmetric(
                  vertical: size.height * 0.01),
              child: CustomizedTextFormField(
                validator: validateName,
                onSaved: (String? val) {
                  // fullName = val;
                },
                hintText: "user.fullName",
                obscureText: false,
              )),
          Text(
            'Index 2: Profile',
          ),
        ],),
      ),
    );
  }
}
