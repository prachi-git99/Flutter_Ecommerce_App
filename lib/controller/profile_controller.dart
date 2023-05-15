
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController{

  var profileImagePath = "".obs;
  var profileImageLink="";
  var isloading =false.obs;
  //textfield
  var nameController =TextEditingController();
  var oldpasswordController =TextEditingController();
  var newpasswordController =TextEditingController();
  var emailController =TextEditingController();

  changeImage(context)async{
    try{
      final img = await ImagePicker().pickImage(source:ImageSource.gallery,imageQuality: 70);
      if(img == null) return ;
      profileImagePath.value=img.path;
    }
    on PlatformException catch(e){
      VxToast.show(context,msg:"Something went wrong");
    }
  }

  uploadProfileImage()async {
    var filename = basename(profileImagePath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImagePath.value));
    profileImageLink=await ref.getDownloadURL();

  }
  
  updateProfile({name,password,imgUrl,email})async{
    var store =firestore.collection(usersCollection).doc(currentUser!.uid);
    await store.set({
      'name':name,
      'password':password,
      'imageUrl':imgUrl,
      'email':email,
    },SetOptions(merge: true));//sirf jo hmm ediyt krenge unko edit krega baaki sb vese k vese mrge
    isloading(false);
  }

  changeAuthPassword({email,password,newPassword})async{
    final cred = EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value){
      currentUser!.updatePassword(newPassword);
    }).catchError((error){
      print(error.toString());
    });//user ko vps se loggin

  }

}