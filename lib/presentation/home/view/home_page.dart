import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/presentation/home/cubit/category_cubit.dart';
import 'package:guruh2/presentation/home/cubit/category_state.dart';
import 'package:guruh2/presentation/home/data/models/category_model.dart';
import 'package:guruh2/presentation/home/data/repo/category_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController();
  @override
  void initState() {
    context.read<CategoryCubit>().getCategories();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Home'),
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          actions: [
            IconButton(
              onPressed: () async {
                final SharedPreferences prefs =
                    await SharedPreferences.getInstance();
                final String? token = prefs.getString('token');
                print(token);
              },
              icon: const Icon(Icons.notifications_outlined),
            ),
            const SizedBox(width: 12.0)
          ],
        ),
        body: BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else if (state is CategoryError) {
              return Center(
                child: Text(
                  state.error,
                  style: const TextStyle(fontSize: 40.0, color: Colors.red),
                ),
              );
            } else if (state is CategoryLoaded) {
              return ListView.builder(
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final CategoryModel category = state.categories[index];
                  return ListTile(title: Text(category.name));
                },
              );
            } else {
              return Center(
                child: Text(
                  state.runtimeType.toString(),
                  style: const TextStyle(fontSize: 40.0),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class MyTab extends StatelessWidget {
  final String text;
  const MyTab({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    print('Build ishladi');
    return Center(
      child: Text(text),
    );
  }
}
