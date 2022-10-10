import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testing/screens/product/components/product.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../methods.dart';
import '../constants.dart';
import 'category_list.dart';
import 'product_card.dart';
final FirebaseAuth _auth = FirebaseAuth.instance;
class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    sucess(String paymentType) async {

  FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).update({
          'paymet': 'paid',
          'category': paymentType,
        });
      
    String sig;
   Navigator.pop(context,true);
   if(paymentType=='basic'){sig='/test_00gcPXdPw2hL7Ic5ks';}
   else if(paymentType=='light'){sig='/test_6oE9DL6n4g8B3rW7sB';}
   else{sig='/test_eVa7vD5j0cWpd2wdR0';}
   
   Uri url=Uri(scheme: 'https',
    host: 'buy.stripe.com',
    path: sig, );

await launchUrl(url);

}

failure(){


   Navigator.of(context).pop();
     alertbox(context, 'Connection Failed', 'Please Check your Internet Connection', 'images/alerts.gif');
     return null;
}


    return SafeArea(
      bottom: false,
      child: Column(
        children: <Widget>[
         
         
          SizedBox(height: kDefaultPadding / 2),
          Expanded(
            child: Stack(
              children: <Widget>[
                // Our background
                Container(
                  margin: EdgeInsets.only(top: 70),
                  decoration: BoxDecoration(
                    color: kBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                ),
                ListView.builder(
                  // here we use our demo procuts list
                  itemCount: products.length,
                  itemBuilder: (context, index) => ProductCard(
                    itemIndex: index,
                    product: products[index],
                    press: () {
                      print('object');


           showDialog(context: context, builder: (context){

                                            return Center(child: CircularProgressIndicator());

                                         });

                     sucess(products[index].title.toString());
                    }, key: null,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
