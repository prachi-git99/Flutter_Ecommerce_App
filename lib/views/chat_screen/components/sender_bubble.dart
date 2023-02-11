import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:intl/intl.dart' as intl;

Widget senderBubble(DocumentSnapshot data){

  var t = data['created_on'] == null ? DateTime.now(): data['created_on'].toDate();

  var time = intl.DateFormat("h:mma").format(t);

  return Directionality(
    textDirection: data['uid'] == currentUser!.uid ? TextDirection.ltr:TextDirection.rtl ,
    child: Container(
      padding: EdgeInsets.all(12.0),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: data['uid'] == currentUser!.uid ? redColor:whiteColor,
        borderRadius: BorderRadius.only(
          topLeft:Radius.circular(20),
          topRight:Radius.circular(20),
          bottomLeft:Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          "${data['msg']}".text.color(data['uid'] == currentUser!.uid ?whiteColor:redColor,).size(16).make(),
          10.heightBox,
          time.text.color(data['uid'] == currentUser!.uid ?whiteColor:redColor).make(),
        ],
      ),
    ),
  );
}