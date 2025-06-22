import 'package:flutter/material.dart';

class CartIconButton extends StatelessWidget {
  const CartIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.shopping_cart),
      onPressed: () {
        Navigator.of(context).pushNamed("/cart");
      },
    );
  }
}
