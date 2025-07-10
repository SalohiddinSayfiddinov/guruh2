import 'dart:convert';

import 'package:guruh2/core/constants/api.dart';
import 'package:guruh2/features/home/data/models/category_model.dart';
import 'package:http/http.dart' as http;

class CategoryRepo {
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await http.get(
        Uri.parse("${Api.baseUrl}${Api.categories}"),
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final categories = (data as List)
            .map(
              (e) => CategoryModel.fromJson(e),
            )
            .toList();
        return categories;
      }
      throw Exception(data['detail'] ?? '');
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
