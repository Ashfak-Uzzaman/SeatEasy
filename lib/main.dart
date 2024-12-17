import 'package:flutter/material.dart';
import 'package:seat_easy/constants/routes.dart';
import 'package:seat_easy/services/auth/auth_service.dart';
import 'package:seat_easy/views/home_view.dart';
import 'package:seat_easy/views/login_view.dart';
import 'package:seat_easy/views/register_view.dart';
import 'package:seat_easy/views/verify_email_view.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const InnitializeView(),
    routes: {
      loginRoute: (context) => const LoginView(),
      registerRoute: (context) => const RegisterView(),
      homeRoute: (context) => const HomeView(),
      verifyEmailRoute: (context) => const VerifyEmailView(),
    },
  ));
}

class InnitializeView extends StatelessWidget {
  const InnitializeView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;

            if (user != null) {
              if (user.isEmailVerified) {
                return const HomeView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          default:
            //return const Text('Loading...');
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
