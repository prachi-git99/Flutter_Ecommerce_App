import 'package:ecommerce_1/views/auth_screen/login_screen.dart';
import 'package:ecommerce_1/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import "package:ecommerce_1/consts/consts.dart";
import 'package:ecommerce_1/widgets_common/applogo_widget.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  //creating a method to change screen
  changeScreen(){
    Future.delayed(Duration(seconds:3),(){
      // Get.to(()=>LoginScreen());
      auth.authStateChanges().listen((User? user) {
        print("splash screen user here $user");
        if(user==null && mounted){
          Get.to(()=>LoginScreen());
        }
        else{
          Get.to(()=> Home());
        }
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: redColor,
      body: Center(
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft, child: Image.asset(icSplashBg,width:300),),
            20.heightBox,
            applogoWidget(),
            10.heightBox,
            appname.text.fontFamily(bold).size(22).white.make(),
            5.heightBox,
            appversion.text.white.make(),
            Spacer(),
            credits.text.white.fontFamily(semibold).make(),
            30.heightBox,
          ],
        ),
      ),
    );
  }
}
