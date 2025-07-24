import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/features/home/presentation/cubit/note_cubit.dart';
import 'package:guruh2/features/home/presentation/cubit/user_cubit.dart';
import 'package:guruh2/features/home/presentation/pages/home_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Colors.white,
          todayBorder: BorderSide(color: Colors.red),
          todayBackgroundColor: WidgetStatePropertyAll(Colors.red),
          todayForegroundColor: WidgetStatePropertyAll(Colors.white),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UserCubit()),
          BlocProvider(create: (context) => NoteCubit()),
        ],
        child: const HomePage(),
      ),
    );
  }
}
