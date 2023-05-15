import 'package:ecommerce_1/controller/product_controller.dart';
import 'package:ecommerce_1/views/cart_screen/cart_screen.dart';
import 'package:ecommerce_1/views/category_screen/category_screen.dart';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/controller/home_controller.dart';
import 'package:ecommerce_1/views/home_screen/home_screen.dart';
import 'package:ecommerce_1/views/profile_screen/profile_screen.dart';
import 'package:ecommerce_1/widgets_common/exit_dialoge.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var controller=Get.put(HomeController());


    var navbarItem=[
      BottomNavigationBarItem(icon:Image.asset(icHome,width: 26,),label:home),
      BottomNavigationBarItem(icon:Image.asset(icCategories,width: 26,),label:categories),
      BottomNavigationBarItem(icon:Image.asset(icCart,width: 26,),label:cart),
      BottomNavigationBarItem(icon:Image.asset(icProfile,width: 26,),label:account),
    ];
    var navBody =[
      HomeScreen(),
      CategoryScreen(),
      CartScreen(),
      ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: ()async{
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context)=>exitDialog(context)
        );
        return false;
      },
      child: Scaffold(
        body:Column(
          children: [
            Obx(()=>Expanded(
                child: navBody.elementAt(controller.currentNavIndex.value),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Obx(()=>
            BottomNavigationBar(
              currentIndex:controller.currentNavIndex.value,
              selectedItemColor: redColor,
              selectedLabelStyle: TextStyle(fontFamily: semibold),
              backgroundColor: whiteColor,
              type: BottomNavigationBarType.fixed,
              onTap: (value){
                controller.currentNavIndex.value=value;
              },
              items:navbarItem),
        ),
      ),
    );
  }
}
