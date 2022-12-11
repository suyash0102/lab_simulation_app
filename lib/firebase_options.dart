// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDKvGDOBWnzVOBciRPKfkZnm9hzAX1hzFE',
    appId: '1:200198356587:web:9a5ce849fa26965e5c7b2e',
    messagingSenderId: '200198356587',
    projectId: 'lsapp-68019',
    authDomain: 'lsapp-68019.firebaseapp.com',
    storageBucket: 'lsapp-68019.appspot.com',
    measurementId: 'G-XCGT6ZSDYH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB5ajS0s3XisHYY_xrYfjU-kTOhXzo9QY4',
    appId: '1:200198356587:android:5e9980a481e73a685c7b2e',
    messagingSenderId: '200198356587',
    projectId: 'lsapp-68019',
    storageBucket: 'lsapp-68019.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCxISIS3YiIRKo9QYWI28zRXpAI6qoUjMI',
    appId: '1:200198356587:ios:45ea366ec4ce39fe5c7b2e',
    messagingSenderId: '200198356587',
    projectId: 'lsapp-68019',
    storageBucket: 'lsapp-68019.appspot.com',
    iosClientId: '200198356587-t2bbqdte4uvegiuhmfkscp0l44lb4n47.apps.googleusercontent.com',
    iosBundleId: 'com.synchronizers.labSimulationApp',
  );
}