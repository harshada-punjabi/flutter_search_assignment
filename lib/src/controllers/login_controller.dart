import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../views/pages/home_page.dart';

class LoginController with ChangeNotifier {
  String userEmail = '';
  String userPassword = '';

  String get passwordValidationMessage {
    if (userPassword == '123456') {
      return 'Password is too easy.';
    } else if (userPassword.length < 6) {
      return 'Password is too short.';
    } else {
      return 'Password is strong.';
    }
  }

  String emailValidationMessage(String value) {
    if (!emailValidator(value)) {
      return 'Invalid email format.';
    }
    return "";
  }

  bool emailValidator(String email) {
    final emailValidator = EmailValidator(errorText: "");
    return emailValidator.isValid(email);
  }

  bool get isLoginButtonEnabled {
    return emailValidator(userEmail) &&
        userPassword.length >= 6 &&
        userPassword != '123456';
  }

  void setEmail(String email) {
    userEmail = email;
    notifyListeners();
  }

  void setPassword(String password) {
    userPassword = password;
    notifyListeners();
  }

  void login(BuildContext context) {
    if (isLoginButtonEnabled) {
      _showSuccessDialog(context);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    }
  }

  void _showSuccessDialog(BuildContext context) {
    Fluttertoast.showToast(
      msg: 'Login Success!',
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.green,
    );
  }
}
