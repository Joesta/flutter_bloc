import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tut/data/cart_items.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../home/model/product_data_model.dart';

part 'cart_event.dart';

part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartItemRemoveEvent>(cartItemRemoveEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartLoadedSuccessState(cartItems: cartItems));

    debugPrint('items added into cart {}');
    cartItems.forEach((element) => debugPrint(element.productName));
  }

  FutureOr<void> cartItemRemoveEvent(
      CartItemRemoveEvent event, Emitter<CartState> emit) {
    cartItems.remove(event.productDataModel);
    emit(CartLoadedSuccessState(cartItems: cartItems));
    debugPrint('item removed from cart');
  }
}
