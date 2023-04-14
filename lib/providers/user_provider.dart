// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:hitch_handler/resources/auth_methods.dart';
import '../models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = const User(
    bookmarks: [],
    dob: '01-01-2000',
    name: '',
    email: 'guest@email.com',
    mobno: '9000001234',
    rollno: '2000000000',
    uid: 'baskdhqwehnasndkl',
    domain: '',
    userType: 'user',
  );
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
