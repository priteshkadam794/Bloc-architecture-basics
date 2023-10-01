import 'package:blocbasics/features/cart/ui/cart.dart';
import 'package:blocbasics/features/home/bloc/home_bloc.dart';
import 'package:blocbasics/features/home/ui/product_card_widget.dart';
import 'package:blocbasics/features/wishlist/ui/wishlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNaviagtToWishlistPageActionState) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Wishlist()));
        } else if (state is HomeNavigateToCartPageActionState) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => const Cart()));
        } else if (state is HomeNotifyAboutItemAddedToCart) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Item added to cart")),
          );
          ScaffoldMessengerState().removeCurrentSnackBar();
        } else if (state is HomeNotifyAboutItemAddedToWishList) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Item added to wishlist")),
          );
          ScaffoldMessengerState().removeCurrentSnackBar();
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );

          case HomeLoadedSuccessState:
            final successState = state as HomeLoadedSuccessState;
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.teal,
                centerTitle: true,
                title: const Text("Grocery App"),
                actions: [
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeWishlistPageNavigateButtonClicked());
                      },
                      icon: const Icon(Icons.favorite_outline)),
                  IconButton(
                      onPressed: () {
                        homeBloc.add(HomeCartPageNavigateButtonClicked());
                      },
                      icon: const Icon(Icons.shopping_cart_outlined)),
                ],
              ),
              body: ListView.builder(
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return ProductCard(
                        homeBloc: homeBloc,
                        product: successState.products[index]);
                  }),
            );

          case HomeErrorState:
            return const Center(
              child: Text("some error occured"),
            );

          default:
            return const SizedBox();
        }
      },
    );
  }
}
