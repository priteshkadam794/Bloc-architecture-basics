import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:blocbasics/data/cart_data.dart';
import 'package:blocbasics/features/home/models/product_model.dart';
import 'package:meta/meta.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<CartRemoveCartItemButtonClickedEvent>(
        cartRemoveCartItemButtonClickedEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartLoadingSuccessState(cartListitems: cartListitems));
  }

  FutureOr<void> cartRemoveCartItemButtonClickedEvent(
      CartRemoveCartItemButtonClickedEvent event, Emitter<CartState> emit) {
    if (cartListitems.contains(event.productToRemove)) {
      cartListitems.remove(event.productToRemove);
    }
    emit(CartLoadingSuccessState(cartListitems: cartListitems));
    emit(CartNotifyAboutItemRemoved());
  }
}
