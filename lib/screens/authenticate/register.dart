import 'package:flutter/material.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/shared/loading_logo.dart';
import 'package:travellory/utils/logger.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/authentication/auth.dart';
import 'package:travellory/services/authentication/user_management.dart';
import 'package:travellory/utils/input_validator.dart';
import 'package:travellory/widgets/auth_background.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/input_widgets.dart';
import 'package:pedantic/pedantic.dart';

class Register extends StatefulWidget {
  static const route = '/register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();

  final log = getLogger('_RegisterState');

  String _error;
  String _errorUsername;
  bool _isUsernameAvailable = true;

  @override
  void initState() {
    super.initState();

    _nameFocus.addListener(_checkUsernameAvailability);
  }

  Future _validateRegister() async {
    if (_formKey.currentState.validate() && _isUsernameAvailable) {
      unawaited(Navigator.pushNamed(context, LoadingLogo.route));
      await _register().then((_) {
        log.i('User successfully registered');
        Navigator.popUntil(
          context,
          ModalRoute.withName('/'),
        );
      }).catchError((e) {
        Navigator.pop(context);
        setState(() {
          _error = e.message ?? 'Something went wrong. Try again';
        });
      });
    }
  }

  Future _register() async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    final UserModel user = await _auth
        .registerWithEmailAndPassword(
            _emailController.text, _passwordController.text, _nameController.text)
        .catchError((e) {
      return Future.error(e);
    });
    return user;
  }

  void _checkUsernameAvailability() async {
    final isUsernameAvailable = await UserManagement().isUsernameAvailable(_nameController.text);
    setState(() {
      _isUsernameAvailable = isUsernameAvailable;
      _isUsernameAvailable ? _errorUsername = null : _errorUsername = 'Username is already used';
    });
  }

  @override
  void dispose() {
    _nameFocus.removeListener(_checkUsernameAvailability);
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthBackground(
          child: Column(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 140,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Container(
                        padding: EdgeInsets.only(bottom: 25, right: 40),
                        alignment: Alignment.center,
                        child: Text(
                          "REGI",
                          style: TextStyle(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF7EDEE),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          padding: EdgeInsets.only(top: 40, left: 28),
                          width: 130,
                          child: Text(
                            "STER",
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFF7EDEE),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                        top: 40,
                      ),
                      child: inputAuthentication(
                          Icon(Icons.account_circle),
                          "USERNAME",
                          _isUsernameAvailable ? Theme.of(context).primaryColor : Colors.redAccent,
                          _nameController,
                          _nameFocus,
                          ValidatorType.username,
                          _errorUsername,
                          obscure: false),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: inputAuthentication(
                          Icon(Icons.email),
                          "EMAIL",
                          Theme.of(context).primaryColor,
                          _emailController,
                          null,
                          ValidatorType.email,
                          null,
                          obscure: false),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: inputAuthentication(
                        Icon(Icons.lock),
                        "PASSWORD",
                        Theme.of(context).primaryColor,
                        _passwordController,
                        null,
                        ValidatorType.password,
                        _error,
                        obscure: true,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        child: filledButton(
                            "REGISTER",
                            Colors.white,
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor,
                            Colors.white,
                            _validateRegister),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
