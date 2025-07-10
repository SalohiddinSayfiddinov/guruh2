import 'dart:convert';

import 'package:guruh2/core/constants/api.dart';
import 'package:guruh2/features/cart/data/model/cart_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo {
  Future<List<CartItemModel>> getCart() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      final response = await http.get(
        Uri.parse(Api.cart),
        headers: {
          'accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        final List result = data['items'];

        final List<CartItemModel> cart =
            result.map((e) => CartItemModel.fromJson(e)).toList();
        return cart;
      }
      throw Exception(data['detail'] ?? 'Loginda error');
    } catch (e) {
      rethrow;
    }
  }

  Future<String> addToCart({required int bookId, required int quantity}) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');
      final response = await http.post(
        Uri.parse(Api.cartAdd),
        headers: {
          'accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({"book_id": bookId, "quantity": quantity}),
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return 'Success';
      }
      throw Exception(data['detail'] ?? 'Failed to add item to cart');
    } catch (e) {
      rethrow;
    }
  }
}
