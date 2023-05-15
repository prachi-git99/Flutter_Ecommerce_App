import 'dart:async';
import 'package:ecommerce_1/consts/consts.dart';
import 'package:ecommerce_1/controller/auth_controller.dart';
import 'package:ecommerce_1/services/firestore_services.dart';
import 'package:ecommerce_1/views/auth_screen/login_screen.dart';
import 'package:ecommerce_1/views/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({Key? key}) : super(key: key);
  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {


  bool isEmailVerified = false;
  bool canResendEmail=false;
  Timer? timer;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("hello bro init");
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerificationEmail();
      timer=Timer.periodic(Duration(seconds:5),(_) => checkEmailVerified(),);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer ?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async{
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified){
      timer?.cancel();
    }
  }

  Future sendVerificationEmail() async{
    try{
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(()=>canResendEmail=false);
      await Future.delayed(Duration(seconds:10));
      setState(()=>canResendEmail=true);
    }catch(e){
      VxToast.show(context, msg:"Please Verify your Email Id");
    }
  }

  var controller = Get.put(AuthController());

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? Home()
      : Scaffold(
    body: Padding(
      padding: EdgeInsets.all((16.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('A Verification Email has been sent to your Email Id',
            style: TextStyle(
              fontSize:18,
              fontWeight: FontWeight.w300,
              color: Colors.blue[700],
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height:25,),
          // ElevatedButton.icon(
          //   style: ElevatedButton.styleFrom(
          //     minimumSize: Size.fromHeight(50),
          //   ),
          //   icon :Icon(Icons.email,size:32),
          //   label:Text(
          //     'Resend Email',style: TextStyle(fontSize:18,color: Colors.white,fontWeight: FontWeight.w300),
          //   ) ,
          //   onPressed: canResendEmail ? sendVerificationEmail:null,
          // ),
          // SizedBox(height:10,),
          TextButton(
              onPressed: ()=>FirebaseAuth.instance.signOut().then((value){
                Get.to(()=>LoginScreen());
              }),
              child:Text('Cancel',style: TextStyle(fontSize:18,color: Colors.blue,fontWeight: FontWeight.w300),),
              style: ElevatedButton.styleFrom(minimumSize: Size.fromHeight(50))),
        ],
      ),
    ),
  );
}
