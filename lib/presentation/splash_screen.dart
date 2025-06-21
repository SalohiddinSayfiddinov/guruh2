import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/core/constants/app_colors.dart';
import 'package:guruh2/presentation/onboarding/cubit/onboarding_cubit.dart';
import 'package:guruh2/presentation/onboarding/view/onboarding_page.dart';

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
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => OnboardingCubit(),
            child: const OnboardingPage(),
          ),
        ),
        (route) => false,
      );
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
