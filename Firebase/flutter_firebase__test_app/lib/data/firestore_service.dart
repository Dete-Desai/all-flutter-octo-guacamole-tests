import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase__test_app/data/model/note.dart';

class FirestoreService {
  static final FirestoreService _firestoreService = FirestoreService._internal();
  
  FirebaseFirestore _db = FirebaseFirestore.instance;

  FirestoreService._internal();

  factory FirestoreService() {
    return _firestoreService;
  }

  Stream<List<Note>> getNotes() {
    return _db.collection('notes').snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Note.fromMap(doc.data(), doc.id),
              )
              .toList(),
        );
  }

  Future<void> addNote(Note note) async{
    _db.collection('notes').add(note.toMap()).catchError((onError){
      print(onError);
    });
  }

  Future<void> deleteNote(String id) {
    return _db.collection('notes').doc(id).delete();
  }

  Future<void> updateNote(Note note) {
    return _db.collection('notes').doc(note.id).update(note.toMap());
  }
}
