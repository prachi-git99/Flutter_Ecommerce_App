import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/services/firestore_services.dart';
import 'package:ecommerce_1/views/category_screen/item_details.dart';
import 'package:ecommerce_1/widgets_common/loadingIndicator.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({Key? key,this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.getSearchData(title),
        builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(child: loadingIndicator(),);
          }
          else if(snapshot.data!.docs.isEmpty){
            return Center(child:"No Products found...".text.fontFamily(semibold).make(),);
          }
          else{
            var data =snapshot.data!.docs;

            var filtered = data.where((element) => element['p_name'].toString()
                .toLowerCase().contains(title!.toLowerCase())).toList();

            print("hey ${data[0]['p_name']}");
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:2,
                      mainAxisExtent: 300,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8
                  ),
                children: filtered.mapIndexed((currentValue, index) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(filtered[index]['p_img'][0],width:200,height: 200 ,fit: BoxFit.cover,),
                        Spacer(),
                        "${filtered[index]['p_name']}".text.fontFamily(semibold).color(darkFontGrey).make(),
                        10.heightBox,
                        "Rs.${filtered[index]['p_price']}".text.fontFamily(bold).color(redColor).size(16).make(),
                      ],
                ).box.white.shadowMd.margin(EdgeInsets.symmetric(horizontal: 4)).roundedSM
                    .padding(EdgeInsets.all(12))
                    .make().onTap(() {
                  Get.to(()=>ItemDetails(title:"${filtered[index]['p_name']}",data:filtered[index],));
                })
                ).toList(),

              ),
            );
          }
        }
      ),

    );
  }
}
