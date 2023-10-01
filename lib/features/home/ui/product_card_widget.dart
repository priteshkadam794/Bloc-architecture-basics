import 'package:blocbasics/features/home/bloc/home_bloc.dart';
import 'package:blocbasics/features/home/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final HomeBloc homeBloc;
  final ProductModel product;
  const ProductCard({super.key, required this.product, required this.homeBloc});

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
                    homeBloc.add(HomeProductWishlistButtonClicked(
                        productModel: product));
                  },
                  icon: const Icon(Icons.favorite_outline)),
              IconButton(
                  onPressed: () {
                    homeBloc.add(
                        HomeProductCartButtonClicked(productModel: product));
                  },
                  icon: const Icon(Icons.shopping_cart_outlined)),
            ])
          ]),
    );
  }
}
