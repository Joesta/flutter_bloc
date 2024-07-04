import 'package:bloc_tut/feature/cart/ui/cart_page.dart';
import 'package:bloc_tut/feature/home/bloc/home_bloc.dart';
import 'package:bloc_tut/feature/wishlist/ui/wish_list_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  // first, make sure to add the initial event to subsequently handle other states. This will be handled by the framework state management.f
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
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
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartPage(),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (HomeLoadingState):
            return const Center(
              child: CircularProgressIndicator(),
            );
          case const (HomeLoadedSuccessState):
            return initUI();
          case const (HomeErrorState):
            return const Scaffold(
              body: Center(
                child: Text('Error loading ui'),
              ),
            );
          default:
            return const SizedBox();
        }
      },
    );
  }

  Widget initUI() {
    debugPrint('initUI loading');
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Bloc Tut'),
          actions: [
            IconButton(
              onPressed: () {
                homeBloc.add(HomeWishListButtonNavigateEvent());
              },
              icon: const Icon(Icons.favorite_border_outlined),
            ),
            IconButton(
              onPressed: () {
                homeBloc.add(HomeCartButtonNavigateEvent());
              },
              icon: const Icon(Icons.shopping_cart_outlined),
            ),
          ],
        ),
      ),
    );
  }
}
