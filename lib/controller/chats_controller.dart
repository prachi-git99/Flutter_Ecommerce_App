import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/controller/home_controller.dart';
import 'package:get/get.dart';

class ChatsController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    getChatId();
    super.onInit();
  }

  var chats = firestore.collection(chatsCollection);
  var friendName=Get.arguments[0];
  var friendId=Get.arguments[1];
  var senderName=Get.find<HomeController>().username;
  var senderId=currentUser!.uid;
  var msgController=TextEditingController();

  dynamic chatDocId;

  var isloading = false.obs;

  getChatId() async{
    isloading(true);
    await chats.where('users',isEqualTo: {
      friendId:null,
      senderId:null,
    }).limit(1).get().then((QuerySnapshot snapshot){
      if(snapshot.docs.isNotEmpty){
        chatDocId =snapshot.docs.single.id;
      }else{
        chats.add({
          'created_on':null,
          'lst_msg':'',
          'users':{friendId:null,senderId:null},
          'toId':'',
          'fromId':'',
          'friend_name':friendName,
          'sender_name':senderName
        }).then((value){
          chatDocId =value.id;
        });
      }
    });
    isloading(false);
  }

  sendMsg(String msg) async{
    if(msg.trim().isNotEmpty){
      chats.doc(chatDocId).update(
        {
          'created_on':FieldValue.serverTimestamp(),
          'lst_msg':msg,
          'toId':friendId,
          'fromId':senderId,
        }
      );
      chats.doc(chatDocId).collection(messagesCollection).doc().set({
        'created_on':FieldValue.serverTimestamp(),
        'msg':msg,
        'uid':currentUser!.uid,
      });
    }
  }



}