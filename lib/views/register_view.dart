import 'package:flutter/material.dart';
import 'package:seat_easy/components/my_button.dart';
import 'package:seat_easy/components/my_textfield.dart';
import 'package:seat_easy/constants/routes.dart';
import 'package:seat_easy/services/auth/auth_exception.dart';
import 'package:seat_easy/services/auth/auth_service.dart';
import 'package:seat_easy/utilities/dialogs/error_dialog.dart';

import 'package:seat_easy/utilities/validation_utils.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _mobile;
  late final TextEditingController _name;
  late final TextEditingController _confirmPassword;

// Will show message if email/phone/password/name are not valid at the bottom of the text field
  String _emailErrorText = '';
  String _mobileErrorText = '';
  String _passwordErrorText = '';
  String _confirmPasswordErrorText = '';

  bool _emailValid = false;
  bool _mobileValid = false;
  bool _passwordValid = false;
  bool _confirmPasswordValid = false;

  bool isButtonActive = false;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _mobile = TextEditingController();
    _name = TextEditingController();
    _confirmPassword = TextEditingController();

    _email.addListener(() {
      final String value = _email.text;

      // Update the error text based on validation
      setState(() {
        if (value.isNotEmpty && ValidationUtils.validateEmail(value)) {
          _emailErrorText = '';
          _emailValid = true;
        } else {
          _emailErrorText = value.isEmpty
              ? 'Please enter your  email address'
              : 'Please enter a valid  email address';
          _emailValid = false;
        }

        isButtonActive = _emailValid &&
            _mobileValid &&
            _passwordValid &&
            _confirmPasswordValid;
      });
    });
    _mobile.addListener(() {
      final String value = _mobile.text;

      // Update the error text based on validation
      setState(() {
        if (value.isNotEmpty && ValidationUtils.validateMobile(value)) {
          _mobileErrorText = '';
          _mobileValid = true;
        } else {
          _mobileErrorText = value.isEmpty
              ? 'Please enter your mobile nummber'
              : 'Please enter a valid mobile number';
          _mobileValid = false;
        }
        isButtonActive = _emailValid &&
            _mobileValid &&
            _passwordValid &&
            _confirmPasswordValid;
      });
    });
    _password.addListener(
      () {
        final String value = _password.text;
        // Update the error text based on validation
        setState(() {
          if (value.isNotEmpty && ValidationUtils.validatePassword(value)) {
            _passwordErrorText = '';
            _passwordValid = true;
          } else {
            _passwordErrorText = value.isEmpty
                ? 'Please enter a strong password'
                : 'Use at least an uppercase, a lowercase, a special character and a number. The length should be at least 6 and not more than 20';
            _passwordValid = false;
          }
          isButtonActive = _emailValid &&
              _mobileValid &&
              _passwordValid &&
              _confirmPasswordValid;
        });
      },
    );
    _confirmPassword.addListener(
      () {
        final String value = _confirmPassword.text;
        // Update the error text based on validation
        setState(() {
          final password = _password.text;
          final confirmPassword = _confirmPassword.text;
          if (confirmPassword.isNotEmpty &&
              (confirmPassword.compareTo(password) == 0)) {
            _confirmPasswordErrorText = '';
            _confirmPasswordValid = true;
          } else {
            _confirmPasswordErrorText = value.isEmpty
                ? 'Please confirm password'
                : 'Passwords not matched';
            _confirmPasswordValid = false;
          }
          isButtonActive = _emailValid &&
              _mobileValid &&
              _passwordValid &&
              _confirmPasswordValid;
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // sign user in method
  void registerUser(context) async {
    final email = _email.text;
    //final mobile = _mobile.text;
    final password = _password.text;
    final confirmPassword = _confirmPassword.text;

    if (password.compareTo(confirmPassword) != 0) {
      _confirmPasswordErrorText = 'Passwords not matched';
      _confirmPasswordValid = false;
      isButtonActive = false;
      _confirmPassword.text = '';
      _confirmPasswordErrorText = 'Passwords not matched';
    } else if (_emailValid &&
        _mobileValid &&
        _passwordValid &&
        _confirmPasswordValid &&
        (password.compareTo(confirmPassword) == 0)) {
      try {
        await AuthService.firebase().createUser(
          email: email,
          password: password,
        );

        AuthService.firebase().sendEmailVerification();
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed(verifyEmailRoute);
      } on EmailAlreadyInUseAuthException catch (_) {
        await showErrorDialog(
          // ignore: use_build_context_synchronously
          context,
          'Email is already in use',
        );
      } on InvalidEmailAuthException catch (_) {
        await showErrorDialog(
          // ignore: use_build_context_synchronously
          context,
          'Invalid Email',
        );
      } on GenericAuthException catch (_) {
        await showErrorDialog(
          // ignore: use_build_context_synchronously
          context,
          'Failed to register',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: ListView(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Center(
                  child: Text(
                'Create Account',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),

              const SizedBox(height: 40),

              // name textfield
              MyTextField(
                controller: _name,
                textInputType: TextInputType.name,
                hintText: 'Name',
                obscureText: false,
              ),

              const SizedBox(height: 25),

              // name textfield
              MyTextField(
                controller: _email,
                textInputType: TextInputType.emailAddress,
                hintText: 'Email',
                obscureText: false,
              ),
              // This is for error message
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 35.0),
                child: Text(
                  _emailErrorText,
                  style: const TextStyle(color: Colors.red, fontSize: 10),
                ),
              ),

              const SizedBox(height: 10),

              // name textfield
              MyTextField(
                controller: _mobile,
                textInputType: TextInputType.phone,
                hintText: 'Phone',
                obscureText: false,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 35.0),
                child: Text(
                  _mobileErrorText,
                  style: const TextStyle(color: Colors.red, fontSize: 10),
                ),
              ),
              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: _password,
                textInputType: TextInputType.visiblePassword,
                hintText: 'Password',
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 35.0),
                child: Text(
                  _passwordErrorText,
                  style: const TextStyle(color: Colors.red, fontSize: 10),
                ),
              ),

              const SizedBox(height: 10),
              MyTextField(
                controller: _confirmPassword,
                textInputType: TextInputType.visiblePassword,
                hintText: 'Confirm Password',
                obscureText: true,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, left: 35.0),
                child: Text(
                  _confirmPasswordErrorText,
                  style: const TextStyle(color: Colors.red, fontSize: 10),
                ),
              ),
              //const SizedBox(height: 10),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                //onTap: () => signUserIn(context),
                onTap: isButtonActive ? () => registerUser(context) : null,
                isEnabled: isButtonActive,
                //onTap: () => signUserUp(context),
                text: 'Sign Up',
              ),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(loginRoute);
                    },
                    child: const Text(
                      'Log in now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
