import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/features/home/cubit/books/books_state.dart';
import 'package:guruh2/features/home/data/repo/books_repo.dart';

class BooksCubit extends Cubit<BooksState> {
  BooksCubit() : super(BooksInit());

  Future<void> getBooks() async {
    emit(BooksLoading());
    try {
      final result = await BooksRepo().getBooks();
      emit(BooksSuccess(result));
    } catch (e) {
      emit(BooksError(e.toString()));
    }
  }
}
