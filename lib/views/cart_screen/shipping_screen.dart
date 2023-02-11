import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/controller/cart_controller.dart';
import 'package:ecommerce_1/views/cart_screen/payment_method.dart';
import 'package:ecommerce_1/widgets_common/custom_textfield.dart';
import 'package:ecommerce_1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ShippingDetails extends StatelessWidget {
  const ShippingDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.find<CartController>();

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 55,
        child: ourButton(
          onPress: (){
            if((controller.addressController.text.isNotEmpty
                && controller.cityController.text.isNotEmpty
                && controller.stateController.text.isNotEmpty
                && controller.postalcodeController.text.isNotEmpty
                && (controller.phoneController.text.isNotEmpty
                    && (controller.phoneController.text.isNumericOnly))))
            {
              Get.to(()=>PaymentMethods());
            }
            else{
                VxToast.show(context, msg: "One Or More Field Incorrect");
            }

          },
          color: redColor,
          textColor: whiteColor,
          title: "Continue",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(hint:"Address",isPass: false,title: "Address",controller: controller.addressController),
            customTextField(hint: "City",isPass: false,title: "City",controller:controller.cityController ),
            customTextField(hint: "State",isPass: false,title: "State",controller: controller.stateController),
            customTextField(hint: "Postal Code",isPass: false,title: "Postal Code",controller: controller.postalcodeController),
            customTextField(hint: "Phone",isPass: false,title: "Phone",controller: controller.phoneController),
          ],
        ),
      ),
    );
  }
}
