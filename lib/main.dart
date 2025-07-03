import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/presentation/home/cubit/books/category_cubit.dart';
import 'package:guruh2/presentation/home/cubit/vendors/vendors_categories_cubit.dart';
import 'package:guruh2/presentation/home/cubit/vendors/vendors_cubit.dart';
import 'package:guruh2/presentation/home/view/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
        scaffoldBackgroundColor: Colors.white,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => CategoryCubit()),
          BlocProvider(create: (context) => VendorsCubit()),
          BlocProvider(create: (context) => VendorsCategoriesCubit()),
        ],
        child: const HomePage(),
      ),
    );
  }
}
