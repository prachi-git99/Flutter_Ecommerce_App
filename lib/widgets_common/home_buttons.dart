import 'package:ecommerce_1/consts/consts.dart';
import 'package:flutter/cupertino.dart';

Widget homeButtons({width,height,icon,String? title,onpress}){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(icon,width: 26,),
        10.heightBox,
        title!.text.fontFamily(semibold).color(darkFontGrey).make()
      ],
  ).box.rounded.white.size(width, height).shadowSm.make();
}