import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/consts/lists.dart';
import 'package:ecommerce_1/controller/product_controller.dart';
import 'package:ecommerce_1/services/firestore_services.dart';
import 'package:ecommerce_1/views/chat_screen/chat_screen.dart';
import 'package:ecommerce_1/widgets_common/loadingIndicator.dart';
import 'package:ecommerce_1/widgets_common/our_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({Key? key,required this.title,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProductController());

    return WillPopScope(
      onWillPop: ()async{
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              controller.resetValues();
              Get.back();
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(onPressed:(){}, icon:Icon(Icons.share,)),
            Obx(()=> IconButton(onPressed:(){
                if(controller.isFav.value){
                  controller.removeFromWishlist(data.id,context);
                }else{
                  controller.addToWishlist(data.id,context);
                }

              }, icon:Icon(
                Icons.favorite_outlined,
                color: controller.isFav.value ?redColor:darkFontGrey,
              )),
            ),
          ],

        ),
        body: Column(
          children: [
            Expanded(child:Padding(
              padding: EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                      autoPlay: true,
                        height: 370,
                        aspectRatio: 16/9,
                        viewportFraction: 1.0,
                        itemCount:data['p_img'].length,
                        itemBuilder: (context,index){
                          return Image.network(data['p_img'][index],width:double.infinity,fit: BoxFit.fill,);
                        }
                    ),
                    10.heightBox,
                    title!.text.size(16).color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    VxRating(
                      value: double.parse(data['p_rating']),
                        onRatingUpdate: (value){},
                        normalColor: textfieldGrey,
                        selectionColor: golden,
                        isSelectable: false,
                        count:5,
                        size:20,
                        maxRating: 5,
                        stepInt: false,
                    ),
                    10.heightBox,
                    "${data['p_price']}".numCurrency.text.color(redColor).fontFamily(semibold).size(14).make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data['p_seller']}".text.white.fontFamily(semibold).size(16).make(),
                            5.heightBox,
                            "In House Brands".text.fontFamily(semibold).color(darkFontGrey).size(16).make(),
                          ],

                        )),
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(Icons.message_rounded,color:darkFontGrey,).onTap(() {

                            Get.to(()=>ChatScreen(),
                              arguments: [data['p_seller'],data['vendor_id']],
                            );
                          }),
                        ),
                      ],
                    ).box.height(60).padding(EdgeInsets.symmetric(horizontal: 16)).color(textfieldGrey).make(),
                    //color section
                    20.heightBox,
                    Obx(()=>Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Color:".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children:List.generate(data['p_colors'].length, (index) => Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    VxBox()
                                        .size(40,40)
                                        .roundedFull
                                        .shadowSm
                                        .color(Color(data['p_colors'][index]).withOpacity(1.0))
                                        .margin(EdgeInsets.symmetric(horizontal:4))
                                        .make()
                                        .onTap(() {
                                          controller.colorIndex(index);
                                        }),
                                    Visibility(
                                        visible: index == controller.colorIndex.value,
                                        child: Icon(Icons.done,color: Colors.white,)
                                    ),
                                  ],
                                )),
                              ),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                          Row(
                            children:
                            [
                              SizedBox(width: 100, child: "Quantity:".text.color(textfieldGrey).make(),),
                              Obx(()=>Row(
                                  children: [
                                    IconButton(onPressed:(){
                                      controller.decreaseQuantity();
                                      controller.calculateTotalPrice(int.parse(data['p_price']));
                                      },
                                      icon: Icon(Icons.remove),),
                                    controller.quantity.value.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                                    IconButton(onPressed:(){
                                      controller.increaseQuantity(int.parse(data['p_quantity']));
                                      controller.calculateTotalPrice(int.parse(data['p_price']));
                                      },
                                      icon: Icon(Icons.add),),
                                    8.widthBox,
                                    "(${data['p_quantity']} available)".text.color(textfieldGrey).make(),
                                  ],
                                ),
                              ) ,
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                          Row(
                            children:
                            [
                              SizedBox(width: 100, child: "Total:".text.color(textfieldGrey).make(),),
                              "${controller.totalPrice}".numCurrency.text.color((redColor)).size(16).fontFamily(bold).make(),
                            ],
                          ).box.padding(EdgeInsets.all(8)).make(),
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    //decription
                    10.heightBox,
                    "Description ".text.color(darkFontGrey).fontFamily(semibold).make(),
                    10.heightBox,
                    "${data['p_desc']}".text.color(darkFontGrey).make(),
                    10.heightBox,
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children:List.generate(itemDetailButtonList.length,(index) => ListTile(
                        title: "${itemDetailButtonList[index]}".text.fontFamily(semibold).color(darkFontGrey).make(),
                        trailing: Icon(Icons.arrow_forward),
                      ).box.white.margin(EdgeInsets.symmetric(vertical:3)).make()),
                    ),
                    //products you may like
                    20.heightBox,
                    productsyoumayalsolike.text.fontFamily(bold).size(16).color(darkFontGrey).make(),
                    10.heightBox,

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: FutureBuilder(
                        future: FirestoreServices.getFeaturedProducts(),
                        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
                          if(!snapshot.hasData){
                            return Center(child: loadingIndicator(),);
                          }else if(snapshot.data!.docs.isEmpty){
                            return Center(child:"No Featured Products".text.white.make() ,);
                          }
                          else{
                            var featuredData = snapshot.data!.docs;
                            return Row(
                              children: List.generate(featuredData.length, (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(featuredData[index]['p_img'][0],width: 130,height:160,fit: BoxFit.cover,),
                                  10.heightBox,
                                  "${featuredData[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                  10.heightBox,
                                  "Rs.${featuredData[index]['p_price']}".text.fontFamily(bold).color(redColor).size(16).make(),
                                ],
                              ).box.white
                                  .margin(EdgeInsets.symmetric(horizontal: 4))
                                  .roundedSM.padding(EdgeInsets.all(8))
                                  .make().onTap(() {
                                Get.to(()=>ItemDetails(title:"${featuredData[index]['p_name']}",data: featuredData[index],));

                              })
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],

                ),
              ),
            )),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ourButton(
                color: redColor,
                onPress: (){
                  controller.addToCart(
                    color: data['p_colors'][controller.colorIndex.value],
                    context: context,
                    img:data['p_img'][0],
                    qty: controller.quantity.value,
                    sellername: data['p_seller'],
                    title: data['p_name'],
                    vendorId: data['vendor_id'],
                    tprice: controller.totalPrice.value
                  );
                },
                textColor: whiteColor,
                title: "Add to Cart"
              ),
            ),
          ],
        )
      ),
    );
  }
}
