import 'package:ecommerce_1/controller/auth_controller.dart';
import 'package:ecommerce_1/views/auth_screen/verify_email.dart';
import 'package:ecommerce_1/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  var controller = Get.put(AuthController());
  //text controllers
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var retypePasswordController=TextEditingController();

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
            Obx(()=>
                Column(
                children: [
                  customTextField(hint: nameHint,title: name,controller: nameController,isPass: false),
                  customTextField(hint: emailHint,title: email,controller: emailController,isPass: false),
                  customTextField(hint:passwordHint,title: password,controller: passwordController,isPass: true),
                  customTextField(hint:passwordHint,title: retypePassword,controller: retypePasswordController,isPass: true),
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
                  controller.isloading.value ? CircularProgressIndicator(
                    valueColor:AlwaysStoppedAnimation(redColor) ,
                  ):ourButton(color:isCheck==true? redColor:lightGrey,title:signup,textColor: isCheck==true? whiteColor:redColor,onPress: ()async{
                    if(isCheck != false)
                      {
                        controller.isloading(true);
                        try{
                          if(passwordController.text == retypePasswordController.text ){
                            await controller.signupMethod(context: context,email: emailController.text,password:passwordController.text).then((value){
                              if(!(FirebaseAuth.instance.currentUser!.emailVerified)){
                                Get.offAll(()=>VerifyEmail());
                                return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name:nameController.text,
                                );
                              }
                            }).then((value){
                              VxToast.show(context,msg:loggedin);
                            });
                          }
                          else{
                            VxToast.show(context, msg:"Password does not matched");
                            controller.isloading(false);
                          }
                        }catch(e){
                          auth.signOut();
                          VxToast.show(context, msg:"Please fill the correct values");
                          controller.isloading(false);
                        }
                      }
                  }).box.width(context.screenWidth-50).make(),
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
            ),
          ],
        ),
      ),
    ));
  }
}
