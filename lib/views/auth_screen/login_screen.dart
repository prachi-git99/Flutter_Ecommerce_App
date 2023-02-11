import 'package:ecommerce_1/consts/lists.dart';
import 'package:ecommerce_1/controller/auth_controller.dart';
import 'package:ecommerce_1/views/home_screen/home.dart';
import 'package:ecommerce_1/views/auth_screen/signup_screen.dart';
import 'package:ecommerce_1/widgets_common/applogo_widget.dart';
import 'package:ecommerce_1/widgets_common/custom_textfield.dart';
import 'package:ecommerce_1/widgets_common/our_button.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller =Get.put(AuthController());
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight*0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Log in to $appname".text.white.fontFamily(bold).size(18).make(),
            15.heightBox,
            Obx(()=>
                Column(
                children: [
                  customTextField(hint: emailHint,title: email,isPass: false,controller:controller.emailController,),
                  customTextField(hint:passwordHint,title: password,isPass: true,controller: controller.passwordController),
                  Align(alignment:Alignment.centerRight,child: TextButton(onPressed: (){}, child:forgetPassword.text.make())),
                  5.heightBox,
                  controller.isloading.value? CircularProgressIndicator(
                    valueColor:AlwaysStoppedAnimation(redColor) ,
                  ):
                  ourButton(color: redColor,title:login,textColor: whiteColor,
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
                    children:List.generate(3, (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        radius: 25,
                        backgroundColor: lightGrey,
                        child: Image.asset(socialIconList[index],width: 30,),
                      ),
                    )),
                  )
                ],
              ).box.rounded.padding(EdgeInsets.all(16))
                  .white.width(context.screenWidth-70).shadowSm.make(),
            ),

          ],
        ),
      ),
    ));
  }
}
