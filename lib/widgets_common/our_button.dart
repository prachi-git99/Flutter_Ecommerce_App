import 'package:ecommerce_1/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ourButton({onPress,color,textColor,String? title}){
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      primary: color,
      padding: EdgeInsets.all(12)
    ),
      onPressed:onPress,
      child:title!.text.color(textColor).fontFamily(bold).make(),
  );
}