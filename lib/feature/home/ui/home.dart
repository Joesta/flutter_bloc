import 'package:bloc_tut/feature/cart/ui/cart_page.dart';
import 'package:bloc_tut/feature/home/bloc/home_bloc.dart';
import 'package:bloc_tut/feature/home/ui/product_tile_widget.dart';
import 'package:bloc_tut/feature/wishlist/ui/wish_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc _homeBloc = HomeBloc();

  // first, make sure to add the initial event to subsequently handle other states. This will be handled by the framework state management.f
  @override
  void initState() {
    _homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigationToWishListPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WishListPage(),
            ),
          );
        } else if (state is HomeNavigationToCartPageActionState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartPage(),
            ),
          );
        } else if (state is HomeProductWishListItemAddedActionState) {
          _showSnackBar(context, "Items is added to wishlist");
        } else if (state is HomeProductCartItemAddedActionState) {
          _showSnackBar(context, "Items is added to cart");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeLoadingState):
            return _showLoadingIndicator();
          case const (HomeLoadedSuccessState):
            final successSate = state as HomeLoadedSuccessState;
            return _initUI(successSate);
          case const (HomeErrorState):
            return _showHomeErrorState();
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget _showHomeErrorState() {
    return const Scaffold(
      body: Center(
        child: Text('Error loading ui'),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  Widget _showLoadingIndicator() {
    return const Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }

  Widget _initUI(HomeLoadedSuccessState successSate) {
    debugPrint('initUI loading');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bloc Tut'),
          actions: [
            IconButton(
              onPressed: () {
                _homeBloc.add(HomeWishListButtonNavigateEvent());
              },
              icon: const Icon(Icons.favorite_border_outlined),
            ),
            IconButton(
              onPressed: () {
                _homeBloc.add(HomeCartButtonNavigateEvent());
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: successSate.productDataModel.length,
          itemBuilder: (context, index) {
            return ProductTileWidget(
                homeBloc: _homeBloc,
                productDataModel: successSate.productDataModel[index]);
          },
        ),
      ),
    );
  }
}
