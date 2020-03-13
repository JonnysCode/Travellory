import 'package:email_validator/email_validator.dart';

enum ValidatorType{
  EMAIL, PASSWORD, USERNAME
}

class InputValidator {

  static String validate(String value, ValidatorType type){
    switch(type){
      case ValidatorType.EMAIL:
        return _validateEmail(value);
      case ValidatorType.PASSWORD :
        return _validatePassword(value);
      case ValidatorType.USERNAME :
        return null;
      default :
        return null;
    }
  }

  static String _validateEmail(String value) {
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

  static String _validatePassword(String value) {
    // todo: make password validation more strict
    if (value.length < 6 ) {
      return 'Enter a password with at least 6 characters';
    }
    return null;
  }
}