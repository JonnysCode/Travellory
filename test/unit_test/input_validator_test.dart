import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/utils/input_validator.dart';

void main() {
  test('empty email returns error string', () {
    final result = InputValidator.validate('', ValidatorType.EMAIL);
    expect(result, 'Enter an email address');
  });

  test('non-empty non-valid email returns error string', () {
    final error = 'Email is not valid';
    String result;

    result = InputValidator.validate('*.*@*', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('name', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('name.surname', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('name.surname@', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('name.surname@ch', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('first.last@sub.do,com', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('first\@last@iana.org', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate(
        '123456789012345678901234567890123456789012345678901234567890@123456' +
            '78901234567890123456789012345678901234567890123456789.123456789' +
            '01234567890123456789012345678901234567890123456789.123456789012' +
            '34567890123456789012345678901234567890123456789.12345.iana.org', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('.first.last@iana.org', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('first.last.@iana.org', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('first..last@iana.org', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('\"first\"last\"@iana.org', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('first.last@[.12.34.56.78]', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('first.last@[12.34.56.789]', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('first.last@[::12.34.56.78]', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('first.last@[IPv5:::12.34.56.78]', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate(
        'first.last@[IPv6:1111:2222:3333:' + '4444:5555:12.34.56.78]', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('.wooly@iana.org', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('.@iana.org', ValidatorType.EMAIL);
    expect(result, error);

    result = InputValidator.validate('Ima Fool@iana.org', ValidatorType.EMAIL);
    expect(result, error);
  });

  test('valid email returns null', () {
    String result;

    result = InputValidator.validate('first.last@iana.org', ValidatorType.EMAIL);
    expect(result, null);

    result = InputValidator.validate('test@iana.org', ValidatorType.EMAIL);
    expect(result, null);

    result = InputValidator.validate('name.surname@hotmail.com', ValidatorType.EMAIL);
    expect(result, null);

    result = InputValidator.validate('name_surname@bluewin.ch', ValidatorType.EMAIL);
    expect(result, null);

    result = InputValidator.validate('name_surname@ch.ch', ValidatorType.EMAIL);
    expect(result, null);

    result = InputValidator.validate('name_surname@gmail.com', ValidatorType.EMAIL);
    expect(result, null);

    result = InputValidator.validate('student@students.zhaw.ch', ValidatorType.EMAIL);
    expect(result, null);
  });

  test('empty password returns error string', () {
    final error = 'Enter a password with at least 6 characters';

    final result = InputValidator.validate('', ValidatorType.PASSWORD);
    expect(result, error);
  });

  test('non-empty non-valid password returns error string', () {
    final error = 'Enter a password with at least 6 characters';
    String result;

    result = InputValidator.validate('123', ValidatorType.PASSWORD);
    expect(result, error);
  });

  test('valid password returns null', () {
    final result = InputValidator.validate('123456', ValidatorType.PASSWORD);
    expect(result, null);
  });
}
