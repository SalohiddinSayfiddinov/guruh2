import 'package:guruh2/features/cart/data/model/book_model.dart';

abstract class BooksState {}

class BooksInit extends BooksState {}

class BooksLoading extends BooksState {}

class BooksError extends BooksState {
  final String message;
  BooksError(this.message);
}

class BooksSuccess extends BooksState {
  final List<BookModel> books;
  BooksSuccess(this.books);
}
