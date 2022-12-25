import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_simulation_app/components/login_signup_btn.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/services/helper.dart';
import 'package:lab_simulation_app/ui/auth/login/login_screen.dart';
import 'package:lab_simulation_app/ui/auth/signUp/sign_up_screen.dart';
import 'package:lab_simulation_app/ui/auth/welcome/welcome_bloc.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WelcomeBloc>(
      create: (context) => WelcomeBloc(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocListener<WelcomeBloc, WelcomeInitial>(
              listener: (context, state) {
                switch (state.pressTarget) {
                  case WelcomePressTarget.login:
                    push(context, const LoginScreen());
                    break;
                  case WelcomePressTarget.signup:
                    push(context, const SignUpScreen());
                    break;
                  default:
                    break;
                }
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    "Welcome to LSAPP",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 36,
                      fontFamily: "Hubballi",
                    ),
                  ),
                  const SizedBox(height: defaultPadding * 2),
                  Row(
                    children: [
                      const Spacer(),
                      Expanded(
                        flex: 8,
                        child: Image.asset(
                            "assets/images/welcome_screen_ills.png"),
                      ),
                      const Spacer(),
                    ],
                  ),
                  const SizedBox(height: defaultPadding * 1),
                  // const Padding(
                  //   padding: EdgeInsets.only(
                  //       left: 16, top: 32, right: 16, bottom: 8),
                  //   child: Text(
                  //     'Say Hello To Your New App!',
                  //     textAlign: TextAlign.center,
                  //     style: TextStyle(
                  //         color: Color(colorPrimary),
                  //         fontSize: 24.0,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // ),
                  // const Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  //   child: Text(
                  //     'You\'ve just saved a week of development and headaches.',
                  //     style: TextStyle(fontSize: 18),
                  //     textAlign: TextAlign.center,
                  //   ),
                  // ),
                  Row(
                    children: const [
                      Spacer(),
                      Expanded(
                        flex: 8,
                        child: LoginAndSignupBtn(),
                      ),
                      Spacer(),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
