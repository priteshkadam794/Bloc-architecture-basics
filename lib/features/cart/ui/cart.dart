import 'package:blocbasics/features/cart/bloc/cart_bloc.dart';
import 'package:blocbasics/features/cart/ui/cart_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cart extends StatefulWidget {
  const Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    cartBloc.add(CartInitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Your Cart"),
      ),
      body: BlocConsumer<CartBloc, CartState>(
        bloc: cartBloc,
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        listener: (context, state) {
          if (state is CartNotifyAboutItemRemoved) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Item removed from cart"),
              duration: Duration(milliseconds: 300),
            ));
            ScaffoldMessengerState().removeCurrentSnackBar();
          }
        },
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartLoadingSuccessState:
              final successState = state as CartLoadingSuccessState;
              return ListView.builder(
                  itemCount: successState.cartListitems.length,
                  itemBuilder: (context, index) {
                    return CartTileCard(
                        product: successState.cartListitems[index],
                        cartBloc: cartBloc);
                  });

            default:
              return const SizedBox();
          }
        },
      ),
    );
  }
}
