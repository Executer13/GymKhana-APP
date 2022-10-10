import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

import 'methods.dart';





FirebaseAuth _auth = FirebaseAuth.instance;
class CardWidget extends StatelessWidget {
  List data = [
    {"color": Color(0xffff6968)},
    {"color": Color(0xff7a54ff)},
    {"color": Color(0xffff8f61)},
    {"color": Color(0xff2ac3ff)},
    {"color": Color(0xff5a65ff)},
    {"color": Color(0xff96da45)},
    {"color": Color(0xffff6968)},
    {"color": Color(0xff7a54ff)},
    {"color": Color(0xffff8f61)},
    {"color": Color(0xff2ac3ff)},
    {"color": Color(0xff5a65ff)},
    {"color": Color(0xff96da45)},
    
  ];
List names=[
  'Basic',
  'Plus','Premium'
];
  final colorwhite = Colors.white;

  @override
  Widget build(BuildContext context) {







sucess() async {


      
    
   Navigator.pop(context,true);
   Uri url=Uri(scheme: 'https',
    host: 'buy.stripe.com',
    path: '/test_bIYg293aS7C50fK149', );

await launchUrl(url);

}

failure(){


   Navigator.of(context).pop();
     alertbox(context, 'Connection Failed', 'Please Check your Internet Connection', 'images/alerts.gif');
     return null;
}










    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Stack(
        children: [
          GridView.builder(
            itemCount: 3,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio:  2,
              crossAxisCount: 1,
              // crossAxisSpacing: 10
            ),
            itemBuilder: (context, index) {
              return SizedBox(height: 1,
                child: InkWell(onTap: () async {


           showDialog(context: context, builder: (context){

                                            return Center(child: CircularProgressIndicator());

                                         });

sucess();
                },
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Card(
                      color: data[index]["color"],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '  MemberShip Type',
                                  style: TextStyle(color: colorwhite, fontSize: 16),
                                ),
                                Container(
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30),
                                          bottomLeft: Radius.circular(30),
                                          bottomRight: Radius.circular(30)),
                                      color: Color.fromRGBO(255, 255, 255, 0.38)),
                                  child: Icon(
                                    Icons.person,
                                    color: colorwhite,
                                    size: 20,
                                  ),
                                )
                              ],
                            )
                            ,Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(left:10,bottom: 20),
                              child: Text(names[index]
                              ,style: TextStyle(
                                fontSize: 27,
                                color: colorwhite),
                              )),
                              Container(
                              alignment: Alignment.topCenter,
                              padding: EdgeInsets.only(right:10),
                              child: Column(
                                children: [
                                  Text('Healthy'
                                  ,style: TextStyle(
                                    fontSize: 18,
                                    color: colorwhite),
                                  ),
                                  Text('50-120'
                                  ,style: TextStyle(
                                    fontSize: 18,
                                    color: colorwhite),
                                  ),
                                ],
                              ))
                         
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}