import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/services/firestore_services.dart';
import 'package:ecommerce_1/views/orders_screen/orders_details.dart';
import 'package:ecommerce_1/widgets_common/loadingIndicator.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Orders".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getAllOrders(),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: loadingIndicator(),
            );
          }
          else if(snapshot.data!.docs.isEmpty){
            return "No Orders Found".text.color(darkFontGrey).makeCentered();
          }
          else{
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder:(BuildContext context ,int index){
                  return ListTile(
                    leading: "${index+1}".text.fontFamily(bold).color(darkFontGrey).xl.make(),
                    tileColor: Colors.grey[100],
                    title:data[index]['order_code'].toString().text.color(redColor).fontFamily(semibold).make(),
                    subtitle: data[index]['total_amount'].toString().numCurrency.text.fontFamily(bold).make(),
                    trailing: IconButton(
                      onPressed: (){
                        Get.to(()=>OrdersDetails(data:data[index]));
                      },
                      icon:Icon(Icons.arrow_back_ios_new_rounded,color: darkFontGrey,) ,
                    ),
                  );
                });
          }
        }
      ),
    );
  }
}
