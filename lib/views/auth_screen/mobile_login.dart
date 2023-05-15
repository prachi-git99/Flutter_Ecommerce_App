import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/controller/auth_controller.dart';
import 'package:ecommerce_1/views/auth_screen/login_screen.dart';
import 'package:ecommerce_1/views/auth_screen/signup_screen.dart';
import 'package:ecommerce_1/views/auth_screen/verifyOTP_screen.dart';
import 'package:ecommerce_1/views/home_screen/home.dart';
import 'package:ecommerce_1/widgets_common/applogo_widget.dart';
import 'package:ecommerce_1/widgets_common/bg_widget.dart';
import 'package:ecommerce_1/widgets_common/our_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../consts/lists.dart';
import '../../widgets_common/custom_textfield.dart';

class MobileLogin extends StatefulWidget {
  const MobileLogin({Key? key}) : super(key: key);

  static String verify="";
  static String mobile="";

  @override
  State<MobileLogin> createState() => _MobileLoginState();
}

class _MobileLoginState extends State<MobileLogin> {

  TextEditingController countrycode = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    countrycode.text="+91";
    super.initState();

  }


  @override
  Widget build(BuildContext context) {

    var controller =Get.put(AuthController());

    return bgWidget(
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight*0.15).heightBox,
              applogoWidget(),
              10.heightBox,
              "Log in with OTP".text.white.fontFamily(bold).size(18).make(),
              15.heightBox,
              Obx(()=>
                  Column(
                    children: [
                      customTextField(hint: mobileHint,title:phone,isPass: false,controller:controller.phoneNumberController,Keytype:TextInputType.phone),
                      15.heightBox,
                      controller.isloading.value? CircularProgressIndicator(
                        valueColor:AlwaysStoppedAnimation(redColor) ,
                      ):ourButton(color: redColor,title:"Request OTP",textColor: whiteColor,
                          onPress:() async{

                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber: '${countrycode.text+controller.phoneNumberController.text}',
                              timeout: Duration(seconds: 60),
                              verificationCompleted: (PhoneAuthCredential credential) {},
                              verificationFailed: (FirebaseAuthException e) {},
                              codeSent: (String verificationId, int? resendToken) {
                                MobileLogin.verify = verificationId;
                                MobileLogin.mobile='${countrycode.text+controller.phoneNumberController.text}';
                                Get.offAll(()=>VerifyOTP());
                              },
                              codeAutoRetrievalTimeout: (String verificationId) {},
                            );

                          }).box.width(context.screenWidth-50).make(),
                      5.heightBox,
                      createNewAccount.text.color(fontGrey).make(),
                      5.heightBox,
                      ourButton(color: lightGolden,title: signup,textColor:redColor,onPress: (){Get.to(()=>SignupScreen());}).box.width(context.screenWidth-50).make(),
                      5.heightBox,
                      loginwith.text.color(fontGrey).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:List.generate(socialIconList.length, (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: lightGrey,
                            child: Image.asset(socialIconList2[index],width: 50,),
                          ).onTap(() {
                            Get.offAll(()=>LoginScreen());
                          }),
                        )),
                      )
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


