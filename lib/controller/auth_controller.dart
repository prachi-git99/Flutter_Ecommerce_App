
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/views/auth_screen/verify_email.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {

  var isloading =false.obs;

  //textcontrollers
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneNumberController = TextEditingController();
  var otpCodeController=TextEditingController();
  var nameController=TextEditingController();


  //login method
  Future<UserCredential?> loginMethod({context})async{
    UserCredential? userCredential;
    try{
        userCredential = await auth.signInWithEmailAndPassword(email:emailController.text, password:passwordController.text);
    }on FirebaseAuthException catch(e){
      VxToast.show(context,msg:"Please Enter valid email or password");
    }
    return userCredential;
  }

  //signup method
  Future<UserCredential?> signupMethod({email,password,context})async{
    UserCredential? userCredential;
    try{
        userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password);
    }on FirebaseAuthException catch(e){
      VxToast.show(context,msg:"Please Enter valid data");
    }
    return userCredential;
  }

  //storing data in cloud method
  storeUserData({name,password,email,phone})async{
      DocumentReference store = await firestore.collection(usersCollection).doc(currentUser!.uid);
      store.set({
        "name":name,
        "password":password,
        "email":email,
        "imageUrl":"",
        "id":currentUser!.uid,
        "cart_count":"00",
        "order_count":"00",
        "wishlist_count":"00",
        "phone":phone,
      },SetOptions(merge: true));
  }

  //signOutMethod
  signOutMethod(context)async{
    try{
      await auth.signOut();
    }
    catch(e){
      VxToast.show(context, msg:"Signed Out");
    }
  }



}