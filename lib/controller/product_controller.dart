import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/model/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{

  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;
  var subcat=[];

  var isFav = false.obs;


  //json ko use krne k liye
  getSubCategories(title) async{
    try{
      subcat.clear();
      var data = await rootBundle.loadString("lib/services/category_model.json");
      var decoded = categoryModelFromJson(data);
      //title k accor filter krenge and chnge kr denge into list
      var s = decoded.categories.where((element) => element.name == title).toList();
      //s k andr jo bhi filter hokr aaye h unko subcat k accor get krenge
      for(var e in s[0].subcategory){
        subcat.add(e);
      }

    }
    catch(e){
      print("json error is:$e");
    }


  }

  changeColorIndex(index){
    colorIndex = index;
  }

  increaseQuantity(totalQuantity){
    if(quantity.value<totalQuantity)
    quantity.value++;
  }

  decreaseQuantity(){
    if(quantity.value>0)
    quantity.value--;
  }

  calculateTotalPrice(price){
    totalPrice.value = price * (quantity.value);
    print("new price:$totalPrice");
  }
  
  addToCart({title,img,sellername,color,qty,tprice,context,vendorId})async{
    if(tprice>0){
      await firestore.collection(cartCollection).doc().set({
        'title':title,
        'img':img,
        'sellername':sellername,
        'color':color,
        'tprice':tprice,
        'vendor_id':vendorId,
        'added by':currentUser!.uid,
        'qty':qty
      }).catchError((error){
        VxToast.show(context, msg: error.toString());
      });
      VxToast.show(context,msg:'Added to Cart');
    }
    else{
      VxToast.show(context, msg:"Please Add Quantity");
    }


  }

  resetValues(){
    totalPrice.value=0;
    quantity.value=0;
    colorIndex.value=0;
  }

  addToWishlist(docId,context) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayUnion([
        currentUser!.uid
      ])
    },SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Added to wishlist");
  }

  removeFromWishlist(docId,context) async{
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist':FieldValue.arrayRemove([
        currentUser!.uid
      ])
    },SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: "Removed from wishlist");
  }

  checkIffav(data)async{
    if(data['p_wishlist'].contains(currentUser!.uid)){
      isFav(true);
    }
    else{
      isFav(false);
    }
  }



}