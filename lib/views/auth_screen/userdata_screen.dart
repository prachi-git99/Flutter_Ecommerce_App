import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/controller/auth_controller.dart';
import 'package:ecommerce_1/controller/profile_controller.dart';
import 'package:ecommerce_1/views/home_screen/home.dart';
import 'package:ecommerce_1/widgets_common/custom_textfield.dart';
import 'package:ecommerce_1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class UserData extends StatelessWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AuthController());

    return Scaffold(
      body:Container(
        child: Center(
          child: Column(
            children:[
              customTextField(
                controller: controller.nameController,
                hint:nameHint,
                title: name,
                isPass: false,
              ),
              10.heightBox,
              customTextField(
                controller: controller.emailController,
                hint:emailHint,
                title:email,
                isPass: false,
              ),
              10.heightBox,
              customTextField(
                controller: controller.passwordController,
                hint:passwordHint,
                title:password,
                isPass: false,
              ),
              20.heightBox,
              controller.isloading.value?CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(redColor),
              ):
              SizedBox(width:context.screenWidth-60,child: ourButton(color:redColor,
                  onPress: ()async{
                      controller.isloading(true);
                      await controller.storeUserData(
                        name: controller.nameController.text,
                        email:controller.emailController.text,
                        password: controller.passwordController.text
                      );
                      Get.offAll(()=>Home());
                      VxToast.show(context, msg:"Updated");
                    },
                  textColor: whiteColor,title: "Save")),
            ],
          ),
        ),
      ),
    );
  }
}
