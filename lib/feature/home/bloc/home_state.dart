part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

// handles actions states
abstract class HomeActionState extends HomeState {}

// home states.
final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedSuccessState extends HomeState {
  final List<ProductDataModel> productDataModel;

  HomeLoadedSuccessState(this.productDataModel);
}

class HomeErrorState extends HomeState {}

// home action states
class HomeNavigationToWishListPageActionState extends HomeActionState {}

class HomeNavigationToCartPageActionState extends HomeActionState {}
