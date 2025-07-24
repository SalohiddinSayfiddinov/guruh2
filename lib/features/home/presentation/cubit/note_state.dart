part of 'note_cubit.dart';

abstract class NoteState {}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
  final List<NoteModel> notes;

  NoteLoaded({required this.notes});
}

class NoteError extends NoteState {
  final String message;

  NoteError({required this.message});
}

class NoteAdded extends NoteState {
  NoteAdded();
}
