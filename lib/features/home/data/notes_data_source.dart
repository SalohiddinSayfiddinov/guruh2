import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guruh2/features/home/data/note_model.dart';

class NotesDataSource {
  final CollectionReference _notes =
      FirebaseFirestore.instance.collection('notes');

  Future<void> addNote(NoteModel note) async {
    try {
      await _notes.add(note.toMap());
    } catch (e) {
      throw Exception('Failed to add note: $e');
    }
  }

  Future<NoteModel> getNote(String id) async {
    try {
      final result = await _notes.doc(id).get();
      if (result.exists) {
        return NoteModel.fromMap(result.data() as Map<String, dynamic>);
      } else {
        throw Exception('Note not found');
      }
    } catch (e) {
      throw Exception('Failed to fetch note: $e');
    }
  }
}
