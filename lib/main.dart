import 'package:flutter/material.dart';
import 'package:seat_easy/constants/routes.dart';
import 'package:seat_easy/services/auth/auth_service.dart';
import 'package:seat_easy/views/admin_fragments/assign_route._page.dart';
import 'package:seat_easy/views/admin_main_view.dart';

import 'package:seat_easy/views/user_main_view.dart';
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
      adminHomeRoute: (context) => const AdminMainView(),
      assignRoutePageRoute: (contex) => const AssignRoutePage(),
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
        //return const AdminHomeView();

        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = AuthService.firebase().currentUser;

            if (user != null) {
              if (user.isEmailVerified) {
                //return const HomeView();
                return const AdminMainView();
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
