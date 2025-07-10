import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/core/constants/app_colors.dart';
import 'package:guruh2/features/cart/data/model/book_model.dart';
import 'package:guruh2/features/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:guruh2/features/home/cubit/books/books_cubit.dart';
import 'package:guruh2/features/home/cubit/books/books_state.dart';
import 'package:guruh2/features/home/view/widgets/book_info_sheet.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BooksCubit, BooksState>(
      builder: (context, state) {
        if (state is BooksLoading) {
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is BooksError) {
          return Center(child: Text(state.message));
        } else if (state is BooksSuccess) {
          return GridView.builder(
            padding: const EdgeInsets.all(12.0),
            itemCount: state.books.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 220,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
            ),
            itemBuilder: (context, index) {
              final BookModel book = state.books[index];
              return InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    scrollControlDisabledMaxHeightRatio: .7,
                    isScrollControlled: false,
                    builder: (context) {
                      return BlocProvider(
                        create: (context) => CartCubit(),
                        child: BookInfoSheet(book: book),
                      );
                    },
                  );
                },
                child: Column(
                  spacing: 5.0,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 150,
                      decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                    ),
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey900,
                      ),
                    ),
                    Text(
                      "\$${book.price}",
                      style: const TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primary500,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
