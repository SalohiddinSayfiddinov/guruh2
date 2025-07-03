import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/presentation/home/cubit/books/category_cubit.dart';
import 'package:guruh2/presentation/home/cubit/books/category_state.dart';
import 'package:guruh2/presentation/home/cubit/vendors/vendors_categories_cubit.dart';
import 'package:guruh2/presentation/home/cubit/vendors/vendors_cubit.dart';
import 'package:guruh2/presentation/home/cubit/vendors/vendors_state.dart';
import 'package:guruh2/presentation/home/data/models/category_model.dart';
import 'package:guruh2/presentation/home/data/models/vendor_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = PageController();
  @override
  void initState() {
    context.read<VendorsCategoriesCubit>().getVendorCategories();
    context.read<VendorsCubit>().getVendors();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  int selectedIndex = 0;

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
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            BlocBuilder<VendorsCategoriesCubit, VendorsState>(
              builder: (context, state) {
                if (state is VendorsLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: SizedBox(
                      height: 20,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 20.0);
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is VendorsError) {
                  return Center(child: Text(state.message));
                } else if (state is VendorsCategorySuccess) {
                  return SizedBox(
                    height: 40,
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(width: 20.0);
                      },
                      scrollDirection: Axis.horizontal,
                      itemCount: state.categories.length,
                      itemBuilder: (context, index) {
                        final CategoryModel category = state.categories[index];
                        return StatefulBuilder(
                            builder: (context, builderSetState) {
                          return InkWell(
                            onTap: () {
                              builderSetState(() {
                                selectedIndex = index;
                              });
                              context.read<VendorsCubit>().getVendors(
                                    category: category.id.toString(),
                                  );
                            },
                            child: Text(
                              category.name,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: selectedIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.w400,
                              ),
                            ),
                          );
                        });
                      },
                    ),
                  );
                } else {
                  return Center(child: Text(state.runtimeType.toString()));
                }
              },
            ),
            const SizedBox(height: 20),
            BlocBuilder<VendorsCubit, VendorsState>(
              builder: (context, state) {
                if (state is VendorsLoading) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: SizedBox(
                      height: 20,
                      child: ListView.separated(
                        separatorBuilder: (context, index) {
                          return const SizedBox(width: 20.0);
                        },
                        scrollDirection: Axis.horizontal,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4.0),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                } else if (state is VendorsError) {
                  return Center(child: Text(state.message));
                } else if (state is VendorsSuccess) {
                  if (state.vendors.isEmpty) {
                    return const Center(
                      child: Text('Hozircha ma\'lumot yo\'q'),
                    );
                  } else {
                    return Expanded(
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: state.vendors.length,
                        itemBuilder: (context, index) {
                          final VendorModel category = state.vendors[index];

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Container(
                                  color: Colors.amber,
                                ),
                              ),
                              Text(category.name),
                              Row(
                                children: List.generate(
                                  5,
                                  (index) {
                                    return Icon(
                                      Icons.star,
                                      size: 20.0,
                                      color: index <= category.rating - 1
                                          ? Colors.yellow
                                          : Colors.black,
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  }
                } else {
                  return Center(child: Text(state.runtimeType.toString()));
                }
              },
            ),
          ],
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
