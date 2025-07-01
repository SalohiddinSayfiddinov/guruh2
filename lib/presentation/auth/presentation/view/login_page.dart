import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/core/constants/app_colors.dart';
import 'package:guruh2/core/widgets/app_snack_bar.dart';
import 'package:guruh2/presentation/auth/presentation/cubit/auth_cubit.dart';
import 'package:guruh2/presentation/auth/presentation/cubit/auth_state.dart';
import 'package:guruh2/presentation/auth/presentation/view/sign_up_page.dart';
import 'package:guruh2/presentation/home/view/home_page.dart';
import 'package:guruh2/widgets/my_buttons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              spacing: 10.0,
              children: [
                AppTextFieldWithTitle(
                  title: 'Email',
                  controller: _emailController,
                  hintText: 'Enter you email',
                  validator: (value) {
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value!)) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                AppTextFieldWithTitle(
                  title: 'Password',
                  controller: _passwordController,
                  hintText: 'Enter you password',
                  validator: (value) {
                    if (value != null) {
                      if (value.isEmpty) {
                        return 'Enter password';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10.0),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      AppSnackBar.show(context, state.error);
                    } else if (state is AuthSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButton(
                      radius: 48.0,
                      height: 48.0,
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              if (_formKey.currentState?.validate() ?? false) {
                                context.read<AuthCubit>().login(
                                      _emailController.text.trim(),
                                      _passwordController.text.trim(),
                                    );
                              }
                            },
                      title: state is AuthLoading ? 'Loading...' : 'Login',
                    );
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => AuthCubit(),
                              child: const SignUpPage(),
                            ),
                          ),
                        );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary500,
                      ),
                      child: const Text('Sign Up'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
