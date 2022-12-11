import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:lab_simulation_app/constants.dart';
import 'package:lab_simulation_app/model/user.dart';
import 'package:lab_simulation_app/services/helper.dart';

class FireStoreUtils {
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
  static Reference storage = FirebaseStorage.instance.ref();

  static Future<User?> getCurrentUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDocument =
    await firestore.collection(usersCollection).doc(uid).get();
    if (userDocument.data() != null && userDocument.exists) {
      return User.fromJson(userDocument.data()!);
    } else {
      return null;
    }
  }

  static Future<User> updateCurrentUser(User user) async {
    return await firestore
        .collection(usersCollection)
        .doc(user.userID)
        .set(user.toJson())
        .then((document) {
      return user;
    });
  }

  static Future<String> uploadUserImageToServer(
      Uint8List imageData, String userID) async {
    Reference upload = storage.child("images/$userID.png");
    UploadTask uploadTask =
    upload.putData(imageData, SettableMetadata(contentType: 'image/jpeg'));
    var downloadUrl =
    await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    return downloadUrl.toString();
  }

  /// login with email and password with firebase
  /// @param email user email
  /// @param password user password
  static Future<dynamic> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await firestore
          .collection(usersCollection)
          .doc(result.user?.uid ?? '')
          .get();
      User? user;
      if (documentSnapshot.exists) {
        user = User.fromJson(documentSnapshot.data() ?? {});
      }
      return user;
    } on auth.FirebaseAuthException catch (exception, s) {
      debugPrint('$exception$s');
      switch ((exception).code) {
        case 'invalid-email':
          return 'Email address is malformed.';
        case 'wrong-password':
          return 'Wrong password.';
        case 'user-not-found':
          return 'No user corresponding to the given email address.';
        case 'user-disabled':
          return 'This user has been disabled.';
        case 'too-many-requests':
          return 'Too many attempts to sign in as this user.';
      }
      return 'Unexpected firebase error, Please try again.';
    } catch (e, s) {
      debugPrint('$e$s');
      return 'Login failed, Please try again.';
    }
  }

  static loginWithFacebook() async {
    FacebookAuth facebookAuth = FacebookAuth.instance;
    bool isLogged = await facebookAuth.accessToken != null;
    if (!isLogged) {
      LoginResult result = await facebookAuth
          .login(); // by default we request the email and the public profile
      if (result.status == LoginStatus.success) {
        // you are logged
        AccessToken? token = await facebookAuth.accessToken;
        return await handleFacebookLogin(
            await facebookAuth.getUserData(), token!);
      }
    } else {
      AccessToken? token = await facebookAuth.accessToken;
      return await handleFacebookLogin(
          await facebookAuth.getUserData(), token!);
    }
  }

  static handleFacebookLogin(
      Map<String, dynamic> userData, AccessToken token) async {
    auth.UserCredential authResult = await auth.FirebaseAuth.instance
        .signInWithCredential(
        auth.FacebookAuthProvider.credential(token.token));
    User? user = await getCurrentUser(authResult.user?.uid ?? '');
    // List<String> fullName = (userData['name'] as String).split(' ');
    String fullName = '';
    String branch = '';
    String year = '';
    // if (fullName.isNotEmpty) {
    //   fullName = fullName.first;
    //   lastName = fullName.skip(1).join(' ');
    // }

    if (user != null) {
      user.profilePictureURL = userData['picture']['data']['url'];
      user.fullName = fullName;
      user.branch = branch;
      user.year = year;
      user.email = userData['email'];
      dynamic result = await updateCurrentUser(user);
      return result;
    } else {
      user = User(
          email: userData['email'] ?? '',
          fullName: fullName,
          branch: branch,
          year: year,
          profilePictureURL: userData['picture']['data']['url'] ?? '',
          userID: authResult.user?.uid ?? '');
      String? errorMessage = await createNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return errorMessage;
      }
    }
  }

  /// save a new user document in the USERS table in firebase firestore
  /// returns an error message on failure or null on success
  static Future<String?> createNewUser(User user) async => await firestore
      .collection(usersCollection)
      .doc(user.userID)
      .set(user.toJson())
      .then((value) => null, onError: (e) => e);

  static signUpWithEmailAndPassword(
      {required String emailAddress,
        required String password,
        Uint8List? imageData,
        fullName = 'Anonymous',
        year = 'XXX',
        branch = 'XX', }) async {
    try {
      auth.UserCredential result = await auth.FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailAddress, password: password);
      String profilePicUrl = '';
      if (imageData != null) {
        updateProgress('Uploading image, Please wait...');
        profilePicUrl =
        await uploadUserImageToServer(imageData, result.user?.uid ?? '');
      }
      User user = User(
          email: emailAddress,
          fullName: fullName,
          userID: result.user?.uid ?? '',
          branch: branch,
          year: year,
          profilePictureURL: profilePicUrl);
      String? errorMessage = await createNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return 'Couldn\'t sign up for firebase, Please try again.';
      }
    } on auth.FirebaseAuthException catch (error) {
      debugPrint('$error${error.stackTrace}');
      String message = 'Couldn\'t sign up';
      switch (error.code) {
        case 'email-already-in-use':
          message = 'Email already in use, Please pick another email!';
          break;
        case 'invalid-email':
          message = 'Enter valid e-mail';
          break;
        case 'operation-not-allowed':
          message = 'Email/password accounts are not enabled';
          break;
        case 'weak-password':
          message = 'Password must be more than 5 characters';
          break;
        case 'too-many-requests':
          message = 'Too many requests, Please try again later.';
          break;
      }
      return message;
    } catch (e, s) {
      debugPrint('FireStoreUtils.signUpWithEmailAndPassword $e $s');
      return 'Couldn\'t sign up';
    }
  }

  static logout() async {
    await auth.FirebaseAuth.instance.signOut();
  }

  static Future<User?> getAuthUser() async {
    auth.User? firebaseUser = auth.FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      User? user = await getCurrentUser(firebaseUser.uid);
      return user;
    } else {
      return null;
    }
  }

  static Future<dynamic> loginOrCreateUserWithPhoneNumberCredential({
    required auth.PhoneAuthCredential credential,
    required String phoneNumber,
    String? fullName = 'Anonymous',
    String? branch = 'XX',
    String? year = 'XXX',
    Uint8List? imageData,
  }) async {
    auth.UserCredential userCredential =
    await auth.FirebaseAuth.instance.signInWithCredential(credential);
    User? user = await getCurrentUser(userCredential.user?.uid ?? '');
    if (user != null) {
      return user;
    } else {
      /// create a new user from phone login
      String profileImageUrl = '';
      if (imageData != null) {
        profileImageUrl = await uploadUserImageToServer(
            imageData, userCredential.user?.uid ?? '');
      }
      User user = User(
          // firstName:
          // firstName!.trim().isNotEmpty ? firstName.trim() : 'Anonymous',
          // lastName: lastName!.trim().isNotEmpty ? lastName.trim() : 'User',
        fullName: '',
          year: '',
          branch: '',
          email: '',
          profilePictureURL: profileImageUrl,
          userID: userCredential.user?.uid ?? '');
      String? errorMessage = await createNewUser(user);
      if (errorMessage == null) {
        return user;
      } else {
        return 'Couldn\'t create new user with phone number.';
      }
    }
  }

  // static loginWithApple() async {
  //   final appleCredential = await apple.TheAppleSignIn.performRequests([
  //     const apple.AppleIdRequest(
  //         requestedScopes: [apple.Scope.email, apple.Scope.fullName])
  //   ]);
  //   if (appleCredential.error != null) {
  //     return 'Couldn\'t login with apple.';
  //   }
  //
  //   if (appleCredential.status == apple.AuthorizationStatus.authorized) {
  //     final auth.AuthCredential credential =
  //     auth.OAuthProvider('apple.com').credential(
  //       accessToken: String.fromCharCodes(
  //           appleCredential.credential?.authorizationCode ?? []),
  //       idToken: String.fromCharCodes(
  //           appleCredential.credential?.identityToken ?? []),
  //     );
  //     return await handleAppleLogin(credential, appleCredential.credential!);
  //   } else {
  //     return 'Couldn\'t login with apple.';
  //   }
  // }
  //
  // static handleAppleLogin(
  //     auth.AuthCredential credential,
  //     apple.AppleIdCredential appleIdCredential,
  //     ) async {
  //   auth.UserCredential authResult =
  //   await auth.FirebaseAuth.instance.signInWithCredential(credential);
  //   User? user = await getCurrentUser(authResult.user?.uid ?? '');
  //   if (user != null) {
  //     return user;
  //   } else {
  //     user = User(
  //       email: appleIdCredential.email ?? '',
  //       // fullName: appleIdCredential.fullName?.givenName ?? '',
  //       fullName: appleIdCredential.fullName ?? '',
  //       profilePictureURL: '',
  //       userID: authResult.user?.uid ?? '',
  //       branch: appleIdCredential.branch ??'',
  //       year: appleIdCredential.year ?? '',
  //     );
  //     String? errorMessage = await createNewUser(user);
  //     if (errorMessage == null) {
  //       return user;
  //     } else {
  //       return errorMessage;
  //     }
  //   }
  // }

  static resetPassword(String emailAddress) async =>
      await auth.FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailAddress);
}