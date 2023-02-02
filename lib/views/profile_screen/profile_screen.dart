
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/consts/lists.dart';
import 'package:ecommerce_1/views/profile_screen/components/details_card.dart';
import 'package:ecommerce_1/widgets_common/bg_widget.dart';
import 'package:flutter/material.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        onPressed:(){},
                        child:logout.text.white.fontFamily(semibold).make()),
                  ],
                ),

                //user details
                Row(
                  children: [
                    Image.asset(imgProfile2,width:100,fit: BoxFit.cover,).box.roundedFull.shadowSm.clip(Clip.antiAlias).make(),
                    10.widthBox,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Prachi".text.fontFamily(semibold).white.make(),
                          "prachi@gmail.com".text.fontFamily(semibold).white.make(),
                        ],
                      ),
                    ),
                    Icon(Icons.edit,color: whiteColor,).onTap(() { }),
                    5.widthBox,
                  ],
                ),
                10.heightBox,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    detailsCard(context.screenWidth/3.4,"00","in your cart"),
                    detailsCard(context.screenWidth/3.4,"32","in your wishlist"),
                    detailsCard(context.screenWidth/3.4,"675","your orders"),
                  ],
                ),
                //button section
                ListView.separated(
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context,int index){
                      return ListTile(
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
          ),
        )
    );
  }
}
