part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class LoginWithEmailAndPasswordEvent extends AuthenticationEvent {
  String email;
  String password;

  LoginWithEmailAndPasswordEvent({required this.email, required this.password});
}

class LoginWithFacebookEvent extends AuthenticationEvent {}

class LoginWithAppleEvent extends AuthenticationEvent {}

class LoginWithPhoneNumberEvent extends AuthenticationEvent {
  auth.PhoneAuthCredential credential;
  String phoneNumber;
  String? fullName;
  String? branch;
  String? year;
  String? profileImageUrl;
  // Uint8List? imageData;

  LoginWithPhoneNumberEvent({
    required this.credential,
    required this.phoneNumber,
    this.fullName,
    this.branch,
    this.year,
    this.profileImageUrl,
    // this.imageData,
  });
}

class SignupWithEmailAndPasswordEvent extends AuthenticationEvent {
  String emailAddress;
  String password;
  // Uint8List? imageData;
  String? fullName;
  String? branch;
  String? year;
  String? profileImageUrl;


  SignupWithEmailAndPasswordEvent({
    required this.emailAddress,
    required this.password,
    // this.imageData,
    this.fullName = 'Anonymous',
    this.branch = 'Anonymous',
    this.year = 'Anonymous',
    this.profileImageUrl='https://ibb.co/HKmgntF',
  });
}

class LogoutEvent extends AuthenticationEvent {
  LogoutEvent();
}

class FinishedOnBoardingEvent extends AuthenticationEvent {}

class CheckFirstRunEvent extends AuthenticationEvent {}
