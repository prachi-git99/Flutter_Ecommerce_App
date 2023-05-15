import 'dart:io';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/controller/profile_controller.dart';
import 'package:ecommerce_1/views/profile_screen/profile_screen.dart';
import 'package:ecommerce_1/widgets_common/bg_widget.dart';
import 'package:ecommerce_1/widgets_common/custom_textfield.dart';
import 'package:ecommerce_1/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {

  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    var controller = Get.find<ProfileController>();
    var data = ProfileScreen.userdata;

    return bgWidget(
        Scaffold(
          appBar: AppBar(),
          body: Obx(()=>
              SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    data['imageUrl'] == '' && controller.profileImagePath.isEmpty ?
                    Image.asset(imgProfile2,width:100,fit: BoxFit.cover,)
                        .box.roundedFull.shadowSm.clip(Clip.antiAlias).make()
                        :data['imageUrl']!='' && controller.profileImagePath.isEmpty ?
                        Image.network(data['imageUrl'],width:100,fit: BoxFit.cover,)
                        .box.roundedFull.shadowSm.clip(Clip.antiAlias).make()
                        :Image.file(
                            File(controller.profileImagePath.value),
                            width:100 ,
                            fit: BoxFit.cover,
                          ).box.roundedFull.shadowSm.clip(Clip.antiAlias).make(),
                    10.heightBox,
                    ourButton(color:redColor,onPress: (){
                      controller.changeImage(context);
                    },textColor: whiteColor,title: "Change"),
                    Divider(),
                    20.heightBox,
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
                      title: email,
                      isPass: false,
                    ),
                    10.heightBox,
                    customTextField(
                      controller: controller.oldpasswordController,
                      hint:passwordHint,
                      title:oldpass,
                      isPass:true,
                    ),
                    10.heightBox,
                    customTextField(
                      controller: controller.newpasswordController,
                      hint:passwordHint,
                      title:newpass,
                      isPass:true,
                    ),
                    20.heightBox,
                    controller.isloading.value?CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(redColor),
                    ):
                    SizedBox(width:context.screenWidth-60,child: ourButton(color:redColor,
                        onPress: ()async{

                          controller.isloading(true);
                          //if image is not chnged
                          if(controller.profileImagePath.value.isNotEmpty){
                            await controller.uploadProfileImage();
                          }else{
                            controller.profileImageLink=data['imageUrl'];
                          }
                          //old==new
                          if(data['password'] == controller.oldpasswordController.text){
                            await controller.changeAuthPassword(
                                email:data['email'],
                                password:controller.oldpasswordController.text,
                                newPassword: controller.newpasswordController.text,
                            );

                            await controller.updateProfile(
                              imgUrl: controller.profileImageLink,
                              email: controller.emailController.text,
                              name: controller.nameController.text,
                              password: controller.newpasswordController.text,
                            );
                            //controller.isloading(false);
                            VxToast.show(context, msg:"Updated");
                          }else{
                            VxToast.show(context, msg:"Old Password Incorrect");
                            controller.isloading(false);
                          }
                        },textColor: whiteColor,title: "Save")),

                  ],
                ).box.shadowSm.white
                  .padding(EdgeInsets.all(16))
                  .rounded
                  .margin(EdgeInsets.only(top: 15,left: 12,right: 12))
                  .make(),
              ),
          ),
          ),
    );
  }
}
