import 'dart:io';

import 'package:flutter/foundation.dart';

class User {
  String email;

  String fullName;

  String branch;

  String year;

  String userID;

  String profileImageUrl;

  String appIdentifier;

  User({
    this.email = '',
    this.fullName = '',
    this.branch = '',
    this.year = '',
    this.userID = '',
    this.profileImageUrl = '',
  }) : appIdentifier =
            'Flutter Login Screen ${kIsWeb ? 'Web' : Platform.operatingSystem}';

  // String fullName() => '$fullName';

  factory User.fromJson(Map<String, dynamic> parsedJson) {
    return User(
        email: parsedJson['email'] ?? '',
        fullName: parsedJson['fullName'] ?? '',
        branch: parsedJson['branch'] ?? '',
        year: parsedJson['year'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profileImageUrl: parsedJson['profileImageUrl'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'fullName': fullName,
      'branch': branch,
      'year': year,
      'id': userID,
      'profileImageUrl': profileImageUrl,
      'appIdentifier': appIdentifier
    };
  }
}
