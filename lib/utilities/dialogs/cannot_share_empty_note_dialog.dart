import 'package:flutter/material.dart';
import 'package:ocd/utilities/dialogs/generic_dialog.dart';

Future<void> showCannotShareEmptyNoteDialog(BuildContext context) {
  return showGenericDialog<void>(
    context: context,
    title: "Sharing",
    content: "Unfortunately, empty notes can't be shared.",
    optionsBuilder: () => {
      "Ok": null,
    },
  );
}
