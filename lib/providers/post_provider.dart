import 'package:flutter/material.dart';
import 'package:guruh2/models/post.dart';
import 'package:guruh2/repositories/post_repo.dart';

class PostProvider extends ChangeNotifier {
  final List<Post> posts = [];
  String? error;
  String? createError;
  bool isLoading = false;
  bool isCreating = false;

  Future<void> getPosts() async {
    isLoading = true;
    notifyListeners();
    try {
      final result = await PostRepo().getPosts();
      posts.addAll(result);
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cretePost(Post post) async {
    isCreating = true;
    notifyListeners();
    try {
      final result = await PostRepo().createPost(post);
      posts.insert(0, result);
    } catch (e) {
      createError = e.toString();
    } finally {
      isCreating = false;
      notifyListeners();
    }
  }
}
