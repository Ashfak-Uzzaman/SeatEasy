import 'package:flutter/material.dart';
import 'package:seat_easy/components/my_button.dart';
import 'package:seat_easy/components/my_textfield.dart';
import 'package:seat_easy/components/square_tile.dart';
import 'package:seat_easy/constants/routes.dart';
import 'package:seat_easy/services/auth/auth_exception.dart';
import 'package:seat_easy/services/auth/auth_service.dart';
import 'package:seat_easy/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // text editing controllers
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // sign user in method
  void signUserIn(context) async {
    final email = _email.text;
    final password = _password.text;

    try {
      await AuthService.firebase().logIn(
        email: email,
        password: password,
      );
      final user = AuthService.firebase().currentUser;

      if (user?.isEmailVerified ?? false) {
        if (email.compareTo('mdashfak0508@gmail.com') == 0) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            adminHomeRoute,
            (route) =>
                false, // This predicate ensures that all previous routes are removed.
          );
        } else {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushNamedAndRemoveUntil(
            homeRoute,
            (route) =>
                false, // This predicate ensures that all previous routes are removed.
          );
        }
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamedAndRemoveUntil(
          verifyEmailRoute,
          (route) =>
              false, // This predicate ensures that all previous routes are removed.
        );
      }
    } on UserNotFoundAuthException {
      // ignore: use_build_context_synchronously
      await showErrorDialog(context, 'User not found');
    } on WrongPasswordAuthException {
      // ignore: use_build_context_synchronously
      await showErrorDialog(context, 'Wrong password');
    } on InvalidCredentialAuthException {
      await showErrorDialog(
          // ignore: use_build_context_synchronously
          context,
          'Please check your email and password');
    } on GenericAuthException {
      await showErrorDialog(
          // ignore: use_build_context_synchronously
          context,
          'Authantication Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              const SizedBox(
                  height: 50), //  they are used actually for empty space

              // logo
              const Icon(
                Icons.bus_alert_rounded,
                size: 100,
              ),

              const SizedBox(height: 50),

              // welcome back, you've been missed!
              Center(
                child: Text(
                  'Welcome back you\'ve been missed!',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: _email,
                textInputType: TextInputType.emailAddress,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextField(
                controller: _password,
                textInputType: TextInputType.visiblePassword,
                hintText: 'Password',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // sign in button
              MyButton(
                onTap: () => signUserIn(context),
                isEnabled: true,
                text: 'Sign In',
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),

              // google + apple sign in buttons
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: 'lib/assets/images/google.png'),
                  SizedBox(width: 40),

                  // apple button
                  SquareTile(imagePath: 'lib/assets/images/facebook.png'),
                  SizedBox(width: 40),

                  // facebook button
                  SquareTile(imagePath: 'lib/assets/images/apple.png'),
                ],
              ),

              const SizedBox(height: 50),

              // not a member? register now
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(registerRoute);
                    },
                    child: const Text(
                      'Register now',
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
