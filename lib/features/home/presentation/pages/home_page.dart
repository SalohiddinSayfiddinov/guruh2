import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/features/home/data/note_model.dart';
import 'package:guruh2/features/home/presentation/cubit/note_cubit.dart';
import 'package:guruh2/features/home/presentation/cubit/user_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (state is UserError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red, fontSize: 20),
              ),
            );
          } else if (state is UserLoaded) {
            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Card(
                  child: ListTile(
                    title: Text(user.id),
                    subtitle: Text(user.name ?? 'No Name'),
                    trailing: IconButton(
                      onPressed: () {
                        context
                            .read<NoteCubit>()
                            .getNote('DOFaIvKmpBdBsUOL0Xn5');
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
