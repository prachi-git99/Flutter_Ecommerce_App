import 'package:ecommerce_1/consts/lists.dart';
import 'package:ecommerce_1/views/home_screen/components/featured_button.dart';
import 'package:ecommerce_1/widgets_common/home_buttons.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_1/consts/consts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      padding: EdgeInsets.all(12),
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height:60,
              color: lightGrey,
              child: TextFormField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: whiteColor,
                  hintText:searchanything,
                  hintStyle: TextStyle(
                    color: textfieldGrey,
                  ),
                ),
              ),
            ),
            10.heightBox,
           Expanded(
             child: SingleChildScrollView(
               physics:BouncingScrollPhysics(),
               child: Column(
                 children: [
                   VxSwiper.builder(
                       aspectRatio: 16/9,
                       autoPlay: true,
                       height: 150,
                       enlargeCenterPage:true,
                       itemCount:slidersList.length, itemBuilder: (context,index){
                     return Image.asset(slidersList[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                   }),
                   10.heightBox,
                   Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: List.generate(2, (index) => homeButtons(
                         height:context.screenHeight*0.15,
                         width:context.screenWidth/2.5,
                         icon: index == 0 ? icTodaysDeal : icFlashDeal,
                         title: index == 0 ? todaydeal : flashsale,
                         onpress: (){},

                       ))
                   ),
                   10.heightBox,
                   VxSwiper.builder(
                       aspectRatio: 16/9,
                       autoPlay: true,
                       height: 150,
                       enlargeCenterPage:true,
                       itemCount:slidersList.length, itemBuilder: (context,index){
                     return Image.asset(secondslidersList[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                   }),
                   10.heightBox,
                   Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                       children: List.generate(3, (index) => homeButtons(
                         height:context.screenHeight*0.15,
                         width:context.screenWidth/3.5,
                         icon: index == 0 ? icTopCategories: index==1 ? icBrands:icTopSeller,
                         title: index == 0 ? topCategories: index==1 ? brand:topSellers,
                         onpress: (){},
                       ))
                   ),
                   20.heightBox,
                   Align(
                     alignment: Alignment.centerLeft,
                     child: featuredCategories.text.color(darkFontGrey).size(18).fontFamily(semibold).make(),
                   ),
                   20.heightBox,
                   SingleChildScrollView(
                     scrollDirection: Axis.horizontal,
                     child: Row(
                       children: List.generate(3, (index) => Column(
                         children: [
                           featuredButton(icon:featuredListImages1[index],title: featuredListTitles1[index]),
                           10.heightBox,
                           featuredButton(icon:featuredListImages2[index],title: featuredListTitles2[index]),                         ],
                       )).toList(),
                     ),
                   ),
                   20.heightBox,
                   Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: redColor,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white.fontFamily(bold).size(18).make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(6, (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(imgP1,width: 150,fit: BoxFit.cover,),
                                  10.heightBox,
                                  "Laptop 4GB/265GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                                  10.heightBox,
                                  "Rs.600000".text.fontFamily(bold).color(redColor).size(16).make(),
                                ],
                              ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM.padding(EdgeInsets.all(8)).make()),
                            ),
                          ),
                        ],
                      ),
                    ),
                   10.heightBox,
                   VxSwiper.builder(
                       aspectRatio: 16/9,
                       autoPlay: true,
                       height: 150,
                       enlargeCenterPage:true,
                       itemCount:slidersList.length, itemBuilder: (context,index){
                     return Image.asset(thirdSlidersList[index],fit: BoxFit.fill,).box.rounded.clip(Clip.antiAlias).margin(EdgeInsets.symmetric(horizontal: 8)).make();
                   }),
                   20.heightBox,
                   Align(
                     alignment: Alignment.centerLeft,
                     child: allProducts.text.color(darkFontGrey).size(18).fontFamily(semibold).make(),
                   ),
                   10.heightBox,
                   GridView.builder(
                     physics: NeverScrollableScrollPhysics(),
                     shrinkWrap:true,
                     itemCount: 6,
                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                         crossAxisCount: 2,
                         mainAxisSpacing: 8,
                         crossAxisSpacing: 8,
                         mainAxisExtent: 300
                     ),
                     itemBuilder: (context,index){
                     return Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Image.asset(imgP5,width:200,height: 200 ,fit: BoxFit.cover,),
                         Spacer(),
                         "Laptop Bag 4GB".text.fontFamily(semibold).color(darkFontGrey).make(),
                         10.heightBox,
                         "Rs.600000".text.fontFamily(bold).color(redColor).size(16).make(),
                       ],
                     ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM
                         .padding(EdgeInsets.all(12)).make();
                   }),


                 ],
               ),
             ),
           ),
          ],
        ),
      ),
    );
  }
}
