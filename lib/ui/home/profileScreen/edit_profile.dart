import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/model/user.dart';

import '../../../components/customized_text_form_field.dart';
import '../../../services/helper.dart';

class EditProfileDetails extends StatefulWidget {
  EditProfileDetails({Key? key,required this.user}) : super(key: key);
  User user;

  @override
  State<EditProfileDetails> createState() => _EditProfileDetailsState();
}

class _EditProfileDetailsState extends State<EditProfileDetails> {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? fullName, year, branch;

  final List<String> branchNames = [
    'Electrical Engineering',
    'Computer Science Engineering',
    'Civil Engineering',
    'Mechanical Engineering',
  ];

  final List<String> yearNames = [
    'First Year',
    'Second Year',
    'Third Year',
    'Final Year',
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(appBar: AppBar(
      title: const Text(
        'Edit Profile Details',
        style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: kPrimaryColor,
      centerTitle: true,
    ),
    body: Padding(
      padding:
      EdgeInsets.only(left: size.width * 0.05, right: size.width * 0.05),
      child: SingleChildScrollView(
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
              readOnly: false,
              validator: validateName,
              onSaved: (String? val) {
                fullName = val;
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
            DropdownButtonFormField2(
              decoration: InputDecoration(
                fillColor: Colors.white,
                isDense: false,
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: kPrimaryColor)),
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: kPrimaryColor)),
              ),
              isExpanded: true,
              hint: Text(
                widget.user.year,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    color: Color(0xFF555555)),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: kPrimaryColor,
              ),
              iconSize: 30,
              buttonHeight: 60,
              selectedItemHighlightColor:
              kPrimaryLightColor,
              buttonPadding: const EdgeInsets.only(
                  left: 20, right: 10),
              dropdownDecoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10),
              ),
              items: yearNames
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Color(0xFF555555),
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                  ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select the year.';
                }
              },
              onChanged: (value) {
                year = value.toString();
              },
              onSaved: (value) {
                year = value.toString();
              },
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
            DropdownButtonFormField2(
              decoration: InputDecoration(
                fillColor: Colors.white,
                isDense: false,
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: kPrimaryColor)),
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: kPrimaryColor)),
              ),
              isExpanded: true,
              hint: Text(
                widget.user.branch,
                style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    color: Color(0xFF555555)),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: kPrimaryColor,
              ),
              iconSize: 30,
              buttonHeight: 60,
              selectedItemHighlightColor:
              kPrimaryLightColor,
              buttonPadding: const EdgeInsets.only(
                  left: 20, right: 10),
              dropdownDecoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(10),
              ),
              items: branchNames
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        color: Color(0xFF555555),
                        fontFamily: "Poppins",
                        fontSize: 16,
                      ),
                    ),
                  ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select the branch.';
                }
              },
              onChanged: (value) {
                branch = value.toString();
              },
              onSaved: (value) {
                branch = value.toString();
              },
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            ElevatedButton(
              onPressed: () {
                print(fullName);

                // firestore
                //     .collection(usersCollection)
                //     .doc(widget.user.userID)
                //     .update({'fullName':fullName})
                //     .then((document) {
                //   return widget.user;
                // });
                // FirebaseFirestore.instance
                //     .collection('users')
                //     .doc(widget.user.userID)
                //     .get()
                //     .then((document) {
                //   return widget.user;
                // });
                // print(widget.user.fullName);
                },
              child: const Text(
                "Make Changes",
                style: TextStyle(fontFamily: "Poppins", fontSize: 21),
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
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
      ),
    ),);
  }
}
