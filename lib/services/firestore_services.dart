import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/consts/consts.dart';

class FirestoreServices {

  //get users profile data
  static getUser(uid){
     return  firestore.collection(usersCollection).where('id',isEqualTo:uid).snapshots();
  }

  //get product category wise
  static getProducts(category){
    return firestore.collection(productsCollection).where('p_category',isEqualTo:category).snapshots();
  }

  static getCart(uid){
    return firestore.collection(cartCollection).where('added by',isEqualTo: uid).snapshots();
  }

  static deleteDocument(docId){
    return firestore.collection(cartCollection).doc(docId).delete();
  }

  static getChatMsg(docId){
    return firestore.collection(chatsCollection)
        .doc(docId).collection(messagesCollection)
        .orderBy('created_on',descending:false).snapshots();
  }

  static  getAllOrders(){
    return firestore.collection(ordersCollection)
        .where('order_by',isEqualTo: currentUser!.uid).snapshots();
  }

  static getWishlist(){
    return firestore.collection(productsCollection)
        .where('p_wishlist',arrayContains: currentUser!.uid).snapshots();
  }

  static getAllMessages(){
    return firestore.collection(chatsCollection).where('fromId',isEqualTo:currentUser!.uid ).snapshots();
  }
  
  static getProfileCounts()async{
    var count = await Future.wait([
      firestore.collection(cartCollection).where('added by',isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore.collection(productsCollection).where('p_wishlist',arrayContains: currentUser!.uid).get().then((value){
        return value.docs.length;
      }),
      firestore.collection(ordersCollection).where('order_by',isEqualTo: currentUser!.uid).get().then((value){
        return value.docs.length;
      })
    ]);
    return count;
  }

  static allProducts(){
    return firestore.collection(productsCollection).snapshots();
  }
  
  static getFeaturedProducts(){
    return firestore.collection(productsCollection).where('isFeatured',isEqualTo: true).get();
  }

  static getSearchData(title){
    return firestore.collection(productsCollection).get();
  }

  static getSubCategories(title){
    return firestore.collection(productsCollection).where('p_subcategory',isEqualTo:title).snapshots();
  }

}