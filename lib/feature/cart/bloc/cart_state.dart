part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
abstract class CartActionState extends CartState {}

class CartLoadedSuccessState extends CartState {
  final List<ProductDataModel> cartItems;

  CartLoadedSuccessState({required this.cartItems});
}

