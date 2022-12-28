import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/ui/auth/welcome/welcome_bloc.dart';

class LoginAndSignupBtn extends StatelessWidget {
  const LoginAndSignupBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Hero(
          tag: "login_btn",
          child: ElevatedButton(
            onPressed: () {
              context.read<WelcomeBloc>().add(LoginPressed());
            },
            child: Text(
              "Login".toUpperCase(),
              style: const TextStyle(fontFamily: "Poppins", fontSize: 21),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            context.read<WelcomeBloc>().add(SignupPressed());
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryLightColor, elevation: 0),
          child: Text(
            "Sign Up".toUpperCase(),
            style: const TextStyle(
                color: Colors.black, fontFamily: "Poppins", fontSize: 21),
          ),
        ),
      ],
    );
  }
}
