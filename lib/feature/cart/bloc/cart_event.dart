part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartItemRemoveEvent extends CartEvent {
  final ProductDataModel productDataModel;

  CartItemRemoveEvent({required this.productDataModel});
}
