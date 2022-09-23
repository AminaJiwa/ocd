import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ocd/services/cloud/cloud_note.dart';
import 'package:ocd/services/cloud/cloud_storage_constants.dart';
import 'package:ocd/services/cloud/cloud_storage_exceptions.dart';

class FirebaseCloudStorage {
  final notes = FirebaseFirestore.instance.collection("notes");

  Future<void> deleteNote({
    required String documentId,
  }) async {
    try {
      await notes.doc(documentId).delete();
    } catch (e) {
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void> updateNote({
    required String documentId,
    required String text,
  }) async {
    try {
      //provides the path to the document
      await notes.doc(documentId).update({textFieldName: text});
    } catch (e) {
      throw CouldNotUpdateNoteException();
    }
  }

//snapshot - if you want to subscribe to a stream of data as it is evolving
  Stream<Iterable<CloudNote>> allNotes({required String ownerUserId}) =>
      //documents in the query snapshot
      notes.snapshots().map((event) => event.docs
          //mapping each document to a cloud note
          .map((doc) => CloudNote.fromSnapshot(doc))
          //where clause to show only notes that belong to specific userId
          .where((note) => note.ownerUserId == ownerUserId));

  Future<Iterable<CloudNote>> getNotes({required String ownerUserId}) async {
    try {
      return await notes
          //where is a query
          .where(
            ownerUserIdFieldName,
            isEqualTo: ownerUserId,
          )
          //get is a future - takes a snapshot at that point in time and returns it
          .get()
          .then((value) {
        return value.docs.map(
          (doc) {
            return CloudNote(
              documentId: doc.id,
              ownerUserId: doc.data()[ownerUserIdFieldName] as String,
              text: doc.data()[textFieldName] as String,
            );
          },
        );
      });
    } catch (e) {
      throw CouldNotGetAllNotesException();
    }
  }

  void createNewNote({required String ownerUserId}) async {
    await notes.add({
      ownerUserIdFieldName: ownerUserId,
      textFieldName: "",
    });
  }

  //Singleton is a creational design pattern, which ensures that only one object
  // of its kind exists and provides a single point of access to it for any other code.
  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  //fatory constructor - default constructor of this class
  //talks with static final field which calls the private intialiser
  factory FirebaseCloudStorage() => _shared;
}
