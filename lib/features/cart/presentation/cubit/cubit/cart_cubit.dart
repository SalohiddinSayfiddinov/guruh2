import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guruh2/features/cart/data/model/cart_model.dart';
import 'package:guruh2/features/cart/data/repo/cart_repo.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> getCart() async {
    emit(CartLoading());
    try {
      final result = await CartRepo().getCart();
      emit(CartSuccess(result));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }

  Future<void> addToCart({required int bookId, required int quantity}) async {
    emit(CartLoading());
    try {
      final result = await CartRepo().addToCart(
        bookId: bookId,
        quantity: quantity,
      );
      emit(CartSuccess([]));
    } catch (e) {
      emit(CartError(e.toString()));
    }
  }
}
