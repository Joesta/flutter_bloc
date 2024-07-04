import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_tut/data/grocery_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../model/product_data_model.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishListButtonNavigateEvent>(homeWishListButtonNavigateEvent);
    on<HomeCartButtonNavigateEvent>(homeCartButtonNavigateEvent);
    on<HomeProductWishListButtonClickedEvent>(
        homeProductWishListButtonClickedEvent);
    on<HomeProductCartButtonClickedEvent>(homeProductCartButtonClickedEvent);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    debugPrint('homeInitialEvent fired');
    // first emit loading state.
    emit(HomeLoadingState());
    // after loading, assume we are now reading from data source to retrieve data.
    await Future.delayed(const Duration(seconds: 3));
    // assuming data is done loading, lets emit the HomeLoadedSuccessState and pass in the required information to the state.
    emit(
      HomeLoadedSuccessState(productDataModel:
        GroceryData.groceryList
            .map(
              (e) => ProductDataModel(
                  productName: e['name'], quantity: e['quantity']),
            )
            .toList(),
      ),
    );

    debugPrint('homeInitialEvent done firing');
  }

  FutureOr<void> homeWishListButtonNavigateEvent(
      HomeWishListButtonNavigateEvent event, Emitter<HomeState> emit) {
    debugPrint('wishlist Nav event fired');
    emit(HomeNavigationToWishListPageActionState());
  }

  FutureOr<void> homeCartButtonNavigateEvent(
      HomeCartButtonNavigateEvent event, Emitter<HomeState> emit) {
    debugPrint('cart Nav button fired');
    emit(HomeNavigationToCartPageActionState());
  }

  FutureOr<void> homeProductWishListButtonClickedEvent(
      HomeProductWishListButtonClickedEvent event, Emitter<HomeState> emit) {
    debugPrint('homeProduct wishList button fired');
  }

  FutureOr<void> homeProductCartButtonClickedEvent(
      HomeProductCartButtonClickedEvent event, Emitter<HomeState> emit) {
    debugPrint('homeProduct cart button fired');
  }
}
