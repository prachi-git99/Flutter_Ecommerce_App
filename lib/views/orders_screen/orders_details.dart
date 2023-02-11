import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/views/orders_screen/components/order_placed_details.dart';
import 'package:ecommerce_1/views/orders_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;

  const OrdersDetails({Key? key,this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        centerTitle: true,
        title: "Order Details".text.fontFamily(regular).color(redColor).make(),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Column(
                children: [
                  orderStatus(color:redColor,icon:Icons.thumb_up_alt_sharp,title:"Placed",showDone:data['order_placed']),
                  orderStatus(color:Colors.blue,icon:Icons.add_shopping_cart,title:"Confirmed",showDone:data['order_confirm']),
                  orderStatus(color:Colors.yellow,icon:Icons.delivery_dining,title:"On Delivery",showDone:data['order_on_delivery']),
                  orderStatus(color:Colors.deepPurple ,icon:Icons.done_outline,title:"Delivered",showDone:data['order_delivered']),
                  Divider(),
                  10.heightBox,
                  Column(
                      children: [
                        orderPlacedDetails(
                            title1:"Order Code",
                            title2:"Shipping Method",
                            detail1:data['order_code'],
                            detail2:data['shipping_method']
                        ),
                        orderPlacedDetails(
                            title1:"Order Date",
                            title2:"Payment Method",
                            detail1:intl.DateFormat().add_yMd().format(data['order_date'].toDate()),
                            detail2:data['payment_method']
                        ),
                        orderPlacedDetails(
                            title1:"Payment Status",
                            title2:"Delivery Status",
                            detail1:"Unpaid",
                            detail2:"Order Placed"
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "Shipping Address".text.fontFamily(semibold).make(),
                                  "Name:${data['order_by_name']}".text.color(Colors.grey).fontFamily(semibold).make(),
                                  "Email:${data['order_by_email']}".text.color(Colors.grey).fontFamily(semibold).make(),
                                  "Address:${data['order_by_address']}".text.color(Colors.grey).fontFamily(semibold).make(),
                                  "City:${data['order_by_city']}".text.color(Colors.grey).fontFamily(semibold).make(),
                                  "State:${data['order_by_state']}".text.color(Colors.grey).fontFamily(semibold).make(),
                                  "Pincode:${data['order_by_postalcode']}".text.color(Colors.grey).fontFamily(semibold).make(),
                                  "Phone:${data['order_by_phone']}".text.color(Colors.grey).fontFamily(semibold).make(),

                                ],
                              ),
                              SizedBox(
                                width: 130,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    "Total Amount".text.fontFamily(semibold).make(),
                                    "Rs. ${data['total_amount']}".text.color(redColor).fontFamily(bold).make(),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ).box.outerShadowMd.white.make(),
                  Divider(),
                  10.heightBox,
                  "Ordered Product".text.size(16).color(darkFontGrey).fontFamily(semibold).makeCentered(),
                  10.heightBox,
                  ListView(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children:List.generate(data['orders'].length, (index){
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          orderPlacedDetails(
                              title1:data['orders'][index]['title'],
                              title2:data['orders'][index]['tprice'],
                              detail1:"${data['orders'][index]['qty']}x",
                              detail2:"Refundable"
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              width: 30,
                              height:20,
                              color: Color(data['orders'][index]['color']),
                            ).box.shadowSm.make(),
                          ),
                          Divider(),
                        ],
                      );
                    }).toList(),
                  ).box.outerShadowMd.white.margin(EdgeInsets.only(bottom: 4)).make(),
                  20.heightBox,


                ],
              )
            ],
          ),
        ),
      )
    );
  }
}
