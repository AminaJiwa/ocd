// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import "dart:developer" as devtools show log;

import 'package:ocd/constants/routes.dart';
import 'package:ocd/services/auth/auth_exceptions.dart';
import 'package:ocd/services/auth/auth_service.dart';
import 'package:ocd/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text("Register"),
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
                // ignore: non_constant_identifier_names

                await AuthService.firebase().createUser(
                  email: email,
                  password: password,
                );
                AuthService.firebase().sendEmailVerification();
                Navigator.of(context).pushNamed(verifyEmailRoute);
              } on WeakPasswordAuthException {
                await showErrorDialog(
                  context,
                  "Your password is too weak. Try using uppercase/ lowercase letters, symbols or numbers",
                );
              } on EmailAlreadyInUseAuthException {
                await showErrorDialog(
                  context,
                  "There is already an account associated with the email you have entered",
                );
              } on InvalidEmailAuthException {
                await showErrorDialog(
                  context,
                  "The email you have entered is invalid",
                );
              } on GenericAuthException {
                await showErrorDialog(
                  context,
                  "Failed to register, please try again",
                );
              }
            },
            child: const Text("Register"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                loginRoute,
                (route) => false,
              );
            },
            child: const Text("Already registered? Login here!"),
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
