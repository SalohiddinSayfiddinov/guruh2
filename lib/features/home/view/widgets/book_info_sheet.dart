import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/core/constants/app_colors.dart';
import 'package:guruh2/features/cart/data/model/book_model.dart';
import 'package:guruh2/features/cart/presentation/cubit/cubit/cart_cubit.dart';
import 'package:guruh2/widgets/my_buttons.dart';

class BookInfoSheet extends StatelessWidget {
  final BookModel book;
  const BookInfoSheet({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(24.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 24.0,
        horizontal: 12.0,
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              width: 237,
              height: 313,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w700,
                  color: AppColors.grey900,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.favorite,
                  color: AppColors.grey900,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  height: 48.0,
                  radius: 48.0,
                  title: 'Continue shopping',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Expanded(
                  child: BlocConsumer<CartCubit, CartState>(
                listener: (context, state) {
                  if (state is CartError) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.message),
                        backgroundColor: Colors.red,
                      ),
                    );
                  } else if (state is CartSuccess) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('success'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return SecondaryButton(
                    title: state is CartLoading ? 'Loading...' : 'Add to cart',
                    onPressed: state is CartLoading
                        ? null
                        : () {
                            context.read<CartCubit>().addToCart(
                                  bookId: book.id,
                                  quantity: 1,
                                );
                          },
                  );
                },
              )),
            ],
          ),
        ],
      ),
    );
  }
}
