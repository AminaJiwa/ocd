//exception classes arent usually marked as immutable (@immutable) mostly data classes are
//parent exception - dont throw this one, make subclasses of this exception
class CloudStorageException implements Exception {
  const CloudStorageException();
}

//CRUD exceptions
class CouldNotCreateNoteException extends CloudStorageException {}

class CouldNotGetAllNotesException extends CloudStorageException {}

class CouldNotUpdateNoteException extends CloudStorageException {}

class CouldNotDeleteNoteException extends CloudStorageException {}
