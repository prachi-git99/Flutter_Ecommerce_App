import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/views/home_screen/home.dart';
import 'package:get/get.dart';

class OrderPlaceScreen extends StatefulWidget {
  const OrderPlaceScreen({Key? key}) : super(key: key);

  @override
  State<OrderPlaceScreen> createState() => _OrderPlaceScreenState();
}

class _OrderPlaceScreenState extends State<OrderPlaceScreen> {

  changeScreen(){
    Future.delayed(Duration(seconds:2),(){
      Get.offAll(()=>Home());
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    changeScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: context.screenWidth,
        height: context.screenHeight,
        color: whiteColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(imgOrderDone),
            "Order Placed Successfully".text.fontFamily(semibold).size(16).green500.make(),
          ],
        ),
      ),
    );
  }
}
