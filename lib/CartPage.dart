import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:testing/Style.dart';
import 'package:testing/fmain.dart';
import 'package:testing/methods.dart';

import 'SuccessPage.dart';
import 'common/theme_helper.dart';
int price=0;
int i=0;
String list='';
class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: cartPage(),
    );
  }
}
bool sigma=true;
bool beta=false;
 
TextEditingController phno=TextEditingController();
TextEditingController adr=TextEditingController();


class cartPage extends StatefulWidget {

   
  @override
  _cartPageState createState() => _cartPageState();
}

class _cartPageState extends State<cartPage> {


  listviewgenerator() {
   cartiItems.forEach((element) { 
  

i++;

      var pk=element['itemname'];
    list=list+','+pk;
    var cv=element['price'];
    price=price+ cv as int; 
   });
    return  ListView.builder( 
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: cartiItems.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                var temp = cartiItems[index];
              },
              child: Container( 
               
                child: placesWidget(cartiItems[index]['imageurl'], cartiItems[index]["itemname"], cartiItems[index]["count"],cartiItems[index]["price"]),
              ),
            );
          });
    
  }



 @override
 void initState() {
sigma=true;
beta=false;
 
    super.initState();
   
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: blue,
                      image: DecorationImage(
                          image: AssetImage("asset/images/hotelBig.png"),
                          fit: BoxFit.cover
                      ),
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              icon: Icon(Icons.arrow_back, color: Colors.white,), onPressed: () {  },
                          ),
                          IconButton(
                              icon: Icon(Icons.search, color: Colors.white,), onPressed: () {  },
                          ),
                        ],
                      ),
                      SizedBox(height: 100,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text("Cart", style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20
                              ),),
                              SizedBox(height: 10,),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Icon(Icons.star, color: Colors.white,),
                                  Icon(Icons.star, color: Colors.white,),
                                  Icon(Icons.star, color: Colors.white,),
                                  Icon(Icons.star, color: Colors.white,),
                                  Icon(Icons.star, color: Colors.white,),
                                  Text(" 250 Reviews", style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 13
                                  ),)
                                ],
                              )
                            ],
                          ),
                          Container(
                            height: 70,
                            width: 70,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                            child: Center(
                              child: Icon(Icons.favorite,color: Colors.redAccent, size: 35,),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15,),
                      Text("Ordering Food One Step Away", style: TextStyle(
                          color: Colors.white,
                          fontSize: 12
                      ),)
                    ],
                  ),
                ),
                SizedBox(height: 15,),
                Container(
                    
                  child: Stack(
                    children: [Visibility(visible: beta,
            child: Column(
              children: [
                 Container(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                   child: Text(
                                'Enter Your Details',
                                style: GoogleFonts.bebasNeue(fontSize: 52,color: Color(0xfff192a56)),
                              ),
                 ),
                            
                            SizedBox(height: 30.0),
                Container(padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                          child: TextField(
                                            controller: phno,
                                            obscureText: false,
                                            decoration: ThemeHelper().textInputDecoration('Phone Number', 'Enter your Phone Number'),
                                          ),
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                        ), 
                                                   Container(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          child: TextField(
                                            controller: adr,
                                            obscureText: false,
                                            decoration: ThemeHelper().textInputDecoration('Delivery Adress', 'Enter your Delivery Adress'),
                                          ),
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                        ), 
                                        
                                        
                                           Container(margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      decoration: ThemeHelper().buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                          child: Text('Place Order'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                        ),
                                        onPressed: () async {
                                          Position pos=await getLocation();
                                           await placeOrder(adr.text,phno.text,list,pos.latitude.toString(),pos.longitude.toString(),price.toString());
                                                    Navigator.of(context).push(MaterialPageRoute(builder: (_)=>SuccessPage()));
                                        },
                                      ),
                                    ),
              ],
            ),
          ),
                      Visibility(
                        visible: sigma,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("Your Cart", style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w700
                                  ),),
                                  SizedBox(width: 10,),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: 20),
                                      height: 0.5,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              ),
                              listviewgenerator(),
                        
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total ($i items)", style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18
                                  ),),
                                  Text(price.toString()+"Rs", style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16
                                  ),)
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("+Taxes", style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: Colors.grey
                                  ),),
                                  Text("\$2.1", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.grey
                                  ),)
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("+Delivery Charges", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.grey
                                  ),),
                                  Text("\$3.1", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.grey
                                  ),)
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Discounts", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.grey
                                  ),),
                                  Text("-\$6.1", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.grey
                                  ),)
                                ],
                              ),
                              SizedBox(height: 5,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Total Payable", style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                  ),),
                                  Text("\$102", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.grey
                                  ),)
                                ],
                              ),
                              SizedBox(height: 25,),
                              Text("Have a Promo Code?", style: TextStyle(
                                color: blue
                              ),),
                              SizedBox(height: 20,),
                              InkWell(
                                onTap: (){
                      
                      
                      setState(() {
                        
                       sigma=false;
                       beta=true;
                      });
                      
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(40)),
                                    color: greenBtn,
                                  ),
                                  child: Text("Check Out", style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700
                                  ),),
                                ),
                              ),
                         SizedBox(height: 10,),
                        
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
  Row placesWidget(String img, String name,int count,int price)
  {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(img)
              )
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600
              ),),
              Row(
                children: [
                  Icon(Icons.star, size: 20, color: Colors.orange,),
                  Icon(Icons.star, size: 20, color: Colors.orange,),
                  Icon(Icons.star, size: 20, color: Colors.orange,),
                  Icon(Icons.star, size: 20, color: Colors.orange,),
                  Icon(Icons.star, size: 20, color: Colors.orange,),
                ],
              ),
              Text("Lorem ipsum sits dolar amet is for publishing", style: TextStyle(
                  fontSize: 12
              ),)
            ],
          ),
        ),
        SizedBox(width: 10,),
        Row(
          children: [
            Text("Quantity ", style: TextStyle(
              fontSize: 14,
              color: black
            ),),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                  border: Border.all(color: black),
              ),
              child: Text('$count', style: TextStyle(

                  fontSize: 13,
                  fontWeight: FontWeight.w700
              ),),
            ),
          ],
        )
      ],
    );
  }
  void openSuccessPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>SuccessPage()));
  }
}
