import 'package:flutter/material.dart';
import 'package:ocd/services/auth/auth_service.dart';
import 'package:ocd/views/login_view.dart';
import 'package:ocd/views/notes/new_notes_view.dart';
import 'package:ocd/views/notes/notes_view.dart';
import 'package:ocd/views/register_view.dart';
import 'package:ocd/views/verify_email_view.dart';
import 'package:ocd/constants/routes.dart';
import 'firebase_options.dart';
import 'package:sqflite/sqflite.dart';
//devtools is the alias for log - call the function by writing devtools.log()
//show imports log specificallu of the developer package
//import "dart:developer" as devtools show log;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.teal,
        //colorScheme: ColorScheme.fromSwatch()
        // .copyWith(secondary: Color.fromARGB(255, 4, 33, 47)),
      ),
      home: const HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
        newNoteRoute: (context) => const NewNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

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
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }

          //final emailVerified = user?.emailVerified ?? false;
          //?? is like or - it takes the left hand side as the value if not null, and if null it takes the boolean on the right

          default:
            return const CircularProgressIndicator();
          //return const Text("Loading... (₌♥ᆽ♥₌)");
        }
      },
    );
  }
}

//enum MenuAction { logout }
