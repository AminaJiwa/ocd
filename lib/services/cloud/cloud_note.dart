import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocd/services/cloud/cloud_storage_constants.dart';
import "package:ocd/services/cloud/cloud_storage_exceptions.dart";
import 'package:flutter/material.dart';

//3 important fields - primary key, textField and userID
@immutable
class CloudNote {
  final String documentId;
  final String ownerUserId;
  final String text;

  const CloudNote({
    required this.documentId,
    required this.ownerUserId,
    required this.text,
  });
//map is QueryDocumentSnapshot
//signature of the function
  CloudNote.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        text = snapshot.data()[textFieldName] as String;
}
