import 'package:bloc_tut/feature/cart/bloc/cart_bloc.dart';
import 'package:bloc_tut/feature/cart/ui/cart_page.dart';
import 'package:bloc_tut/feature/cart/widgets/cart_product_listview.dart';
import 'package:bloc_tut/feature/home/bloc/home_bloc.dart';
import 'package:bloc_tut/feature/home/ui/product_tile_widget.dart';
import 'package:bloc_tut/feature/wishlist/ui/wish_list_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc _cartBloc = CartBloc();

  // first, make sure to add the initial event to subsequently handle other states. This will be handled by the framework state management.f
  @override
  void initState() {
    _cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartBloc, CartState>(
      bloc: _cartBloc,
      listenWhen: (previous, current) => current is CartActionState,
      buildWhen: (previous, current) => current is! CartActionState,
      listener: (context, state) {

      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (CartLoadedSuccessState):
            final successState = state as CartLoadedSuccessState;
            return _initUI(successState);
          default:
            return const SizedBox();
        }
      },
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

  Widget _initUI(CartLoadedSuccessState successSate) {
    debugPrint('initUI {} cart');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart Items'),
          actions: [
            IconButton(
              onPressed: () {
                // _cartBloc.add(HomeWishListButtonNavigateEvent());
              },
              icon: const Icon(Icons.favorite_border_outlined),
            ),
            IconButton(
              onPressed: () {
                // _homeBloc.add(HomeCartButtonNavigateEvent());
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: successSate.cartItems.length,
          itemBuilder: (context, index) {
            return CartProductListview(productDataModel: successSate.cartItems[index], cartBloc: _cartBloc);
          },
        ),
      ),
    );
  }
}
