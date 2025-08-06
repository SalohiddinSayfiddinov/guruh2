import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/core/routes/app_pages.dart';
import 'package:guruh2/core/routes/page_not_found.dart';
import 'package:guruh2/features/home/presentation/cubit/home_cubit.dart';
import 'package:guruh2/features/home/presentation/pages/home_page.dart';
import 'package:guruh2/firebase_features/cubit/f_auth_cubit.dart';
import 'package:guruh2/firebase_features/f_sign_up_page.dart';


class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppPages.home:
        return MaterialPageRoute(
          builder: (context) => MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => HomeCubit()),
              BlocProvider(create: (context) => FAuthCubit()),
            ],
            child: HomePage(title: args as bool),
          ),
        );
      case AppPages.signUp:
        return MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => FAuthCubit(),
            child: const FSignUpPage(),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const PageNotFound(),
        );
    }
  }
}
