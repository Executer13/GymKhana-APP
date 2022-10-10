
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testing/colors.dart';
import 'package:testing/constants.dart';
import 'package:testing/methods.dart';
import 'package:testing/notifications.dart';
import 'package:testing/smart/forgot_password_page.dart';
import 'package:testing/smart/login_page.dart';
import 'package:testing/smart/registration_page.dart';
import 'package:testing/smart/widgets/header_widget.dart';
import 'facepage.dart';
Map profData={} ;
bool _isLoading=true;

class ProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
     return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;
  

fetchDatabaselist()  async {
    Map resultant = await getprofData();
  
    print('pkr');
    if (resultant == null) {
      print('error');
    } else {
      setState(() {
        
        profData = resultant;
        
      });
    }
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

  @override
  Widget build(BuildContext context) {
    return 
                                          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
                                            child: 
                                             
                                               _isLoading
                                                  ? NewsCardSkelton()
                                                  : 
    
    
    
    
    
    SafeArea(
     
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(height: 100, child: HeaderWidget(100,false,Icon(Icons.house_rounded),false, fun: (){}, notiText: 'Profile',),),
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(profData['imageurl']),fit: BoxFit.fill),
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(width: 5, color: Colors.white),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(color: Colors.black12, blurRadius: 20, offset: const Offset(5, 5),),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(profData['name'].toUpperCase(), style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Text(profData['type'].toUpperCase(), style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                  SizedBox(height: 10,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                          alignment: Alignment.topLeft,
                          child: Text(
                            "User Information",
                            style: TextStyle(
                              color: Colors.black87,
                              fontWeight: FontWeight.w500,
                              fontSize: 16,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Card(
                          child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(15),
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    ...ListTile.divideTiles(
                                      color: Colors.grey,
                                      tiles: [
                                        ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 4),
                                          leading: Icon(Icons.my_location,color: tone),
                                          title: Text("Location"),
                                          subtitle: Text(profData['country']+" "+profData['city']),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.email,color:tone),
                                          title: Text("Email"),
                                          subtitle: Text(profData['email']),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.phone,color:tone),
                                          title: Text("Phone"),
                                          subtitle: Text(profData['phoneNumber']),
                                        ),
                                        ListTile(
                                          leading: Icon(Icons.person,color:tone),
                                          title: Text("About Me"),
                                          subtitle: Text(
                                             profData['MemberId'].toString()),
                                        ),
                                         ListTile(
                                          leading: Icon(Icons.monetization_on,color:tone),
                                          title: Text("Income"),
                                          subtitle: Text(
                                             profData['Income']),
                                        ),
                                      ],
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }

}