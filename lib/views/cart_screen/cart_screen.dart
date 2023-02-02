import 'package:flutter/material.dart';
import 'package:ecommerce_1/consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child:"Cart is Empty".text.make(),
      ),
    );
  }
}
