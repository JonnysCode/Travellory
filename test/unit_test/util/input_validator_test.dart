import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/utils/input_validator.dart';

void main() {
  test('empty email returns error string', () {
    final result = InputValidator.validate('', ValidatorType.email);
    expect(result, 'Enter an email address');
  });

  test('non-empty non-valid email returns error string', () {
    final error = 'Email is not valid';
    String result;

    result = InputValidator.validate('*.*@*', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('name', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('name.surname', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('name.surname@', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('name.surname@ch', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('first.last@sub.do,com', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('first\@last@iana.org', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate(
        '123456789012345678901234567890123456789012345678901234567890@123456' +
            '78901234567890123456789012345678901234567890123456789.123456789' +
            '01234567890123456789012345678901234567890123456789.123456789012' +
            '34567890123456789012345678901234567890123456789.12345.iana.org', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('.first.last@iana.org', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('first.last.@iana.org', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('first..last@iana.org', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('\"first\"last\"@iana.org', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('first.last@[.12.34.56.78]', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('first.last@[12.34.56.789]', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('first.last@[::12.34.56.78]', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('first.last@[IPv5:::12.34.56.78]', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate(
        'first.last@[IPv6:1111:2222:3333:' + '4444:5555:12.34.56.78]', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('.wooly@iana.org', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('.@iana.org', ValidatorType.email);
    expect(result, error);

    result = InputValidator.validate('Ima Fool@iana.org', ValidatorType.email);
    expect(result, error);
  });

  test('valid email returns null', () {
    String result;

    result = InputValidator.validate('first.last@iana.org', ValidatorType.email);
    expect(result, null);

    result = InputValidator.validate('test@iana.org', ValidatorType.email);
    expect(result, null);

    result = InputValidator.validate('name.surname@hotmail.com', ValidatorType.email);
    expect(result, null);

    result = InputValidator.validate('name_surname@bluewin.ch', ValidatorType.email);
    expect(result, null);

    result = InputValidator.validate('name_surname@ch.ch', ValidatorType.email);
    expect(result, null);

    result = InputValidator.validate('name_surname@gmail.com', ValidatorType.email);
    expect(result, null);

    result = InputValidator.validate('student@students.zhaw.ch', ValidatorType.email);
    expect(result, null);
  });

  test('empty password returns error string', () {
    final error = 'Enter a password with at least 6 characters';

    final result = InputValidator.validate('', ValidatorType.password);
    expect(result, error);
  });

  test('non-empty non-valid password returns error string', () {
    final error = 'Enter a password with at least 6 characters';
    String result;

    result = InputValidator.validate('123', ValidatorType.password);
    expect(result, error);
  });

  test('valid password returns null', () {
    final result = InputValidator.validate('123456', ValidatorType.password);
    expect(result, null);
  });

  test('empty username returns error string', () {
    final result = InputValidator.validate('', ValidatorType.username);
    expect(result, 'Enter a username');
  });

  test('non-empty non-valid username returns error string', () {
    final error = 'Invalid username';
    String result;

    result = InputValidator.validate('user*name', ValidatorType.username);
    expect(result, error);

    result = InputValidator.validate('/username', ValidatorType.username);
    expect(result, error);

    result = InputValidator.validate('username?', ValidatorType.username);
    expect(result, error);

    result = InputValidator.validate('/&*(ç=', ValidatorType.username);
    expect(result, error);

    result = InputValidator.validate('_username', ValidatorType.username);
    expect(result, error);

    result = InputValidator.validate('-username?', ValidatorType.username);
    expect(result, error);
  });

  test('valid username returns null', () {
    String result = InputValidator.validate('donaldduck', ValidatorType.username);
    expect(result, null);

    result = InputValidator.validate('donald-duck', ValidatorType.username);
    expect(result, null);

    result = InputValidator.validate('donald_duck', ValidatorType.username);
    expect(result, null);
  });
}
