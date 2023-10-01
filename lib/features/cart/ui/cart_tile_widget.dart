import 'package:blocbasics/features/cart/bloc/cart_bloc.dart';
import 'package:blocbasics/features/home/models/product_model.dart';
import 'package:flutter/material.dart';

class CartTileCard extends StatelessWidget {
  final CartBloc cartBloc;
  final ProductModel product;
  const CartTileCard(
      {super.key, required this.product, required this.cartBloc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.black),
      margin: const EdgeInsets.all(10),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.maxFinite,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(product.imageUrl))),
            ),
            Row(children: [
              SizedBox(
                width: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      product.productDescription,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              IconButton(
                  onPressed: () {
                    // homeBloc.add(HomeProductWishlistButtonClicked(
                    //     productModel: product));
                  },
                  icon: const Icon(Icons.favorite_outline)),
              IconButton(
                  onPressed: () {
                    cartBloc.add(CartRemoveCartItemButtonClickedEvent(
                        productToRemove: product));
                  },
                  icon: const Icon(Icons.remove_shopping_cart_outlined)),
            ])
          ]),
    );
  }
}
