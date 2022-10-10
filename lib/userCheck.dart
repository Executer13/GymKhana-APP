import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:testing/home.dart';
import 'package:testing/main.dart';
import 'package:testing/pages/onboarding_page.dart';
import 'package:testing/screens/product/products_screen.dart';


import 'fingerpage.dart';






class VerifyCheck extends StatefulWidget {
    final List<CameraDescription> cameras;
    final String don;
    VerifyCheck(this.cameras,this.don);
  @override
  _VerifyCheckState createState() => _VerifyCheckState();
}

class _VerifyCheckState extends State<VerifyCheck>{

  final FirebaseAuth _auth = FirebaseAuth.instance;
 

  void initState() {
  
   
    super.initState();
  
   
  
  }
  @override
  Widget build(BuildContext context) {
   memCheck();
    if (_auth.currentUser == null) {
      return OnboardingPage( cameras: this.widget.cameras,);
    } else {
            
        
          
        if(this.widget.don=='paid'){
          print(this.widget.don);
          return FingerWndow( cameras: this.widget.cameras,);}
        else{
          return ProductsScreen();
        }

      
    
  }
}
}