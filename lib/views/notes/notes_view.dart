import 'package:flutter/material.dart';
import 'package:ocd/enums/menu_action.dart';
import 'package:ocd/services/auth/auth_service.dart';
import 'package:ocd/services/crud/notes_service.dart';
import 'package:ocd/utilities/dialogs/logout_dialog.dart';
import 'package:ocd/views/login_view.dart';
import 'package:ocd/views/notes/notes_list_view.dart';
import 'package:ocd/views/register_view.dart';
import 'package:ocd/views/verify_email_view.dart';
import 'package:ocd/constants/routes.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService;
  //! is force wrap it - instead of nullable
  String get userEmail => AuthService.firebase().currentUser!.email!;
  @override
  void initState() {
    _notesService = NotesService();
    _notesService.open();
    super.initState();
  }

  // @override
  //void dispose() {
  //_notesService.close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.teal[900],
            title: const Text("✧˖° Your Notes ✧˖°"),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(newNoteRoute);
                },
                icon: const Icon(Icons.add),
              ),
              PopupMenuButton<MenuAction>(onSelected: (value) async {
                switch (value) {
                  case MenuAction.logout:
                    final shouldLogOut = await showLogoutDialog(context);
                    if (shouldLogOut) {
                      await AuthService.firebase().logOut();
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        loginRoute,
                        (_) => false,
                      );
                    }
                    break;
                }
              }, itemBuilder: (context) {
                return const [
                  PopupMenuItem<MenuAction>(
                      value: MenuAction.logout, child: Text("Logout"))
                ];
              })
            ]),
        body: FutureBuilder(
            future: _notesService.getOrCreateUser(email: userEmail),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.done:
                  return StreamBuilder(
                      stream: _notesService.allNotes,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            if (snapshot.hasData) {
                              final allNotes =
                                  snapshot.data as List<DatabaseNote>;
                              return NotesListView(
                                onDeleteNote: (note) async {
                                  await _notesService.deleteNote(id: note.id);
                                },
                                notes: allNotes,
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          default:
                            return const CircularProgressIndicator();
                        }
                      });
                default:
                  return const CircularProgressIndicator();
              }
            }));
  }
}
