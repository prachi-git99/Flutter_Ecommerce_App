import 'package:ecommerce_1/consts/lists.dart';
import 'package:ecommerce_1/views/category_screen/category_details.dart';
import 'package:ecommerce_1/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        appBar: AppBar(
          title:categories.text.fontFamily(bold).white.make(),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body:Container(
          padding: EdgeInsets.all(12),
          child: GridView.builder(
              shrinkWrap: true,
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  mainAxisExtent: 200
              ),
              itemBuilder: (context,index){
                return Column(
                  children: [
                    Image.asset(categoriesImages[index],width: 200,height:120,fit: BoxFit.cover,),
                    10.heightBox,
                    "${categoriesList[index]}".text.color(darkFontGrey).align(TextAlign.center).make(),
                  ],
                ).box.white.roundedSM.clip(Clip.antiAlias).outerShadowSm.make().onTap(() { 
                  Get.to(()=>CategoryDetails(title: categoriesList[index]));
                });
              }),
        ),
      ),
    );
  }
}
