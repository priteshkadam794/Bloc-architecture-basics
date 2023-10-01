part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class CartInitialEvent extends CartEvent {}

class CartRemoveCartItemButtonClickedEvent extends CartEvent {
  final ProductModel productToRemove;

  CartRemoveCartItemButtonClickedEvent({required this.productToRemove});
}
