import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/features/cart/data/repo/cart_repo.dart';
import 'package:guruh2/features/home/cubit/books/books_cubit.dart';
import 'package:guruh2/features/home/view/widgets/cart_tab.dart';
import 'package:guruh2/features/home/view/widgets/home_tab.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController();
  @override
  void initState() {
    // context.read<VendorsCategoriesCubit>().getVendorCategories();
    // context.read<VendorsCubit>().getVendors();
    context.read<BooksCubit>().getBooks();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  int selectedIndex = 0;

  List<Widget> pages = const [
    HomeTab(),
    CartTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              print('Bosildi');
              final result = await CartRepo().getCart();
              print(result[1].book.title);
              // final SharedPreferences prefs =
              //     await SharedPreferences.getInstance();
              // final String? token = prefs.getString('token');
              // print(token);
            },
            icon: const Icon(Icons.notifications_outlined),
          ),
          const SizedBox(width: 12.0)
        ],
      ),
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (value) => setState(() {
                selectedIndex = value;
              }),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            )
          ]),
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
