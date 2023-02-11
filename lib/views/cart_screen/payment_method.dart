import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/consts/lists.dart';
import 'package:ecommerce_1/controller/cart_controller.dart';
import 'package:ecommerce_1/views/cart_screen/order_placed.dart';
import 'package:ecommerce_1/views/home_screen/home_screen.dart';
import 'package:ecommerce_1/widgets_common/loadingIndicator.dart';
import 'package:get/get.dart';

import '../../widgets_common/our_button.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller =Get.find<CartController>();

    return Obx(() => Scaffold(
        backgroundColor: whiteColor,
        bottomNavigationBar: SizedBox(
          height: 55,
          child:controller.placingOrder.value ?
          Center(child: loadingIndicator(),)
              : ourButton(
            onPress: () async {
              controller.placeMyOrder(
                  orderPaymentMethod:paymentMethods[controller.paymentIndex.value],
                  totalAmount: controller.totalP.value
              );
              await controller.clearCart();
              Get.to(()=>OrderPlaceScreen());
            },
            color: redColor,
            textColor: whiteColor,
            title: "Place Order",
          ),
        ),
        appBar: AppBar(
          title: "Payments".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(()=> Column(
              children: List.generate(paymentMethodImg.length, (index) {
                return Row(
                  children: [
                    Expanded(child: paymentMethods[index].text.color(darkFontGrey).size(14).fontFamily(semibold).make()),
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          controller.changePaymentIndex(index);
                        },
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          margin: EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: controller.paymentIndex.value==index ? redColor : Colors.transparent,
                              width: 5
                            ),
                          ),
                          child: Stack(
                            alignment: Alignment.topRight,
                            children: [
                                Image.asset(paymentMethodImg[index]
                                  ,width: context.screenWidth/1.5,
                                  height:100,
                                  colorBlendMode:controller.paymentIndex.value==index ? BlendMode.darken : BlendMode.color,
                                  color:controller.paymentIndex.value==index ? Colors.black.withOpacity(0.2):Colors.transparent,
                                  fit: BoxFit.cover,
                                ),
                              controller.paymentIndex.value==index ? Transform.scale(
                                scale: 1.5,
                                child: Checkbox(
                                  activeColor: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    value:true,
                                    onChanged: (value){

                                    }
                                ),
                              ):Container(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
