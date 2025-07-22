import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/firebase_features/cubit/f_auth_cubit.dart';
import 'package:guruh2/firebase_features/f_sign_up_page.dart';

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
        home: BlocProvider(
          create: (context) => FAuthCubit(),
          child: const FSignUpPage(),
        ));
  }
}
