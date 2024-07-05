import 'package:bloc_tut/feature/cart/bloc/cart_bloc.dart';
import 'package:bloc_tut/feature/home/model/product_data_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProductListview extends StatelessWidget {
  final ProductDataModel productDataModel;
  final CartBloc cartBloc;

  const CartProductListview(
      {super.key, required this.productDataModel, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withAlpha(100),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(productDataModel.productName),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("R${productDataModel.quantity}"),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        cartBloc.add(CartItemRemoveEvent(
                            productDataModel: productDataModel));
                      },
                      icon: const Icon(Icons.delete))
                ],
              )
            ],
          )
        ],
      ),
    );
  }
} //
