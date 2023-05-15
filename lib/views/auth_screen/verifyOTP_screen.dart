import 'dart:math';

import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/views/auth_screen/mobile_login.dart';
import 'package:ecommerce_1/views/auth_screen/userdata_screen.dart';
import 'package:ecommerce_1/views/home_screen/home.dart';
import 'package:ecommerce_1/widgets_common/applogo_widget.dart';
import 'package:ecommerce_1/widgets_common/bg_widget.dart';
import 'package:ecommerce_1/widgets_common/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../controller/auth_controller.dart';
import '../../widgets_common/custom_textfield.dart';
class VerifyOTP extends StatefulWidget {


  const VerifyOTP({Key? key,}) : super(key: key);

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {

  @override
  Widget build(BuildContext context) {

    var controller =Get.put(AuthController());

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code="";

    return bgWidget(
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: (){
                Get.offAll(()=>MobileLogin());
              },
            ),
          ),
          body: Center(
            child: Column(
              children: [
                applogoWidget(),
                10.heightBox,
                "Please enter the OTP".text.white.fontFamily(bold).size(16).make(),
                15.heightBox,
                Obx(()=>
                    Column(
                      children: [
                        Pinput(
                          length: 6,
                          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                          showCursor: true,
                          controller: controller.otpCodeController,
                        ),
                        10.heightBox,
                        controller.isloading.value? CircularProgressIndicator(
                          valueColor:AlwaysStoppedAnimation(redColor) ,
                        ):
                        ourButton(color: redColor,title:verifyOTP,textColor: whiteColor,
                            onPress:() async{
                              controller.isloading(true);
                              try{
                                PhoneAuthCredential credential = PhoneAuthProvider.credential(
                                    verificationId:MobileLogin.verify,
                                    smsCode:controller.otpCodeController.text
                                );
                                await auth.signInWithCredential(credential).then((value){
                                  return controller.storeUserData(phone:MobileLogin.mobile);
                                });
                                Get.offAll(()=>Home());
                                // Get.offAll(()=>UserData());
                              }
                              catch (e){
                                controller.isloading(false);
                                VxToast.show(context,msg:"Something went wrong");
                              }

                            }).box.width(context.screenWidth-50).make(),
                      ],
                    ).box.rounded.padding(EdgeInsets.all(16))
                        .white.width(context.screenWidth-70).shadowSm.make(),
                ),

              ],
            ),
          ),
        )
    );
  }
}
