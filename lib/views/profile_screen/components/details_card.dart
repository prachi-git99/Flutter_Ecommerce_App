import 'package:ecommerce_1/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailsCard(width,String? count,String ? title){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(redColor).size(14).make(),
      5.heightBox,
      title!.text.color(redColor).size(12).make(),
    ],
  ).box.white.rounded.shadowSm.height(67)
      .width(width)
      .padding(EdgeInsets.all(4)).make();
}