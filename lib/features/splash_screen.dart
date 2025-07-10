import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/core/constants/app_colors.dart';
import 'package:guruh2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:guruh2/features/auth/presentation/view/login_page.dart';
import 'package:guruh2/features/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:guruh2/features/home/cubit/books/books_cubit.dart';
import 'package:guruh2/features/home/cubit/books/category_cubit.dart';
import 'package:guruh2/features/home/cubit/vendors/vendors_categories_cubit.dart';
import 'package:guruh2/features/home/cubit/vendors/vendors_cubit.dart';
import 'package:guruh2/features/home/view/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    await Future.delayed(const Duration(seconds: 1));
    if (token != null) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => MultiBlocProvider(
              providers: [
                BlocProvider(create: (context) => CategoryCubit()),
                BlocProvider(create: (context) => BooksCubit()),
                BlocProvider(create: (context) => CartCubit()),
                BlocProvider(create: (context) => VendorsCubit()),
                BlocProvider(create: (context) => VendorsCategoriesCubit()),
              ],
              child: const HomePage(),
            ),
          ),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => BlocProvider(
              create: (context) => AuthCubit(),
              child: const LoginPage(),
            ),
          ),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary500,
      body: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 3.03,
            horizontal: 12.62,
          ),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 13,
            children: [
              Image(
                image: AssetImage('assets/images/book_logo.png'),
              ),
              Text(
                'Bazar',
                style: TextStyle(
                  fontSize: 31.55,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
