import 'package:ecommerce_1/consts/consts.dart';
import 'package:flutter/material.dart';

Widget detailsCard(width,String? count,String ? title){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).color(darkFontGrey).size(14).make(),
      5.heightBox,
      title!.text.color(darkFontGrey).size(12).make(),
    ],
  ).box.white.rounded.shadowSm.height(65)
      .width(width)
      .padding(EdgeInsets.all(4)).make();
}