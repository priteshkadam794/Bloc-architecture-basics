import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocbasics/data/cart_data.dart';
import 'package:blocbasics/data/grocery_data.dart';
import 'package:blocbasics/data/wishlist_data.dart';
import 'package:blocbasics/features/home/models/product_model.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeWishlistPageNavigateButtonClicked>(
        homeWishlistPageNavigateButtonClicked);

    on<HomeCartPageNavigateButtonClicked>(homeCartPageNavigateButtonClicked);

    on<HomeProductWishlistButtonClicked>(homeProductWishlistButtonClicked);

    on<HomeProductCartButtonClicked>(homeProductCartButtonClicked);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(Duration(seconds: 3));
    emit(HomeLoadedSuccessState(
        products: GroceryProducts.groceryItems
            .map((e) => ProductModel(
                productId: e['id'],
                productName: e['name'],
                productDescription: e['description'],
                price: e['price'],
                imageUrl: e['imageUrl']))
            .toList()));
  }

  FutureOr<void> homeWishlistPageNavigateButtonClicked(
      HomeWishlistPageNavigateButtonClicked event, Emitter<HomeState> emit) {
    print("wishlist button clicked");
    emit(HomeNaviagtToWishlistPageActionState());
  }

  FutureOr<void> homeCartPageNavigateButtonClicked(
      HomeCartPageNavigateButtonClicked event, Emitter<HomeState> emit) {
    emit(HomeNavigateToCartPageActionState());
  }

  FutureOr<void> homeProductWishlistButtonClicked(
      HomeProductWishlistButtonClicked event, Emitter<HomeState> emit) {
    print("wishlist button clicked");
    wishlistListitems.add(event.productModel);
    emit(HomeNotifyAboutItemAddedToWishList());
  }

  FutureOr<void> homeProductCartButtonClicked(
      HomeProductCartButtonClicked event, Emitter<HomeState> emit) {
    print("wishlist button clicked");
    cartListitems.add(event.productModel);
    emit(HomeNotifyAboutItemAddedToCart());
  }
}
