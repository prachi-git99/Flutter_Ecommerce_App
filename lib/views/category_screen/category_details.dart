import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/controller/product_controller.dart';
import 'package:ecommerce_1/services/firestore_services.dart';
import 'package:ecommerce_1/views/category_screen/item_details.dart';
import 'package:ecommerce_1/widgets_common/loadingIndicator.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_1/widgets_common/bg_widget.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:get/get.dart';
class CategoryDetails extends StatefulWidget {
  final String ? title;
  const CategoryDetails({Key? key,required this.title}) : super(key: key);

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {

  @override
  void initState() {
    // TODO: implement initState
    
    super.initState();
    switchCategory(widget.title);
  }
  
  switchCategory(title){
    if(controller.subcat.contains(title)){
      productMethod = FirestoreServices.getSubCategories(title);
    }else{
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.put(ProductController());

  dynamic productMethod;

  @override
  Widget build(BuildContext context) {

    return bgWidget(
      Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title:widget.title!.text.fontFamily(bold).make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              child:Row(
                children: List.generate((controller.subcat.length), (index) =>
                        "${controller.subcat[index]}"
                        .text
                        .fontFamily(semibold)
                        .color(darkFontGrey)
                        .size(12)
                        .makeCentered()
                        .box.white.size(120,60).rounded
                        .margin(EdgeInsets.symmetric(horizontal: 4))
                        .make().onTap(() {
                          switchCategory("${controller.subcat[index]}");
                          setState(() {


                          });

                    })
                ),
              ),
            ),
            20.heightBox,
            StreamBuilder(
              stream:productMethod,
              builder: (BuildContext context ,AsyncSnapshot<QuerySnapshot> snapshot){
                if(!snapshot.hasData){
                  return Expanded(
                    child: Center(
                      child: loadingIndicator(),
                    ),
                  );
                }
                else if(snapshot.data!.docs.isEmpty){
                  return Expanded(
                    child: "No Products Found".text.color(darkFontGrey).makeCentered(),
                  );
                }
                else{
                  var data=snapshot.data!.docs ;

                  return Expanded(
                        child:GridView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: data.length,
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
                                  Image.network(data[index]['p_img'][0],width:200,height:150 ,fit: BoxFit.cover,),
                                  10.heightBox,
                                  "${data[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                                  10.heightBox,
                                  "Rs.${data[index]['p_price']}".text.fontFamily(regular).color(redColor).size(14).make(),
                                ],
                              ).box.white.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM
                                  .padding(EdgeInsets.all(12)).outerShadowSm.make().onTap(() {
                                    controller.checkIffav(data[index]);
                                Get.to(()=>ItemDetails(title: "${data[index]['p_name']}",data:data[index]));
                                print("index going :$index,name:${data[index]['p_name']}");

                              });
                            }),
                      );
                }
              },
            ),
          ],
        )
      ),
    );
  }
}
