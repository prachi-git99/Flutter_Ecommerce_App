import 'package:flutter/material.dart';
import 'package:ecommerce_1/widgets_common/applogo_widget.dart';
import 'package:ecommerce_1/widgets_common/custom_textfield.dart';
import 'package:ecommerce_1/widgets_common/our_button.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/widgets_common/bg_widget.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck =false;

  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight*0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Join the $appname".text.white.fontFamily(bold).size(18).make(),
            15.heightBox,
            Column(
              children: [
                customTextField(hint: nameHint,title: name),
                customTextField(hint: emailHint,title: email),
                customTextField(hint:passwordHint,title: password),
                customTextField(hint:passwordHint,title: retypePassword),
                // Align(alignment:Alignment.centerRight,child: TextButton(onPressed: (){}, child:forgetPassword.text.make())),
                5.heightBox,
                Row(
                   children: [
                     Checkbox(
                       activeColor: redColor,
                       checkColor:whiteColor,
                       value:isCheck, onChanged:(newValue){
                         setState((){
                           isCheck=newValue;
                         });
                     }),
                     10.widthBox,
                     Expanded(
                       child: RichText(text:TextSpan(
                         children: [
                           TextSpan(text:"I agree to the ",style: TextStyle(
                             fontFamily: regular,
                             color: fontGrey,
                           )),
                           TextSpan(text:termsAndCond,style: TextStyle(
                             fontFamily: regular,
                             color: redColor,
                           )),
                           TextSpan(text:" & ",style: TextStyle(
                             fontFamily:regular,
                             color: fontGrey,
                           )),
                           TextSpan(text:privacyPolicy,style: TextStyle(
                             fontFamily: regular,
                             color: redColor,
                           )),
                         ]
                       )),
                     )
                   ],
                 ),
                5.heightBox,
                ourButton(color:isCheck==true? redColor:lightGrey,title:signup,textColor: isCheck==true? whiteColor:redColor,onPress: (){}).box.width(context.screenWidth-50).make(),
                10.heightBox,
                RichText(text:TextSpan(
                  children: [
                    TextSpan(text:alreadyHaveAccount,style: TextStyle(
                      fontFamily:regular,
                      color: fontGrey,
                    )),
                    TextSpan(text:login,style: TextStyle(
                      fontFamily:regular,
                      color:redColor,
                    )),
                  ]
                )).onTap(() {Get.back();}),
              ],
            ).box.rounded.padding(EdgeInsets.all(16))
                .white.width(context.screenWidth-70).shadowSm.make(),
          ],
        ),
      ),
    ));
  }
}
