import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:testing/Style.dart';

import 'CartPage.dart';
import 'fmain.dart';




class hotelPage extends StatefulWidget {
  String title;
  String desc;
  String link;
  String price;
   hotelPage(this.title, this.desc, this.link, this.price);
  @override
  _hotelPageState createState() => _hotelPageState();
}

class _hotelPageState extends State<hotelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: blue,
                      image: DecorationImage(
                        image: NetworkImage(this.widget.link),
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
                        SizedBox(height: 200,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Text(this.widget.title, style: TextStyle(
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
                        Text(this.widget.desc, style: TextStyle(
                          color: Colors.white,
                          fontSize: 12
                        ),)
                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Today's Special", style: TextStyle(
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
                        SizedBox(height: 20,),
                        placesWidget("food1", "Sushi Platter"),
                        SizedBox(height: 20,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Extras", style: TextStyle(
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
                        SizedBox(height: 20,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              dishWidget("sushi", "Row Sushi", "5 Sushis served in a row"),
                              dishWidget("suchi2", "Prato Sushi", "5 Sushis served in a row"),
                              dishWidget("sushi3", "Sushi Box", "5 Sushis served in a row"),
                              dishWidget("sushi4", "Row Sushi", "5 Sushis served in a row"),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      InkWell(
                        onTap: openCartPage,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                            color: greenBtn
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_shopping_cart,
                                color: Colors.white,
                                    size: 18,),
                                Text(" CART", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700
                                ),)
                              ],
                            ),
                          ),
                        ),
                      ),
                     
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Container dishWidget(String img, String name, String description)
  {
    return Container(
      width: 120,
        child: Column(
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(this.widget.link),
                )
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("$name", style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700
                ),),
                SizedBox(height: 5,),
                Text("$description",style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: black
                ),),
                SizedBox(height: 5,),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    border: Border.all(color: black)
                  ),
                  child: Text("+ Cart"),
                )
              ],
            )
          ],
        ),
    );

  }
  Row placesWidget(String img, String name)
  {
    return Row(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(this.widget.link),
              )
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("$name", style: TextStyle(
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
              Text(this.widget.desc, style: TextStyle(
                  fontSize: 12
              ),)
            ],
          ),
        ),
        InkWell(
          onTap: (){



            

cartiItems.add({'imageurl':img, "itemname":name,"count":1,"price":this.widget.price});
print(cartiItems);
Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CartPage( )));

                                
print(cartiItems);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: greenBtn
            ),
            child: Text("Order Now", style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w700
            ),),
          ),
        )
      ],
    );
  }
  void openCartPage()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
  }
}
