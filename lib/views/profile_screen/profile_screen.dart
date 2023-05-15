import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/services/firestore_services.dart';
import 'package:ecommerce_1/views/chat_screen/messaging_screen.dart';
import 'package:ecommerce_1/views/orders_screen/orders_screen.dart';
import 'package:ecommerce_1/wishlists/wishlist_screen.dart';
import 'package:ecommerce_1/views/profile_screen/edit_profile.dart';
import 'package:ecommerce_1/widgets_common/loadingIndicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/consts/lists.dart';
import 'package:ecommerce_1/controller/auth_controller.dart';
import 'package:ecommerce_1/views/auth_screen/login_screen.dart';
import 'package:ecommerce_1/views/profile_screen/components/details_card.dart';
import 'package:ecommerce_1/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_1/controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static var userdata;

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(ProfileController());
    return bgWidget(
      Scaffold(
        body: SafeArea(
                  child: Column(
                    children: [
                      //edit profile
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side:BorderSide(
                                    color: whiteColor,
                                  )
                              ),
                              onPressed:()async{
                                await Get.put(AuthController().signOutMethod(context));
                                Get.offAll(()=>LoginScreen());
                              },
                              child:logout.text.white.fontFamily(semibold).make()),
                          10.widthBox,
                        ],
                      ),
                      //user details
                      StreamBuilder<QuerySnapshot>(
                        stream: FirestoreServices.getUser(currentUser!.uid),
                        builder:(BuildContext context,AsyncSnapshot <QuerySnapshot> snapshot) {
                          if(!snapshot.hasData){
                            return Center(
                                child:loadingIndicator()
                            );
                          }
                          else if(snapshot.data!.docs.isEmpty)
                          {
                            return Center(child: "No data".text.make());
                          }
                          else{
                            userdata = snapshot.data!.docs[0];

                            return Row(
                              children: [
                                10.widthBox,
                                userdata['imageUrl']==''
                                    ? Image.asset(imgProfile2,width:100,fit: BoxFit.cover,).box.roundedFull.white.shadowSm.clip(Clip.antiAlias).make()
                                    : Image.network(userdata['imageUrl'],width:100,fit: BoxFit.cover,).box.roundedFull.white.shadowSm.clip(Clip.antiAlias).make(),
                                10.widthBox,
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "${userdata['name']}".text.fontFamily(semibold).white.make(),
                                      "${userdata['email']}".text.fontFamily(semibold).white.make(),
                                    ],
                                  ),
                                ),
                                Icon(Icons.edit,color:Colors.red,).onTap(() {
                                  controller.nameController.text  = userdata['name'];
                                  print(userdata['name']);
                                  Get.to(()=>EditProfileScreen());
                                }).box.margin(EdgeInsets.only(right:15)).roundedSM.size(35,35).shadowSm.white.make(),
                              ],
                            );
                          }

                        }
                      ),
                      Container(
                        color: whiteColor,
                        child: FutureBuilder(
                            future: FirestoreServices.getProfileCounts(),
                            builder: (BuildContext context,AsyncSnapshot snapshot){
                              if(!snapshot.hasData){
                                return Center(child: loadingIndicator(),);
                              }else{
                                var count = snapshot.data;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    detailsCard(context.screenWidth/3.4,"${count[0]}","in your cart"),
                                    detailsCard(context.screenWidth/3.4,"${count[1]}","in your wishlist"),
                                    detailsCard(context.screenWidth/3.4,"${count[2]}","your orders"),
                                  ],
                                );
                              }
                            }
                        ),
                      ),
                      10.heightBox,
                      //button section
                      ListView.separated(
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context,int index){
                            return ListTile(
                              onTap: (){
                                switch(index){
                                  case 0: Get.to(()=>OrdersScreen());break;
                                  case 1: Get.to(()=>MessagingScreen());break;
                                  case 2: Get.to(()=>WishlistScreen());break;
                                }
                              },
                              leading: Image.asset(profileButtonsIcons[index],
                                width:22 ,
                              ),
                              title: profileButtonsList[index].text.fontFamily(semibold).make(),
                            );
                          },
                          separatorBuilder:(context,index){
                            return Divider(color:darkFontGrey);
                          },
                          itemCount: profileButtonsList.length
                      ).box.rounded
                          .shadowSm
                          .white.margin(EdgeInsets.all(12))
                          .padding(EdgeInsets.symmetric(horizontal: 16))
                          .make().box.color(redColor).make(),
                    ],
                  ),
                )

        )
    );
  }
}
