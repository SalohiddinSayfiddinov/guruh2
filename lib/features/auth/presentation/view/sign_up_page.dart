import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guruh2/core/constants/app_colors.dart';
import 'package:guruh2/core/widgets/app_snack_bar.dart';
import 'package:guruh2/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:guruh2/features/auth/presentation/cubit/auth_state.dart';
import 'package:guruh2/features/auth/presentation/view/verification_email.dart';
import 'package:guruh2/widgets/my_buttons.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  bool hasMinLength(String password) => password.length >= 8;
  bool hasNumber(String password) => RegExp(r'\d').hasMatch(password);
  bool hasLetter(String password) => RegExp(r'[A-Za-z]').hasMatch(password);
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sign Up',
                style: GoogleFonts.openSans(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: AppColors.grey900,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                'Create account and choose favorite menu',
                style: TextStyle(
                  fontSize: 16.0,
                  color: AppColors.grey500,
                ),
              ),
              const SizedBox(height: 24.0),
              AppTextFieldWithTitle(
                title: 'Name',
                controller: _nameController,
                hintText: 'Your name',
                validator: (value) {
                  if (value!.length < 3) {
                    return "Please enter a valid name";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              AppTextFieldWithTitle(
                title: 'Email',
                controller: _emailController,
                hintText: 'Your email',
                validator: (value) {
                  if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                      .hasMatch(value!)) {
                    return "Please enter a valid email";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              AppTextFieldWithTitle(
                title: 'Password',
                controller: _passwordController,
                hintText: 'Your password',
                isPassword: true,
              ),
              const SizedBox(height: 16.0),
              _PasswordChecker(
                isPressed: isPressed,
                isCorrect: hasMinLength(_passwordController.text),
                message: 'Minimum 8 characters',
              ),
              _PasswordChecker(
                isPressed: isPressed,
                isCorrect: hasNumber(_passwordController.text),
                message: 'Atleast 1 number (1-9)',
              ),
              _PasswordChecker(
                isPressed: isPressed,
                isCorrect: hasLetter(_passwordController.text),
                message: 'Atleast lowercase or uppercase letters',
              ),
              const SizedBox(height: 24.0),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => AuthCubit(),
                          child: VerificationEmail(
                            email: _emailController.text.trim(),
                          ),
                        ),
                      ),
                    );
                  } else if (state is AuthError) {
                    AppSnackBar.show(context, state.error);
                  }
                },
                builder: (context, state) {
                  return PrimaryButton(
                    title: state is AuthLoading ? 'Loading...' : 'Register',
                    radius: 48.0,
                    height: 48.0,
                    onPressed: state is AuthLoading
                        ? null
                        : () async {
                            setState(() {
                              isPressed = true;
                            });
                            if (_formKey.currentState!.validate() &&
                                hasLetter(_passwordController.text) &&
                                hasNumber(_passwordController.text) &&
                                hasMinLength(_passwordController.text)) {
                              context.read<AuthCubit>().signUp(
                                    _emailController.text.trim(),
                                    _passwordController.text.trim(),
                                  );
                            }
                          },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppTextFieldWithTitle extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;

  const AppTextFieldWithTitle({
    super.key,
    required this.title,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            color: AppColors.grey900,
          ),
        ),
        const SizedBox(height: 6.0),
        AppTextField(
          controller: controller,
          isPassword: isPassword,
          hintText: hintText,
          validator: validator,
        ),
      ],
    );
  }
}

class AppTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.isPassword = false,
    this.validator,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool obscure = true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onTapOutside: (event) => FocusScope.of(context).unfocus(),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: GoogleFonts.roboto(
          fontSize: 16.0,
          color: const Color(0xFFB8B8B8),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: AppColors.primary500),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          borderSide: BorderSide(color: Colors.red),
        ),
        filled: true,
        fillColor: const Color(0xFFFAFAFA),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    obscure = !obscure;
                  });
                },
                icon: SvgPicture.asset(obscure
                    ? 'assets/icons/eye.svg'
                    : 'assets/icons/eye-slash.svg'),
              )
            : null,
      ),
      obscureText: widget.isPassword && obscure,
      cursorHeight: 20.0,
      cursorColor: AppColors.primary500,
      style: GoogleFonts.roboto(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        color: AppColors.grey900,
      ),
      validator: widget.validator,
    );
  }
}

class _PasswordChecker extends StatelessWidget {
  final bool isPressed;
  final bool isCorrect;
  final String message;
  const _PasswordChecker(
      {required this.isPressed,
      required this.isCorrect,
      required this.message});
  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isPressed,
      child: Row(
        children: [
          isCorrect
              ? const Icon(Icons.check, color: Color(0xFFA28CE0))
              : const Icon(Icons.clear, color: Colors.red),
          Text(message),
        ],
      ),
    );
  }
}
