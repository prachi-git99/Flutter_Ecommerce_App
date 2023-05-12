import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/controller/product_controller.dart';
import 'package:ecommerce_1/views/category_screen/category_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


Widget featuredButton({String? title,icon}){
  var controller = Get.put(ProductController());
  return Container(
    child: Row(
      children: [
        Image.asset(icon,width: 60,height:60,fit: BoxFit.fill),
        10.widthBox,
        title!.text.fontFamily(semibold).color(darkFontGrey).make(),
      ],
    ),
  ).box.width(200)
    .margin(EdgeInsets.symmetric(horizontal: 4))
      .color(whiteColor).padding(EdgeInsets.all(4))
      .roundedSM.outerShadowSm.make().onTap(() {
    controller.getSubCategories(title);
    Get.to(()=>CategoryDetails(title: title));
  });
}