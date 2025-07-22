import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/firebase_features/cubit/f_auth_cubit.dart';
import 'package:guruh2/firebase_features/cubit/f_auth_state.dart';
import 'package:provider/provider.dart';

class FSignUpPage extends StatelessWidget {
  const FSignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: BlocConsumer<FAuthCubit, FAuthState>(
              listener: (context, state) {
                if (state is FAuthFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.error)),
                  );
                } else if (state is FAuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.user.email ?? '')),
                  );
                }
              },
              builder: (context, state) {
                return SizedBox(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<FAuthCubit>().signUp(
                            'test@gmail.com',
                            'test1234',
                          );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: state is FAuthLoading
                        ? const CircularProgressIndicator.adaptive(
                            valueColor: AlwaysStoppedAnimation(Colors.white),
                          )
                        : const Text("Sign Up"),
                  ),
                );
              },
            )),
      ),
    );
  }
}
