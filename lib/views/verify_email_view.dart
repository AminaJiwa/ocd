// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
//import "dart:developer" as devtools show log;

import 'package:ocd/constants/routes.dart';
import 'package:ocd/services/auth/auth_service.dart';
import 'package:ocd/services/auth/bloc/auth_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ocd/services/auth/bloc/auth_event.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text("Verify your email"),
      ),
      body: Column(
        children: [
          const Text(
              "We've sent you an email verification, please open it to verify your account"),
          const Text(
              "If you haven't recieved a verification email yet, please click the button below"),
          TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventSendEmailVerification(),
                    );
              },
              child: const Text("Send email verification")),
          TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(
                    const AuthEventLogOut(),
                  );
            },
            child: const Text("Restart"),
          )
        ],
      ),
    );
  }
}
