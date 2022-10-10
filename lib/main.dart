import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:testing/colors.dart';
import 'package:testing/htmlSubs.dart';
import 'package:testing/membership.dart';
import 'package:testing/methods.dart';
import 'package:testing/navbar.dart';
import 'package:testing/pages/onboarding_page.dart';
import 'package:testing/profile/profile_screen.dart';
import 'package:testing/profile_page.dart';

import 'package:testing/smart/registration_page.dart';


import 'package:testing/upload.dart';
import 'package:testing/userCheck.dart';



import 'cast_vote.dart';

import 'facepage.dart';
import 'fmain.dart';
import 'home.dart';
import 'package:testing/settings.dart' as st;

import 'notifications.dart';
import 'screens/product/products_screen.dart';



 String don='';
  String token = '';
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    final FirebaseAuth? _auth = FirebaseAuth.instance;


 
 
  memCheck() async {
if(_auth?.currentUser==null){}
else{
   await
      FirebaseFirestore.instance.collection('users').doc(_auth?.currentUser!.uid).get()
    .then((value) {
     

      
             don= value.data()!['paymet'];
            
      
       print("value is "+don);
       


       // Access your after your get the data
  
    });}



  }


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  print("it is done");

  await memCheck();

  final cameras =await availableCameras();
  runApp( MyApp(cameras: cameras));
}


class MyApp extends StatelessWidget {
   MyApp({required this.cameras, Key? key}) : super(key: key);
  final List<CameraDescription> cameras;
  Color _primaryColor=Color(0xfff32c36c);
 Color _accentColor=Color.fromARGB(255, 39, 156, 86);
    
  // This widget is the root of your application.


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        fontFamily: 'Roboto-Regular'
      ),
      debugShowCheckedModeBanner: false,
      home:  VerifyCheck(this.cameras,don),
      //VerifyCheck(cameras),

      //MyFacePage(cameras),
    );
  }
}


