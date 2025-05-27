import 'package:flutter/material.dart';
import 'package:guruh2/pages/home_page.dart';
import 'package:guruh2/providers/post_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostProvider(),
      child: const MaterialApp(
        home: HomePage(),
      ),
    );
  }
}
