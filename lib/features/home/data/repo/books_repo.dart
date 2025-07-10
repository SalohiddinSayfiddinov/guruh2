import 'dart:convert';

import 'package:guruh2/core/constants/api.dart';
import 'package:guruh2/features/cart/data/model/book_model.dart';
import 'package:http/http.dart' as http;

class BooksRepo {
  Future<List<BookModel>> getBooks() async {
    try {
      final response = await http.get(Uri.parse(Api.books));
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List<BookModel> books =
            (data as List).map((e) => BookModel.fromJson(e)).toList();
        return books;
      }
      throw Exception(data['detail'].toString());
    } catch (e) {
      rethrow;
    }
  }
}
