import 'package:ecommerce_1/consts/consts.dart';
import 'package:flutter/material.dart';

Widget featuredButton({String? title,icon}){
  return Container(
    child: Row(
      children: [
        Image.asset(icon,width: 60,fit: BoxFit.fill),
        10.widthBox,
        title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      ],
    ),
  ).box.width(200).margin(EdgeInsets.symmetric(horizontal: 4)).color(whiteColor).padding(EdgeInsets.all(4)).roundedSM.outerShadowSm.make();
}