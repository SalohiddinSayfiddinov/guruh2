part of 'cart_cubit.dart';

abstract class CartState {}

final class CartInitial extends CartState {}

final class CartLoading extends CartState {}

final class CartError extends CartState {
  final String message;
  CartError(this.message);
}

final class CartSuccess extends CartState {
  final List<CartItemModel> data;
  CartSuccess(this.data);
}
