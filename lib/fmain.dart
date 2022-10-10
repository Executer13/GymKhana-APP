
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:testing/Style.dart';
import 'package:testing/constants.dart';
import 'package:testing/methods.dart';
import 'package:testing/notifications.dart';
import 'CartPage.dart';
import 'Hero.dart';
import 'HotelPage.dart';

 List<dynamic> cartiItems = [];

FirebaseAuth _auth = FirebaseAuth.instance;

class MyFPage extends StatefulWidget {
  @override
  _MyFPageState createState() => _MyFPageState();
}

class _MyFPageState extends State<MyFPage> {

late List items=[];
 late bool _isLoading;
late Position position;
fetchDatabaselist()  async {
    List resultant = await GetData().getData();
    print(resultant);
    if (resultant == null) {
      print('error');
    } else {
      setState(() {
        
        items = resultant;
        
      });
    }
  }

 
  Future<void> _pullRefresh() async {
    
    setState(() {
     fetchDatabaselist();
    });
    // why use freshWords var? https://stackoverflow.com/a/52992836/2301224
  }

  @override
  void initState() {
 _isLoading = true;
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });


    super.initState();
    
  fetchDatabaselist();
  }

  listviewgenerator() {
    return RefreshIndicator( onRefresh: _pullRefresh,
      child: ListView.builder( 
          physics: NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                var temp = items[index];
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => hotelPage(items[index]["itemname"],items[index]["Description"],items[index]['imageurl'],items[index]['itemprice'] )));
              },
              child: Container( 
               
                child: placesWidget(items[index]['imageurl'], items[index]["itemname"],items[index]["Description"],items[index]["itemprice"]),
              ),
            );
          }),
    );
  }






  @override
  Widget build(BuildContext context) {
    return  
                                          SafeArea(
                                            child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 0),
                                              child: 
                                               
                                                 _isLoading
                                                    ? NewsCardSkelton()
                                                    : 
                                                    
                                                                  
                                              
                                              
                                              
                                              
                                              SafeArea(
                                                  child: SingleChildScrollView(
                                                    child: Container(
                                                      padding: EdgeInsets.symmetric(horizontal: 15),
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          SizedBox(height: 20,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("Today's Special", style: TextStyle(
                                                                fontSize: 26,
                                                                fontWeight: FontWeight.w700
                                                              ),),
                                                              Container(
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.all(Radius.circular(25)),
                                                                        color: greenBtn
                                                                      ),
                                                                      child: Center(
                                                                        child: GestureDetector(
                                                                          onTap: (){
                                          
                                          
                                        logout(context);
                                                                          },
                                                                          child: Row(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            children: [
                                                                              Icon(Icons.logout,
                                                                              color: Colors.white,
                                                                                size: 18,
                                                                              ),
                                                                              Text(" Logout", style: TextStyle(
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
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          SizedBox(height: 10,),
                                                          Text("Find out what's cooking today!", style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 15,
                                                          ),),
                                                          SizedBox(height: 15,),
                                                          SingleChildScrollView(
                                                            padding: EdgeInsets.only(bottom: 20),
                                                            scrollDirection: Axis.horizontal,
                                                            child: Row(
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(context).size.width*0.55,
                                                                  height: 350,
                                                                  padding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                                                                  decoration: BoxDecoration(
                                                                    borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                    color: blue,
                                                                    boxShadow: [BoxShadow(spreadRadius: 0, offset: Offset(0,10), blurRadius: 0, color: blue.withOpacity(0.4))]
                                                                  ),
                                                                  child: Column(
                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                    children: [
                                                                      Expanded(
                                                                        child: Container(
                                                                          decoration: BoxDecoration(
                                                                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                            image: DecorationImage(fit: BoxFit.fitHeight,
                                                                              image: NetworkImage(items[0]['imageurl'])
                                                                            )
                                                                          )
                                                                        ),
                                                                      ),
                                                                      SizedBox(height: 15,),
                                                                      Text(items[0]['itemname'], style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 16,
                                                                        fontWeight: FontWeight.w700
                                                                      ),),
                                                                      SizedBox(height: 5,),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.star,
                                                                            color: Colors.white,
                                                                              size: 17,
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            color: Colors.white,
                                                                            size: 17,
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            color: Colors.white,
                                                                            size: 17,
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            color: Colors.white,
                                                                            size: 17,
                                                                          ),
                                                                          Icon(
                                                                            Icons.star,
                                                                            color: Colors.white,
                                                                            size: 17,
                                                                          ),
                                                                          Text(" 250 Ratings", style: TextStyle(
                                                                            color: Colors.white,
                                                                            fontSize: 10
                                                                          ),)
                                                                        ],
                                                                      ),
                                                                      SizedBox(height: 10,),
                                                                      Text(items[0]['Description'], style: TextStyle(
                                                                        color: Colors.white,
                                                                        fontSize: 13
                                                                      ),)
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(width: 10,),
                                                                Column(
                                                                  children: [
                                                                    Container(
                                                                      width: MediaQuery.of(context).size.width*0.35,
                                                                      height: 165,
                                                                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                                                      decoration: BoxDecoration(
                                                                        borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                        color: green,
                                                                          boxShadow: [BoxShadow(spreadRadius: 0, offset: Offset(0,10), blurRadius: 0, color: green.withOpacity(0.4))]
                                                                      ),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Expanded(
                                                                            child: Container(
                                                                              decoration: BoxDecoration(
                                                                                  image: DecorationImage(
                                              image: NetworkImage(items[1]['imageurl']),
                                                                                  )
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(height: 15,),
                                                                          Text(items[1]['itemname'], style: TextStyle(
                                                                              color: Colors.white,
                                                                              fontSize: 16,
                                                                              fontWeight: FontWeight.w700
                                                                          ),),
                                                                          SizedBox(height: 5,),
                                                                          Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.star,
                                                                                color: Colors.white,
                                                                                size: 14,
                                                                              ),
                                                                              Icon(
                                                                                Icons.star,
                                                                                color: Colors.white,
                                                                                size: 14,
                                                                              ),
                                                                              Icon(
                                                                                Icons.star,
                                                                                color: Colors.white,
                                                                                size: 14,
                                                                              ),
                                                                              Icon(
                                                                                Icons.star,
                                                                                color: Colors.white,
                                                                                size: 14,
                                                                              ),
                                                                              Icon(
                                                                                Icons.star,
                                                                                color: Colors.white,
                                                                                size: 14,
                                                                              ),
                                                                            ],
                                                                          ),
                                          
                                          
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(height: 20,),
                                                                    Column(
                                                                      children: [
                                                                        Container(
                                                                          width: MediaQuery.of(context).size.width*0.35,
                                                                          height: 165,
                                                                          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                                                                          decoration: BoxDecoration(
                                                                              borderRadius: BorderRadius.all(Radius.circular(30)),
                                                                              color: black,
                                                                              boxShadow: [BoxShadow(spreadRadius: 0, offset: Offset(0,10), blurRadius: 0, color: black.withOpacity(0.4))]
                                                                          ),
                                                                          child: Column(
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Expanded(
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image:NetworkImage(items[1]['imageurl'])
                                              )
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(height: 15,),
                                                                              Text(items[1]['itemname'], style: TextStyle(
                                                                                  color: Colors.white,
                                                                                  fontSize: 16,
                                                                                  fontWeight: FontWeight.w700
                                                                              ),),
                                                                              SizedBox(height: 5,),
                                                                              Row(
                                                                                children: [
                                                                                  Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 14,
                                                                                  ),
                                                                                  Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 14,
                                                                                  ),
                                                                                  Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 14,
                                                                                  ),
                                                                                  Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 14,
                                                                                  ),
                                                                                  Icon(
                                            Icons.star,
                                            color: Colors.white,
                                            size: 14,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                          
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                          
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(height: 20,),
                                                          Row(
                                                            crossAxisAlignment: CrossAxisAlignment.end,
                                                            children: [
                                                              Text("Dishes", style: TextStyle(
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
                                                          
                                                          listviewgenerator()
                                                        ],
                                                      ),
                                                    ),
                                                  ))),
                                          );
  }
  Column placesWidget(String img, String name,String description,String price)
  {
    return Column(
      children: [SizedBox(height: 20,),
        Row(
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                image: DecorationImage(
                  image: NetworkImage(img)
                )
              ),
            ),
            SizedBox(width: 12,),
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
                  Text(description, style: TextStyle(
                    fontSize: 12
                  ),)
                ],
              ),
            ),
            InkWell(
              onTap: (){

 
bool bola=false;
int pr=int.parse(price);
var element={'imageurl':img, "itemname":name,"count":1,"price":pr};
int i=0;
if(cartiItems.length==0){
  
  cartiItems.add(element);
}
else{
  cartiItems.forEach((y) {

        if(y['itemname']==name){
          print('here');
          y['count']=y['count']+1;
            print('here2');
            i++;

        }
        else if(y==cartiItems.last && i==0){
          
          bola=true;
        }

    });
if(bola==true){
  cartiItems.add(element);
  bola=false;
}




}
print(cartiItems);
Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => CartPage( )));

                                

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
        ),
      ],
    );
  }
  
}