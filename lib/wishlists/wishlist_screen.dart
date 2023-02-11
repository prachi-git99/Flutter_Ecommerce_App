import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/services/firestore_services.dart';
import 'package:ecommerce_1/widgets_common/loadingIndicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlist(),
          builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(!snapshot.hasData){
              return Center(
                child: loadingIndicator(),
              );
            }
            else if(snapshot.data!.docs.isEmpty){
              return "Empty Wishlist".text.color(darkFontGrey).makeCentered();
            }
            else{
              var data = snapshot.data!.docs;
              return ListView.builder(
                shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder:(BuildContext context,int index){
                    return ListTile(
                      leading: Image.network("${data[index]['p_img'][0]}",),
                      title: "${data[index]['p_name']}".text.size(16).fontFamily(semibold).make(),
                      subtitle:"${data[index]['p_price']}".numCurrency.text.color(redColor).size(14).fontFamily(semibold).make(),
                      trailing: Icon(Icons.favorite,color: redColor,).onTap(() async{
                        await firestore.collection(productsCollection).doc(data[index].id).set({
                          'p_wishlist':FieldValue.arrayRemove([currentUser!.uid])
                        },SetOptions(merge:true));
                        VxToast.show(context, msg:"${data[index]['p_name']} Removed from wishlist");

                      }),
                    );
                  }
              );
            }
          }
      ),
    );
  }
}
