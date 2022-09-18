// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
//import "dart:developer" as devtools show log;

import 'package:ocd/constants/routes.dart';
import 'package:ocd/services/auth/auth_exceptions.dart';
import 'package:ocd/services/auth/auth_service.dart';
import 'package:ocd/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
              controller: _email,
              enableSuggestions: true,
              autocorrect: true,
              keyboardType: TextInputType.emailAddress,
              decoration:
                  const InputDecoration(hintText: "Please enter your email")),
          TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                  hintText: "Please enter your password")),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;
              try {
                await AuthService.firebase().logIn(
                  email: email,
                  password: password,
                );
                final user = AuthService.firebase().currentUser;
                if (user?.isEmailVerified ?? false) {
                  //user email verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    notesRoute,
                    (route) => false,
                  );
                } else {
                  //user email NOT verified
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    verifyEmailRoute,
                    (route) => false,
                  );
                }
              } on UserNotFoundAuthException {
                await showErrorDialog(
                  context,
                  "User not found",
                );
              } on WrongPasswordAuthException {
                await showErrorDialog(
                  context,
                  "Wrong password has been entered",
                );
              } on GenericAuthException {
                await showErrorDialog(context, "Authentication error");
              }
            },
            child: const Text("Login"),
          ),

          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text("Not registered yet? Register here!"),
          ),
          // Lottie.asset("assets/pixelheart.json"),

          Container(
            height: 400,
            width: 400,
            child: Lottie.network(
                'https://assets3.lottiefiles.com/packages/lf20_s4tubmwg.json'),
          ),
        ],
      ),
    );
  }
}
