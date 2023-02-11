import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/controller/profile_controller.dart';
import 'package:get/get.dart';
class HomeController extends GetxController{

  @override
  void onInit() {
    // TODO: implement onInit
    getUsername();
    super.onInit();
  }
  var currentNavIndex=0.obs;
   var username='';

   var searchController = TextEditingController();

   getUsername()async{
     var nameData = await firestore.collection(usersCollection).where('id',isEqualTo:currentUser!.uid).get()
         .then((value){
           if(value.docs.isNotEmpty){
             return value.docs.single['name'];
           }
     });
     username = nameData;

   }




}