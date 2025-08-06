import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/core/routes/app_pages.dart';
import 'package:guruh2/core/routes/app_routes.dart';
import 'package:guruh2/core/theme/theme_provider.dart';
import 'package:guruh2/features/home/presentation/cubit/home_cubit.dart';
import 'package:guruh2/features/home/presentation/pages/home_page.dart';
import 'package:guruh2/firebase_features/cubit/f_auth_cubit.dart';
import 'package:provider/provider.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, provider, _) {
        return MaterialApp(
          theme: provider.currentTheme,
          initialRoute: AppPages.signUp,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
