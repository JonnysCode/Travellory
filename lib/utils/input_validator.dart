import 'package:email_validator/email_validator.dart';

enum ValidatorType{
  email, password, username
}

class InputValidator {

  static String validate(String value, ValidatorType type){
    switch(type){
      case ValidatorType.email:
        return _validateEmail(value);
      case ValidatorType.password :
        return _validatePassword(value);
      case ValidatorType.username :
        return _validateUsername(value);
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

  static String _validateUsername(String value) {
    if (value.isEmpty) {
      // the form is empty
      return 'Enter a username';
    }
    
    const Pattern pattern =
        r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
    final RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value)) {
      return 'Invalid username';
    }
    return null;
  }
}