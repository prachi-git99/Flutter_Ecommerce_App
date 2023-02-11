import 'package:ecommerce_1/consts/consts.dart';

Widget orderStatus({icon,color,String? title,showDone}){
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ).box.border(color: color).roundedSM.padding(EdgeInsets.all(4)).make(),
  trailing: SizedBox(
    height: 100,
    width: 120,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        title!.text.color(darkFontGrey).make(),
        showDone?Icon(
          Icons.done_all,
          color:Colors.green,
        ):Container(),
      ],
    ),
  ),
  );
}