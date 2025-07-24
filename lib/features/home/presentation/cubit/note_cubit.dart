import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/features/home/data/note_model.dart';
import 'package:guruh2/features/home/data/notes_data_source.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  Future<void> addNote(NoteModel note) async {
    emit(NoteLoading());
    try {
      await NotesDataSource().addNote(note);
      emit(NoteAdded());
    } catch (e) {
      emit(NoteError(message: e.toString()));
    }
  }

  Future<void> getNote(String id) async {
    emit(NoteLoading());
    try {
      final note = await NotesDataSource().getNote(id);
      print(note);
      emit(NoteLoaded(notes: [note]));
    } catch (e) {
      emit(NoteError(message: e.toString()));
    }
  }
}
