import 'package:ecommerce_1/views/category_screen/item_details.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_1/widgets_common/bg_widget.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:get/get.dart';
class CategoryDetails extends StatelessWidget {
  final String ? title;
  const CategoryDetails({Key? key,required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:title!.text.fontFamily(bold).make(),
        ),
        body: Container(
          padding: EdgeInsets.all(12),
          child: Column(
            children: [
              SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child:Row(
                  children: List.generate(6, (index) => "women clothing".text.fontFamily(semibold)
                      .color(darkFontGrey).size(12).makeCentered()
                      .box.white.size(120,60).rounded
                      .margin(EdgeInsets.symmetric(horizontal: 4)).make()),
                ),
              ),
              20.heightBox,
              Expanded(
                child:GridView.builder(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 6,
                  gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:2,
                    mainAxisExtent: 250,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8
                  ),
                  itemBuilder: (context,index){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(imgP5,width:200,height:150 ,fit: BoxFit.cover,),
                        "Laptop Bag 4GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                        10.heightBox,
                        "Rs.600000".text.fontFamily(bold).color(redColor).size(16).make(),
                      ],
                    ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM
                        .padding(EdgeInsets.all(12)).outerShadowSm.make().onTap(() {
                          Get.to(()=>ItemDetails(title: "DummyTitle",));
                    });
                  }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
