import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_simulation_app/components/already_have_an_account.dart';
import 'package:lab_simulation_app/components/customized_text_form_field.dart';
import 'package:lab_simulation_app/components/or_divider.dart';
import 'package:lab_simulation_app/components/sigin_signup_with_google.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/services/helper.dart';
import 'package:lab_simulation_app/ui/auth/authentication_bloc.dart';
import 'package:lab_simulation_app/ui/auth/login/login_screen.dart';
import 'package:lab_simulation_app/ui/auth/signUp/sign_up_bloc.dart';
import 'package:lab_simulation_app/ui/home/home_screen.dart';
import 'package:lab_simulation_app/ui/loading_cubit.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State createState() => _SignUpState();
}

class _SignUpState extends State<SignUpScreen> {
  Uint8List? _imageData;
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  String? fullName, email, password, confirmPassword, year, branch;
  AutovalidateMode _validate = AutovalidateMode.disabled;
  bool acceptEULA = false;

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

  String? selectedValue;
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<SignUpBloc>(
      create: (context) => SignUpBloc(),
      child: Builder(
        builder: (context) {
          if (!kIsWeb && Platform.isAndroid) {
            context.read<SignUpBloc>().add(RetrieveLostDataEvent());
          }
          return MultiBlocListener(
            listeners: [
              BlocListener<AuthenticationBloc, AuthenticationState>(
                listener: (context, state) {
                  context.read<LoadingCubit>().hideLoading();
                  if (state.authState == AuthState.authenticated) {
                    pushAndRemoveUntil(
                        context, HomeScreen(user: state.user!), false);
                  } else {
                    showSnackBar(
                        context,
                        state.message ??
                            'Couldn\'t sign up, Please try again.');
                  }
                },
              ),
              BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) async {
                  if (state is ValidFields) {
                    await context.read<LoadingCubit>().showLoading(
                        context, 'Creating new account, Please wait...', false);
                    if (!mounted) return;
                    context
                        .read<AuthenticationBloc>()
                        .add(SignupWithEmailAndPasswordEvent(
                          emailAddress: email!,
                          password: password!,
                          imageData: _imageData,
                          branch: branch,
                          fullName: fullName,
                          year: year,
                        ));
                  } else if (state is SignUpFailureState) {
                    showSnackBar(context, state.errorMessage);
                  }
                },
              ),
            ],
            child: Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: BlocBuilder<SignUpBloc, SignUpState>(
                    buildWhen: (old, current) =>
                        current is SignUpFailureState && old != current,
                    builder: (context, state) {
                      if (state is SignUpFailureState) {
                        _validate = AutovalidateMode.onUserInteraction;
                      }
                      return Form(
                        key: _key,
                        autovalidateMode: _validate,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                            Text(
                              "Sign Up".toUpperCase(),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Hubballi",
                                  fontSize: 36),
                            ),
                            const SizedBox(height: defaultPadding),
                            Row(
                              children: [
                                const Spacer(),
                                Expanded(
                                  flex: 12,
                                  child: Image.asset(
                                      "assets/images/signup_ills.png"),
                                ),
                                const Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                Spacer(),
                                Expanded(
                                  flex: 12,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: defaultPadding),
                                      SigninSinupGoogle(
                                        text: "Sign Up with Google",
                                      ),
                                      OrDivider(),
                                      SizedBox(
                                        height: size.height * 0.02,
                                      ),
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
                                            readOnly: false,
                                            validator: validateName,
                                            onSaved: (String? val) {
                                              fullName = val;
                                            },
                                            hintText: "XXXXXXXX",
                                            obscureText: false,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: size.width * 0.335,
                                        ),
                                        child: Text(
                                          "Enter College Email ID:",
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
                                            readOnly: false,
                                            validator: validateEmail,
                                            onSaved: (String? val) {
                                              email = val;
                                            },
                                            hintText:
                                                "ee.20XX.xyz@bitwardha.ac.in",
                                            obscureText: false,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: size.width * 0.5,
                                        ),
                                        child: Text(
                                          "Select Branch:",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.purple,
                                            fontFamily: "Poppins",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.006,
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
                                        hint: const Text(
                                          'Select Your Branch',
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
                                        height: size.height * 0.003,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: size.width * 0.47,
                                        ),
                                        child: Text(
                                          "Enter Password:",
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
                                            readOnly: false,
                                            controller: _passwordController,
                                            validator: validatePassword,
                                            onSaved: (String? val) {
                                              password = val;
                                            },
                                            hintText: "XXXXXXXX",
                                            obscureText: true,
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: size.width * 0.4,
                                        ),
                                        child: Text(
                                          "Confirm Password:",
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
                                            readOnly: false,
                                            onFieldSubmitted: (_) => context
                                                .read<SignUpBloc>()
                                                .add(
                                                  ValidateFieldsEvent(_key,
                                                      acceptEula: acceptEULA),
                                                ),
                                            obscureText: true,
                                            validator: (val) =>
                                                validateConfirmPassword(
                                                    _passwordController.text,
                                                    val),
                                            onSaved: (String? val) {
                                              confirmPassword = val;
                                            },
                                            hintText: "XXXXXXXX",
                                          )),
                                      Padding(
                                        padding: EdgeInsets.only(
                                          right: size.width * 0.55,
                                        ),
                                        child: const Text(
                                          "Select Year:",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.purple,
                                            fontFamily: "Poppins",
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.006,
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
                                        hint: const Text(
                                          'Select Your Year',
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
                                      const SizedBox(height: 24),
                                      ListTile(
                                        trailing: BlocBuilder<SignUpBloc,
                                            SignUpState>(
                                          buildWhen: (old, current) =>
                                              current is EulaToggleState &&
                                              old != current,
                                          builder: (context, state) {
                                            if (state is EulaToggleState) {
                                              acceptEULA = state.eulaAccepted;
                                            }
                                            return Checkbox(
                                              onChanged: (value) => context
                                                  .read<SignUpBloc>()
                                                  .add(
                                                    ToggleEulaCheckboxEvent(
                                                      eulaAccepted: value!,
                                                    ),
                                                  ),
                                              activeColor: kPrimaryColor,
                                              value: acceptEULA,
                                            );
                                          },
                                        ),
                                        title: RichText(
                                          textAlign: TextAlign.left,
                                          text: TextSpan(
                                            children: [
                                              const TextSpan(
                                                text:
                                                    'By creating an account you agree to our ',
                                                style: TextStyle(
                                                    color: Colors.grey),
                                              ),
                                              TextSpan(
                                                style: const TextStyle(
                                                  color: Colors.blueAccent,
                                                ),
                                                text: 'Terms of Use',
                                                recognizer:
                                                    TapGestureRecognizer()
                                                      ..onTap = () async {
                                                        if (await canLaunchUrl(
                                                            Uri.parse(eula))) {
                                                          await launchUrl(
                                                            Uri.parse(eula),
                                                          );
                                                        }
                                                      },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.04,
                                      ),
                                      ElevatedButton(
                                        onPressed: () =>
                                            context.read<SignUpBloc>().add(
                                                  ValidateFieldsEvent(_key,
                                                      acceptEula: acceptEULA),
                                                ),
                                        child: Text(
                                          "Sign Up".toUpperCase(),
                                          style: TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 21),
                                        ),
                                      ),
                                      const SizedBox(height: defaultPadding),
                                      AlreadyHaveAnAccountCheck(
                                        login: false,
                                        press: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) {
                                                return const LoginScreen();
                                              },
                                            ),
                                          );
                                        },
                                      ),
                                      SizedBox(
                                        height: size.height * 0.05,
                                      ),
                                    ],
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 8.0, top: 32, right: 8, bottom: 8),
                            //   child: Stack(
                            //     alignment: Alignment.bottomCenter,
                            //     children: [
                            //       BlocBuilder<SignUpBloc, SignUpState>(
                            //         buildWhen: (old, current) =>
                            //             current is PictureSelectedState &&
                            //             old != current,
                            //         builder: (context, state) {
                            //           if (state is PictureSelectedState) {
                            //             _imageData = state.imageData;
                            //           }
                            //           return state is PictureSelectedState
                            //               ? SizedBox(
                            //                   height: 130,
                            //                   width: 130,
                            //                   child: ClipRRect(
                            //                       borderRadius:
                            //                           BorderRadius.circular(65),
                            //                       child: state.imageData == null
                            //                           ? Image.asset(
                            //                               'assets/images/placeholder.jpg',
                            //                               fit: BoxFit.cover,
                            //                             )
                            //                           : Image.memory(
                            //                               state.imageData!,
                            //                               fit: BoxFit.cover,
                            //                             )),
                            //                 )
                            //               : SizedBox(
                            //                   height: 130,
                            //                   width: 130,
                            //                   child: ClipRRect(
                            //                     borderRadius:
                            //                         BorderRadius.circular(65),
                            //                     child: Image.asset(
                            //                       'assets/images/placeholder.jpg',
                            //                       fit: BoxFit.cover,
                            //                     ),
                            //                   ),
                            //                 );
                            //         },
                            //       ),
                            //       Positioned(
                            //         right: 0,
                            //         child: FloatingActionButton(
                            //           backgroundColor: kPrimaryColor,
                            //           mini: true,
                            //           onPressed: () => _onCameraClick(context),
                            //           child: Icon(
                            //             Icons.camera_alt,
                            //             color: isDarkMode(context)
                            //                 ? Colors.black
                            //                 : Colors.white,
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       top: 16.0, right: 8.0, left: 8.0),
                            //   child: TextFormField(
                            //     textCapitalization: TextCapitalization.words,
                            //     validator: validateName,
                            //     onSaved: (String? val) {
                            //       // firstName = val;
                            //     },
                            //     textInputAction: TextInputAction.next,
                            //     decoration: getInputDecoration(
                            //         hint: 'First Name',
                            //         darkMode: isDarkMode(context),
                            //         errorColor: Theme.of(context).errorColor),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       top: 16.0, right: 8.0, left: 8.0),
                            //   child: TextFormField(
                            //     textCapitalization: TextCapitalization.words,
                            //     validator: validateName,
                            //     onSaved: (String? val) {
                            //       // lastName = val;
                            //     },
                            //     textInputAction: TextInputAction.next,
                            //     decoration: getInputDecoration(
                            //         hint: 'Last Name',
                            //         darkMode: isDarkMode(context),
                            //         errorColor: Theme.of(context).errorColor),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       top: 16.0, right: 8.0, left: 8.0),
                            //   child: TextFormField(
                            //     keyboardType: TextInputType.emailAddress,
                            //     textInputAction: TextInputAction.next,
                            //     validator: validateEmail,
                            //     onSaved: (String? val) {
                            //       email = val;
                            //     },
                            //     decoration: getInputDecoration(
                            //         hint: 'Email',
                            //         darkMode: isDarkMode(context),
                            //         errorColor: Theme.of(context).errorColor),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       top: 16.0, right: 8.0, left: 8.0),
                            //   child: TextFormField(
                            //     obscureText: true,
                            //     textInputAction: TextInputAction.next,
                            //     controller: _passwordController,
                            //     validator: validatePassword,
                            //     onSaved: (String? val) {
                            //       password = val;
                            //     },
                            //     style: const TextStyle(
                            //         height: 0.8, fontSize: 18.0),
                            //     cursorColor: kPrimaryColor,
                            //     decoration: getInputDecoration(
                            //         hint: 'Password',
                            //         darkMode: isDarkMode(context),
                            //         errorColor: Theme.of(context).errorColor),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       top: 16.0, right: 8.0, left: 8.0),
                            //   child: TextFormField(
                            //     textInputAction: TextInputAction.done,
                            //     onFieldSubmitted: (_) =>
                            //         context.read<SignUpBloc>().add(
                            //               ValidateFieldsEvent(_key,
                            //                   acceptEula: acceptEULA),
                            //             ),
                            //     obscureText: true,
                            //     validator: (val) => validateConfirmPassword(
                            //         _passwordController.text, val),
                            //     onSaved: (String? val) {
                            //       confirmPassword = val;
                            //     },
                            //     style: const TextStyle(
                            //         height: 0.8, fontSize: 18.0),
                            //     cursorColor: kPrimaryColor,
                            //     decoration: getInputDecoration(
                            //         hint: 'Confirm Password',
                            //         darkMode: isDarkMode(context),
                            //         errorColor: Theme.of(context).errorColor),
                            //   ),
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       right: 40.0, left: 40.0, top: 40.0),
                            //   child: ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //       fixedSize: Size.fromWidth(
                            //           MediaQuery.of(context).size.width / 1.5),
                            //       backgroundColor: kPrimaryColor,
                            //       padding: const EdgeInsets.only(
                            //           top: 16, bottom: 16),
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(25.0),
                            //         side: const BorderSide(
                            //           color: kPrimaryColor,
                            //         ),
                            //       ),
                            //     ),
                            //     child: const Text(
                            //       'Sign Up',
                            //       style: TextStyle(
                            //         fontSize: 20,
                            //         fontWeight: FontWeight.bold,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     onPressed: () => context.read<SignUpBloc>().add(
                            //           ValidateFieldsEvent(_key,
                            //               acceptEula: acceptEULA),
                            //         ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _onCameraClick(BuildContext context) {
    if (kIsWeb || Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
      context.read<SignUpBloc>().add(ChooseImageFromGalleryEvent());
    } else {
      final action = CupertinoActionSheet(
        title: const Text(
          'Add Profile Picture',
          style: TextStyle(fontSize: 15.0),
        ),
        actions: [
          CupertinoActionSheetAction(
            isDefaultAction: false,
            onPressed: () async {
              Navigator.pop(context);
              context.read<SignUpBloc>().add(ChooseImageFromGalleryEvent());
            },
            child: const Text('Choose from gallery'),
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: false,
            onPressed: () async {
              Navigator.pop(context);
              context.read<SignUpBloc>().add(CaptureImageByCameraEvent());
            },
            child: const Text('Take a picture'),
          )
        ],
        cancelButton: CupertinoActionSheetAction(
            child: const Text('Cancel'),
            onPressed: () => Navigator.pop(context)),
      );
      showCupertinoModalPopup(context: context, builder: (context) => action);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _imageData = null;
    super.dispose();
  }
}
