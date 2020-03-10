import 'package:email_validator/email_validator.dart';

class InputValidator {
  static String validateEmail(String value) {
    if (value.isEmpty) {
      // the form is empty
      return "Enter an email address";
    }

    if (EmailValidator.validate(value)) {
      // the email is valid
      return null;
    }

    // the pattern of the email didn't match the regex above
    return 'Email is not valid';
  }

  static String validatePassword(String value) {
    // todo: make password validation more strict
    if (value.length < 6 ) {
      return 'Enter a password with at least 6 characters';
    }
    return null;
  }
}