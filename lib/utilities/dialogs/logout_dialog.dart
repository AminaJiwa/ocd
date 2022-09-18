import 'package:flutter/material.dart';
import 'package:ocd/utilities/dialogs/generic_dialog.dart';

Future<bool> showLogoutDialog(BuildContext context) {
  return showGenericDialog<bool>(
    context: context,
    title: "Logout",
    content: "Are you sure you want to logout?",
    optionsBuilder: () => {
      "Cancel": false,
      "Log out": true,
    },
  ).then(
    (value) => value ?? false,
  );
}
