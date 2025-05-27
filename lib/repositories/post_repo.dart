import 'dart:convert';

import 'package:guruh2/models/post.dart';
import 'package:http/http.dart' as http;

class PostRepo {
  final String url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> getPosts() async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        final List<Post> posts = data.map((e) => Post.fromJson(e)).toList();
        return posts;
      }
      throw 'Xatolik yuz berdi';
    } catch (e, s) {
      throw '$e, $s';
    }
  }

  Future<Post> createPost(Post post) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            "userId": post.userId,
            "id": post.id,
            "title": post.title,
            "body": post.body,
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final result = Post.fromJson(data);
        return result;
      }
      throw Exception('Xatolik yuz berdi');
    } catch (e, s) {
      print('Error: $e');
      throw Exception('$e, $s');
    }
  }
}
