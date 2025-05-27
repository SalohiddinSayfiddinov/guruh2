import 'package:flutter/material.dart';
import 'package:guruh2/models/post.dart';
import 'package:guruh2/providers/post_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().getPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (provider.error != null) {
            return Center(child: Text(provider.error!));
          } else {
            return ListView.builder(
              itemCount: provider.posts.length,
              itemBuilder: (context, index) {
                final post = provider.posts[index];
                return Card(
                  child: ListTile(
                    title: Text(post.title),
                    subtitle: Text(post.body),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final post = const Post(
            id: 1,
            userId: 1,
            title: 'New Post',
            body: 'New Body',
          );
          await context.read<PostProvider>().cretePost(post);
          if (context.read<PostProvider>().createError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(context.read<PostProvider>().createError!)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Post created successfully')),
            );
          }
        },
        child: context.watch<PostProvider>().isCreating
            ? const CircularProgressIndicator.adaptive()
            : const Icon(Icons.add),
      ),
    );
  }
}
