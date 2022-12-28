import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_simulation_app/components/already_have_an_account.dart';
import 'package:lab_simulation_app/components/customized_text_form_field.dart';
import 'package:lab_simulation_app/components/or_divider.dart';
import 'package:lab_simulation_app/components/sigin_signup_with_google.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/services/helper.dart';
import 'package:lab_simulation_app/ui/auth/authentication_bloc.dart';
import 'package:lab_simulation_app/ui/auth/login/login_bloc.dart';
import 'package:lab_simulation_app/ui/auth/resetPasswordScreen/reset_password_screen.dart';
import 'package:lab_simulation_app/ui/auth/signUp/sign_up_screen.dart';
import 'package:lab_simulation_app/ui/home/home_screen.dart';
import 'package:lab_simulation_app/ui/loading_cubit.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  AutovalidateMode _validate = AutovalidateMode.disabled;
  String? email, password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
      child: Builder(builder: (context) {
        return SafeArea(
          child: Scaffold(
            // appBar: AppBar(
            //   backgroundColor: Colors.transparent,
            //   iconTheme: IconThemeData(
            //       color: isDarkMode(context) ? Colors.white : Colors.black),
            //   elevation: 0.0,
            // ),
            body: MultiBlocListener(
              listeners: [
                BlocListener<AuthenticationBloc, AuthenticationState>(
                  listener: (context, state) async {
                    await context.read<LoadingCubit>().hideLoading();
                    if (state.authState == AuthState.authenticated) {
                      if (!mounted) return;
                      pushAndRemoveUntil(
                          context, HomeScreen(user: state.user!), false);
                    } else {
                      if (!mounted) return;
                      showSnackBar(
                          context,
                          state.message ??
                              'Couldn\'t login, Please try again.');
                    }
                  },
                ),
                BlocListener<LoginBloc, LoginState>(
                  listener: (context, state) async {
                    if (state is ValidLoginFields) {
                      await context.read<LoadingCubit>().showLoading(
                          context, 'Logging in, Please wait...', false);
                      if (!mounted) return;
                      context.read<AuthenticationBloc>().add(
                            LoginWithEmailAndPasswordEvent(
                              email: email!,
                              password: password!,
                            ),
                          );
                    }
                  },
                ),
              ],
              child: BlocBuilder<LoginBloc, LoginState>(
                buildWhen: (old, current) =>
                    current is LoginFailureState && old != current,
                builder: (context, state) {
                  if (state is LoginFailureState) {
                    _validate = AutovalidateMode.onUserInteraction;
                  }
                  return Form(
                    key: _key,
                    autovalidateMode: _validate,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          const Text(
                            "LOGIN",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: "Hubballi",
                                fontSize: 36),
                          ),
                          const SizedBox(height: defaultPadding * 2),
                          Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 12,
                                child:
                                    Image.asset("assets/images/login_ills.png"),
                              ),
                              const Spacer(),
                            ],
                          ),
                          const SizedBox(height: defaultPadding * 2),
                          Row(
                            children: [
                              const Spacer(),
                              Expanded(
                                flex: 12,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: size.width * 0.335,
                                      ),
                                      child: const Text(
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
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       top: 32.0, right: 24.0, left: 24.0),
                                    //   child: TextFormField(
                                    //       textAlignVertical: TextAlignVertical.center,
                                    //       textInputAction: TextInputAction.next,
                                    //       validator: validateEmail,
                                    //       onSaved: (String? val) {
                                    //         email = val;
                                    //       },
                                    //       style: const TextStyle(fontSize: 18.0),
                                    //       keyboardType: TextInputType.emailAddress,
                                    //       cursorColor: const Color(colorPrimary),
                                    //       decoration: getInputDecoration(
                                    //           hint: 'Email Address',
                                    //           darkMode: isDarkMode(context),
                                    //           errorColor: Theme.of(context).errorColor)),
                                    // ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: size.width * 0.472,
                                      ),
                                      child: const Text(
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
                                          hintText: "XXXXXXXX",
                                          obscureText: true,
                                          validator: validatePassword,
                                          onSaved: (String? val) {
                                            password = val;
                                          },
                                          onFieldSubmitted: (password) =>
                                              context.read<LoginBloc>().add(
                                                  ValidateLoginFieldsEvent(
                                                      _key)),
                                        )),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    GestureDetector(
                                      onTap: () => push(
                                          context, const ResetPasswordScreen()),
                                      child: const Text(
                                        "Forgot password?",
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: kPrimaryColor,
                                          fontFamily: "Poppins",
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: size.height * 0.01,
                                    ),
                                    Hero(
                                      tag: "login_btn",
                                      child: ElevatedButton(
                                        // final form = _formkey.currentState;
                                        // if (form != null && form.validate()) {
                                        //   Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //       builder: (context) {
                                        //         return const HomeScreen(user: state.user!,);
                                        //       },
                                        //     ),
                                        //   );
                                        // }
                                        child: Text(
                                          "Login".toUpperCase(),
                                          style: const TextStyle(
                                              fontFamily: "Poppins",
                                              fontSize: 21),
                                        ),
                                        onPressed: () => context
                                            .read<LoginBloc>()
                                            .add(
                                                ValidateLoginFieldsEvent(_key)),
                                      ),
                                    ),
                                    const SizedBox(height: defaultPadding),
                                    AlreadyHaveAnAccountCheck(
                                      press: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return const SignUpScreen();
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    const OrDivider(),
                                    const SigninSinupGoogle(
                                      text: "Login with Google",
                                    ),
                                    SizedBox(
                                      height: size.height * 0.05,
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       right: 40.0, left: 40.0, bottom: 20),
                                    //   child: ElevatedButton.icon(
                                    //     label: const Text(
                                    //       'Facebook Login',
                                    //       textAlign: TextAlign.center,
                                    //       style: TextStyle(
                                    //           fontSize: 20,
                                    //           fontWeight: FontWeight.bold,
                                    //           color: Colors.white),
                                    //     ),
                                    //     icon: Image.asset(
                                    //       'assets/images/facebook_logo.png',
                                    //       color: Colors.white,
                                    //       height: 24,
                                    //       width: 24,
                                    //     ),
                                    //     style: ElevatedButton.styleFrom(
                                    //       fixedSize: Size.fromWidth(
                                    //           MediaQuery.of(context)
                                    //                   .size
                                    //                   .width /
                                    //               1.5),
                                    //       padding: const EdgeInsets.symmetric(
                                    //           vertical: 16),
                                    //       backgroundColor:
                                    //           const Color(facebookButtonColor),
                                    //       shape: RoundedRectangleBorder(
                                    //         borderRadius:
                                    //             BorderRadius.circular(25.0),
                                    //         side: const BorderSide(
                                    //           color: Color(facebookButtonColor),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //     onPressed: () async {
                                    //       await context
                                    //           .read<LoadingCubit>()
                                    //           .showLoading(
                                    //               context,
                                    //               'Logging in, Please wait...',
                                    //               false);
                                    //       if (!mounted) return;
                                    //       context
                                    //           .read<AuthenticationBloc>()
                                    //           .add(LoginWithFacebookEvent());
                                    //     },
                                    //   ),
                                    // ),
                                    // FutureBuilder<bool>(
                                    //   future:
                                    //       apple.TheAppleSignIn.isAvailable(),
                                    //   builder: (context, snapshot) {
                                    //     if (snapshot.connectionState ==
                                    //         ConnectionState.waiting) {
                                    //       return const CircularProgressIndicator
                                    //           .adaptive();
                                    //     }
                                    //     if (!snapshot.hasData ||
                                    //         (snapshot.data != true)) {
                                    //       return Container();
                                    //     } else {
                                    //       return Padding(
                                    //         padding: const EdgeInsets.only(
                                    //             right: 40.0,
                                    //             left: 40.0,
                                    //             bottom: 20),
                                    //         child: ConstrainedBox(
                                    //           constraints: BoxConstraints(
                                    //               maxWidth:
                                    //                   MediaQuery.of(context)
                                    //                           .size
                                    //                           .width /
                                    //                       1.5),
                                    //           child: apple.AppleSignInButton(
                                    //               cornerRadius: 25.0,
                                    //               type: apple.ButtonType.signIn,
                                    //               style: isDarkMode(context)
                                    //                   ? apple.ButtonStyle.white
                                    //                   : apple.ButtonStyle.black,
                                    //               onPressed: () async {
                                    //                 await context
                                    //                     .read<LoadingCubit>()
                                    //                     .showLoading(
                                    //                         context,
                                    //                         'Logging in, Please wait...',
                                    //                         false);
                                    //                 if (!mounted) return;
                                    //                 context
                                    //                     .read<
                                    //                         AuthenticationBloc>()
                                    //                     .add(
                                    //                         LoginWithAppleEvent());
                                    //               }),
                                    //         ),
                                    //       );
                                    //     }
                                    //   },
                                    // ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}
