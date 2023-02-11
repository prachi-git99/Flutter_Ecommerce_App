import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/controller/cart_controller.dart';
import 'package:ecommerce_1/services/firestore_services.dart';
import 'package:ecommerce_1/views/cart_screen/shipping_screen.dart';
import 'package:ecommerce_1/widgets_common/loadingIndicator.dart';
import 'package:ecommerce_1/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce_1/consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller =Get.put(CartController());

    return Scaffold(
      bottomNavigationBar:SizedBox(
        height: 55,
        child: ourButton(
            color: redColor,
            onPress: (){
              Get.to(()=>ShippingDetails());
            },
            title: "Proceed to shipping",
            textColor: whiteColor
        ),
      ),
      backgroundColor: whiteColor,
      appBar:AppBar(
        automaticallyImplyLeading: false,
        title: "Shopping Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
      ) ,
      body: StreamBuilder(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }
          else if(snapshot.data!.docs.isEmpty){
            return Center(
              child: "Cart is Empty".text.color(darkFontGrey).make(),
            );
          }
          else{
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;


            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context,int index){
                              return ListTile(
                                leading: Image.network("${data[index]['img']}",),
                                title: "${data[index]['title']} (${data[index]['qty']})".text.size(16).fontFamily(semibold).make(),
                                subtitle:"${data[index]['tprice']}".numCurrency.text.color(redColor).size(14).fontFamily(semibold).make(),
                                trailing: Icon(Icons.delete,color: redColor,).onTap(() {
                                  FirestoreServices.deleteDocument(data[index].id);
                                }),
                              );
                            },

                        ),
                      ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Total Price".text.color(darkFontGrey).fontFamily(semibold).make(),
                      Obx(()=> "${controller.totalP.value}".numCurrency.text.color(redColor).fontFamily(semibold).make()),
                    ],
                  ).box.padding(EdgeInsets.all(12)).color(lightGolden).width(context.screenWidth-60).roundedSM.make(),
                  10.heightBox,
                  // SizedBox(
                  //   width: context.screenWidth-60,
                  //   child: ourButton(
                  //       color: redColor,
                  //       onPress: (){},
                  //       title: "Proceed to shipping",
                  //       textColor: whiteColor
                  //   ),
                  // ),
                ],
              ),
            );
          }
        }
      ),
    );
  }
}
