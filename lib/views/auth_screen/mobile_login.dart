import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/controller/auth_controller.dart';
import 'package:ecommerce_1/views/auth_screen/login_screen.dart';
import 'package:ecommerce_1/views/auth_screen/signup_screen.dart';
import 'package:ecommerce_1/views/home_screen/home.dart';
import 'package:ecommerce_1/widgets_common/applogo_widget.dart';
import 'package:ecommerce_1/widgets_common/bg_widget.dart';
import 'package:ecommerce_1/widgets_common/our_button.dart';
import 'package:get/get.dart';

import '../../consts/lists.dart';
import '../../widgets_common/custom_textfield.dart';

class MobileLogin extends StatelessWidget {
  const MobileLogin({Key? key}) : super(key: key);

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
                      customTextField(hint: mobileHint,title:phone,isPass: false,controller:controller.phoneNumberController,),
                      controller.isloading.value? CircularProgressIndicator(
                        valueColor:AlwaysStoppedAnimation(redColor) ,
                      ):
                      ourButton(color: redColor,title:sendOtp,textColor: whiteColor,
                          onPress:() async{
                            controller.isloading(true);
                            await controller.loginMethod(context:context).then((value){
                              if(value !=null){
                                VxToast.show(context, msg: loggedin);
                                Get.offAll(()=>Home());
                              }else{
                                controller.isloading(false);
                              }
                            });
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
