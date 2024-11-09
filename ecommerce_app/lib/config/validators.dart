import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class Validators {  
  //check null, isEmpty
  static String? requiredValidator(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return 'Please enter your $fieldName';
    }
    return null;
  }

  //validate email
  static String? validateEmail(String? value) {
    String? requiredError = requiredValidator(value, 'email');
    if (requiredError != null) return requiredError;

    if (!EmailValidator.validate(value!)) {
      return 'Enter a valid email';
    }
    return null;
  }

  //validate pw
 static  String? validatePassword(String? value) {
    String? requiredError = requiredValidator(value, 'password');
    if (requiredError != null) return requiredError;

    if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*.]).{8,}$')
        .hasMatch(value!)) {
      return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, one number and one special character.';
    }
    return null;
  }
 static String? validateConfirmPassword(
      String? value, TextEditingController passwordController) {
    String? requiredError = requiredValidator(value, 'confirm password');
    if (requiredError != null) return requiredError;

    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}