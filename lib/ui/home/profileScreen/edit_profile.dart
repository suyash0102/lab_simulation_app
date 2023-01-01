import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/model/user.dart';
import 'package:lab_simulation_app/ui/auth/launcherScreen/launcher_screen.dart';

import '../../../components/customized_text_form_field.dart';
import '../../../services/helper.dart';

class EditProfileDetails extends StatefulWidget {
  EditProfileDetails({Key? key, required this.user}) : super(key: key);
  User user;

  @override
  State<EditProfileDetails> createState() => _EditProfileDetailsState();
}

class _EditProfileDetailsState extends State<EditProfileDetails> {
  late File image;
  String uploadFileUrl ='';
  String uploadFileUrlCAdmin = "https://i.ibb.co/VHB6y9Q/camera-image.png";

  // late String profileImageUrl =
  //     'https://firebasestorage.googleapis.com/v0/b/lsapp-68019.appspot.com/o/ProfileImages%2Fee.2019.spdahake%40bitwardha.ac.in?alt=media&token=93974ab8-bf83-48d3-ad67-6176ca7b2a6e';
  // static FirebaseFirestore firestore = FirebaseFirestore.instance;
  String? fullName, year, branch;
  final picker = ImagePicker();

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctxt) {
          return SafeArea(
              child: Container(
            child: ListTile(
                leading: new Icon(Icons.photo_library),
                title: new Text('Photo Library'),
                onTap: () {
                  _imgFromGallery();
                  Navigator.of(context).pop();
                }),
          ));
        });
  }

  Future _imgFromGallery() async {
    final pickedFile = await picker.pickImage(
        imageQuality: 100,
        source: ImageSource.gallery,
        maxWidth: 400,
        maxHeight: 400);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
    uploadFile(image);
  }

  Future uploadFile(File img) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('ProfileImages/${widget.user.email}');
    await ref.putFile(img).whenComplete(() {
      ref.getDownloadURL().then((fileUrl) {
        print(fileUrl);
        setState(() {
          // FirebaseFirestore.instance
          //     .collection('users')
          //     .doc(widget.user.userID)
          //     .update({
          //   'profileImageUrl': fileUrl,
          // });
          uploadFileUrl = fileUrl;
        });
      });
    });
  }

  Future updateDetails() async {
    // print(fileUrl);
    setState(() {
      FirebaseFirestore.instance
          .collection('users')
          .doc(widget.user.userID)
          .update({
        'profileImageUrl': uploadFileUrl,
        'fullName': fullName,
        'year': year,
        'branch': branch,
      });
      uploadFileUrl = uploadFileUrl;
    });
  }

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
    return Scaffold(
      appBar: AppBar(
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
              GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: SizedBox(
                  child: widget.user.profileImageUrl ==
                          uploadFileUrl
                      ? CircleAvatar(
                          radius: size.width * 0.3,
                          backgroundImage:
                              NetworkImage(widget.user.profileImageUrl),
                        )
                      : CircleAvatar(
                          radius: size.width * 0.3,
                          backgroundImage: NetworkImage(uploadFileUrl),
                        ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: TextButton(
                  child: const Text(
                    "Add Profile Pic",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.purple,
                      fontFamily: "Poppins",
                    ),
                  ),
                  onPressed: () {
                    _showPicker(context);
                  },
                ),
              ),
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
                onChanged: (String? val) {
                  fullName = val;
                },
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
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: kPrimaryColor)),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: kPrimaryColor)),
                ),
                isExpanded: true,
                hint: Text(
                  widget.user.year,
                  style: const TextStyle(
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
                selectedItemHighlightColor: kPrimaryLightColor,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                items: yearNames
                    .map((item) => DropdownMenuItem<String>(
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
                  return null;
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
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: kPrimaryColor)),
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: kPrimaryColor)),
                ),
                isExpanded: true,
                hint: Text(
                  widget.user.branch,
                  style: const TextStyle(
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
                selectedItemHighlightColor: kPrimaryLightColor,
                buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                items: branchNames
                    .map((item) => DropdownMenuItem<String>(
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
                  if(fullName==null){
                    fullName=widget.user.fullName;
                  }
                  if(year==null){
                    year=widget.user.year;
                  }
                  if(branch==null){
                    branch=widget.user.branch;
                  }
                  updateDetails();
                  Navigator.pushAndRemoveUntil<void>(
                    context,
                    MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                        const LauncherScreen()),
                    ModalRoute.withName('/'),
                  );
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
      ),
    );
  }
}
