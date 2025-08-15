

import 'package:iti_final_team3/utils/app_strings.dart';

class FormValidator {
  static String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return AppStrings.emailRequired;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  static String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (password.length < 6) {
      return AppStrings.passwordMinLength;
    }
    return null;
  }

  static String? validateConfirmPassword(
    String? password,
    String? confirmPassword,
  ) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return AppStrings.confirmPasswordRequired;
    }
    if (password != confirmPassword) {
      return AppStrings.passwordsDoNotMatch;
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.nameIsRequired;
    } else if (!RegExp(r"^[a-zA-Z]+(([',. -][a-zA-Z ])?[a-zA-Z]*)*$")
        .hasMatch(value)) {
      return AppStrings.invalidName;
    } else if (value.trim().length < 2) {
      return AppStrings.name;
    }
    return null;
  }
}
