import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore firestore = FirebaseFirestore.instance;

User? currentUser = auth.currentUser;//jo bhi user login hoga uska sara data is var k help se get kr sakte h

//collections
const usersCollection ="users";
const productsCollection ="products";
const cartCollection='cart';
const chatsCollection ='chats';
const messagesCollection ='messages';
const ordersCollection ='orders';
