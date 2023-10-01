part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class HomeProductWishlistButtonClicked extends HomeEvent {
  final ProductModel productModel;
  HomeProductWishlistButtonClicked({required this.productModel});
}

class HomeProductCartButtonClicked extends HomeEvent {
  final ProductModel productModel;

  HomeProductCartButtonClicked({required this.productModel});
}

class HomeWishlistPageNavigateButtonClicked extends HomeEvent {}

class HomeCartPageNavigateButtonClicked extends HomeEvent {}
