import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:guruh2/core/constants/app_colors.dart';
import 'package:guruh2/presentation/auth/presentation/cubit/auth_cubit.dart';
import 'package:guruh2/presentation/auth/presentation/cubit/auth_state.dart';
import 'package:guruh2/presentation/auth/presentation/view/login_page.dart';
import 'package:guruh2/widgets/my_buttons.dart';
import 'package:pinput/pinput.dart';

class VerificationEmail extends StatefulWidget {
  final String email;
  const VerificationEmail({super.key, required this.email});

  @override
  State<VerificationEmail> createState() => _VerificationEmailState();
}

class _VerificationEmailState extends State<VerificationEmail> {
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0).copyWith(top: 100.0),
            child: Column(
              children: [
                Text(
                  'Verification Email',
                  style: GoogleFonts.openSans(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Please enter the code we just sent to email',
                  style: GoogleFonts.roboto(
                    fontSize: 16.0,
                    color: AppColors.grey500,
                  ),
                ),
                Text(
                  widget.email,
                  style: GoogleFonts.roboto(
                    fontSize: 16.0,
                    color: AppColors.grey900,
                  ),
                ),
                const SizedBox(height: 40.0),
                Pinput(
                  controller: _codeController,
                  enabled: false,
                  length: 4,
                  defaultPinTheme: const PinTheme(
                    width: 52,
                    height: 52,
                    margin: EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      color: Colors.redAccent,
                    ),
                    textStyle: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.grey900,
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(state.error),
                          backgroundColor: Colors.red,
                        ),
                      );
                    } else if (state is AuthSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BlocProvider(
                            create: (context) => AuthCubit(),
                            child: const LoginPage(),
                          ),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return PrimaryButton(
                      title: state is AuthLoading ? 'Loading...' : 'Continue',
                      radius: 48.0,
                      height: 48.0,
                      onPressed: state is AuthLoading
                          ? null
                          : () {
                              if (_codeController.length == 4) {
                                context.read<AuthCubit>().verify(
                                      widget.email,
                                      _codeController.text,
                                    );
                              }
                            },
                    );
                  },
                ),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 380,
            child: GridView.builder(
              itemCount: 12,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisExtent: 80.0,
              ),
              itemBuilder: (context, index) {
                return Material(
                  color: AppColors.primary500,
                  child: InkWell(
                    onTap: () {
                      if (index == 11 && _codeController.text != '') {
                        _codeController.text = _codeController.text
                            .substring(0, _codeController.text.length - 1);
                      } else if (index == 9 && _codeController.length < 4) {
                        _codeController.text += '.';
                      } else if (index == 10 && _codeController.length < 4) {
                        _codeController.text += '0';
                      } else if (index != 11 && _codeController.length < 4) {
                        _codeController.text += '${index + 1}';
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 60,
                      width: 60,
                      child: index == 11
                          ? const Icon(
                              Icons.backspace_outlined,
                              color: Colors.white,
                            )
                          : Text(
                              showNumber(index),
                              style: GoogleFonts.openSans(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String showNumber(int index) {
    if (index == 9) {
      return '.';
    } else if (index == 10) {
      return '0';
    } else {
      return "${index + 1}";
    }
  }
}
