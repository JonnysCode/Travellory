import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/utils/input_validator.dart';

void main() {
  test('empty email returns error string', () {
    final result = InputValidator.validateEmail('');
    expect(result, 'Enter an email address');
  });

  test('non-empty non-valid email returns error string', () {
    final error = 'Email is not valid';
    String result;

    result = InputValidator.validateEmail('*.*@*');
    expect(result, error);

    result = InputValidator.validateEmail('name');
    expect(result, error);

    result = InputValidator.validateEmail('name.surname');
    expect(result, error);

    result = InputValidator.validateEmail('name.surname@');
    expect(result, error);

    result = InputValidator.validateEmail('name.surname@ch');
    expect(result, error);

    result = InputValidator.validateEmail('first.last@sub.do,com');
    expect(result, error);

    result = InputValidator.validateEmail('first\@last@iana.org');
    expect(result, error);

    result = InputValidator.validateEmail(
        '123456789012345678901234567890123456789012345678901234567890@123456' +
            '78901234567890123456789012345678901234567890123456789.123456789' +
            '01234567890123456789012345678901234567890123456789.123456789012' +
            '34567890123456789012345678901234567890123456789.12345.iana.org');
    expect(result, error);

    result = InputValidator.validateEmail('.first.last@iana.org');
    expect(result, error);

    result = InputValidator.validateEmail('first.last.@iana.org');
    expect(result, error);

    result = InputValidator.validateEmail('first..last@iana.org');
    expect(result, error);

    result = InputValidator.validateEmail('\"first\"last\"@iana.org');
    expect(result, error);

    result = InputValidator.validateEmail('first.last@[.12.34.56.78]');
    expect(result, error);

    result = InputValidator.validateEmail('first.last@[12.34.56.789]');
    expect(result, error);

    result = InputValidator.validateEmail('first.last@[::12.34.56.78]');
    expect(result, error);

    result = InputValidator.validateEmail('first.last@[IPv5:::12.34.56.78]');
    expect(result, error);

    result = InputValidator.validateEmail(
        'first.last@[IPv6:1111:2222:3333:' + '4444:5555:12.34.56.78]');
    expect(result, error);

    result = InputValidator.validateEmail('.wooly@iana.org');
    expect(result, error);

    result = InputValidator.validateEmail('.@iana.org');
    expect(result, error);

    result = InputValidator.validateEmail('Ima Fool@iana.org');
    expect(result, error);
  });

  test('valid email returns null', () {
    String result;

    result = InputValidator.validateEmail('first.last@iana.org');
    expect(result, null);

    result = InputValidator.validateEmail('test@iana.org');
    expect(result, null);

    result = InputValidator.validateEmail('name.surname@hotmail.com');
    expect(result, null);

    result = InputValidator.validateEmail('name_surname@bluewin.ch');
    expect(result, null);

    result = InputValidator.validateEmail('name_surname@ch.ch');
    expect(result, null);

    result = InputValidator.validateEmail('name_surname@gmail.com');
    expect(result, null);

    result = InputValidator.validateEmail('student@students.zhaw.ch');
    expect(result, null);
  });

  test('empty password returns error string', () {
    final error = 'Enter a password with at least 6 characters';

    final result = InputValidator.validatePassword('');
    expect(result, error);
  });

  test('non-empty non-valid password returns error string', () {
    final error = 'Enter a password with at least 6 characters';
    String result;

    result = InputValidator.validatePassword('123');
    expect(result, error);
  });

  test('valid password returns null', () {
    final result = InputValidator.validatePassword('123456');
    expect(result, null);
  });
}
