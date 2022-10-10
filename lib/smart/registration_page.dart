
import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:testing/common/theme_helper.dart';
import 'package:testing/main.dart';
import 'package:testing/smart/login_page.dart';
import 'package:testing/smart/widgets/header_widget.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../methods.dart';
import '../screens/product/products_screen.dart';


String rexid='';
class RegistrationPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
     return _RegistrationPageState();
  }
}

class _RegistrationPageState extends State<RegistrationPage>{
  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;
      var pickedFile;

  File? _photo;
  final ImagePicker _picker = ImagePicker();
pica() async {

     pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  }







  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  late ConfettiController _controllerBottomCenter;
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
  late String cnic;
  late String name;
  late String des;
  late String income;
  late String datetimes='';

  late String city;
  late String country;
  late String imgpath='';
  late String phno;
  late String cname; 
  late String picname;


@override
  void initState() {
    ConfettiController(duration: const Duration(seconds: 2));
    _controllerBottomCenter =
        ConfettiController(duration: const Duration(seconds: 2));
    
    super.initState();
  }


  @override
  void dispose() {
    _controllerBottomCenter.dispose();
    super.dispose();
  }






  @override
  Widget build(BuildContext context) {




    
  Future uploadFile() async {
    String? em='UserProfile';
    if (_photo == null) return;
    final fileName = basename(_photo!.path);
    final destination = em;


  showDialog(context: context, builder: (context){

                                        return Center(child: CircularProgressIndicator());

                                     });

    try {
      final ref = firebase_storage.FirebaseStorage.instance
          .ref(destination)
          .child(picname+".jpg");
      await ref.putFile(_photo!);
             
                        FirebaseStorage storage = FirebaseStorage.instance;
                      String value=  await storage.ref().child('UserProfile/'+picname+".jpg").getDownloadURL();
                        


       
     FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).update({
          'imageurl': value
        });



                       
                      // Add login code
                  
      Navigator.of(context).pop();
      alertbox(context, 'Signup Sucessful', 'You are being Redirected', 'images/uploading.gif');
      await Future.delayed(const Duration(milliseconds: 1750), (){});
      Navigator.of(context).push(

        MaterialPageRoute(builder: ((_) => ProductsScreen())
      ));


      
    } catch (e) {
      Navigator.of(context).pop();
      
       alertbox(context, 'Upload Failed', 'Please Check your Internet Connection', 'images/alerts.gif');
    }
  }

Future imgFromGallery() async {
    

    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
        uploadFile();

        
      } else {
        alertbox(context, 'No Image Selected', 'Please Upload a File', 'images/alerts.gif');
      }
    });
  }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 150,
              child:  HeaderWidget(150, false, Icon(Icons.person), false,fun: (){}, notiText: '',),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              alignment: Alignment.center,
              child: Column(
                children: [
                  Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _controllerBottomCenter,
              blastDirection: pi / 2,
              maxBlastForce: 3, // set a lower max blast force
              minBlastForce: 2,
              emissionFrequency: 0.3,
              minimumSize: const Size(10,
                  10), // set the minimum potential size for the confetti (width, height)
              maximumSize: const Size(20,
                  20), // set the maximum potential size for the confetti (width, height)
              numberOfParticles: 1,
              gravity: 1,
            ),
          ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          child: Stack(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(
                                      width: 5, color: Colors.white),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black12,
                                      blurRadius: 20,
                                      offset: const Offset(5, 5),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade300,
                                  size: 80.0,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(80, 80, 0, 0),
                                child: Icon(
                                  Icons.add_circle,
                                  color: Colors.grey.shade700,
                                  size: 25.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            onChanged: (value) {
                        name = value;
                      },
                            decoration: ThemeHelper().textInputDecoration('Full Name', 'Enter your Full name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                       
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            onChanged: (value) {
                        email = value;
                      },
                            decoration: ThemeHelper().textInputDecoration("E-mail address", "Enter your email"),
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) {
                              if(!(val!.isEmpty) && !RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$").hasMatch(val)){
                                return "Enter a valid email address";
                              }

                              
                              
                              return null;
                            


                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            onChanged: (value) {
                        cnic = value;
                      },
                            decoration: ThemeHelper().textInputDecoration(
                                "CNIC",
                                "Enter your CNIC Number"),
                            keyboardType: TextInputType.number,
                            
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 20.0),
                        Container(
                          child: TextFormField(
                            onChanged: (value) {
                        password = value;
                      },
                            obscureText: true,
                            decoration: ThemeHelper().textInputDecoration(
                                "Password*", "Enter your password"),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Please enter your password";
                              }
                              return null;
                            },
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            onChanged: (value) {
                        country = value;
                      },
                            decoration: ThemeHelper().textInputDecoration('Country', 'Enter your Country'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            onChanged: (value) {
                        city = value;
                      },
                            decoration: ThemeHelper().textInputDecoration('City', 'Enter your City'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            onChanged: (value) {
                        cname = value;
                      },
                            decoration: ThemeHelper().textInputDecoration('Company Name', 'Enter your Company Name'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),SizedBox(height: 30,),
                        Container(
                          child: TextFormField(
                            onChanged: (value) {
                        des = value;
                      },
                            decoration: ThemeHelper().textInputDecoration('Designation', 'Enter your Designation'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),
                        SizedBox(height: 30,),
                        Container(
                          child: TextFormField(keyboardType: TextInputType.number,
                            onChanged: (value) {
                        income = value;
                      },
                            decoration: ThemeHelper().textInputDecoration('Income', 'Enter your Income'),
                          ),





                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),

SizedBox(height: 30,),
                        Container(
                          child: TextFormField( keyboardType: TextInputType.phone,
                            onChanged: (value) {
                        phno = value;
                      },
                            decoration: ThemeHelper().textInputDecoration('Mobile Number', 'Enter your Mobile Number'),
                          ),
                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                        ),



                          







                        SizedBox(height: 15.0),
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Checkbox(
                                        value: checkboxValue,
                                        onChanged: (value) {
                                          setState(() {
                                            checkboxValue = value!;
                                            state.didChange(value);
                                          });
                                        }),
                                    Text("I accept all terms and conditions.", style: TextStyle(color: Colors.grey),),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    state.errorText ?? '',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(color: Theme.of(context).errorColor,fontSize: 12,),
                                  ),
                                )
                              ],
                            );
                          },
                          validator: (value) {
                            if (!checkboxValue) {
                              return 'You need to accept terms and conditions';
                            } else {
                              return null;
                            }
                          },
                        ),Column(
          children: <Widget>[
              
               Padding(
                            padding: EdgeInsets.fromLTRB(45, 10, 40,0),
                            child: Text('Kindly Upload your Profile Picture.', textAlign: TextAlign.center,
                            style: GoogleFonts.bebasNeue(
                              
                              color: Colors.grey ,
                              
                              fontSize: 20,
                            ),
                            ),
                          ),
                
            SizedBox(
              height: 22,
            ),
            
                              SizedBox(
              height: 22,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundColor: Color(0xffFDCF09),
                  child: _photo != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            _photo!,
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(50)),
                          width: 100,
                          height: 100,
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.grey[800],
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
          
          ],
        ),

                        SizedBox(height: 20.0),
                        Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: ElevatedButton(
                            style: ThemeHelper().buttonStyle(),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              child: Text(
                                "Register".toUpperCase(),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                
                       showDialog(context: context, builder: (context){

                                        return Center(child: CircularProgressIndicator());

                                     });

                      print(email+"   "+password);

                     await createAccount( context, email,  password, des, name, cnic, income, datetimes, city, country, imgpath,phno,cname);
                        picname=mem+'-'+name;
                        await  imgFromGallery();
               }
  }),
                        ),




                        SizedBox(height: 80.0),
                        Text("Or create account using social media",  style: TextStyle(color: Colors.grey),),
                        SizedBox(height: 25.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.googlePlus, size: 35,
                                color: HexColor("#EC2D2F"),),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("Google Plus","SHSS GOOGLE MAIL LINK",context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(width: 30.0,),
                            GestureDetector(
                              child: Container(
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(width: 5, color: HexColor("#40ABF0")),
                                  color: HexColor("#40ABF0"),
                                ),
                                child: FaIcon(
                                  FontAwesomeIcons.twitter, size: 23,
                                  color: HexColor("#FFFFFF"),),
                              ),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("Twitter","SHSS TWITTER LINK.",context);
                                    },
                                  );
                                });
                              },
                            ),
                            SizedBox(width: 30.0,),
                            GestureDetector(
                              child: FaIcon(
                                FontAwesomeIcons.facebook, size: 35,
                                color: HexColor("#3E529C"),),
                              onTap: () {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return ThemeHelper().alartDialog("Facebook",
                                          "SHSS FACEBOOK ICON",
                                          context);
                                    },
                                  );
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Gallery'),
                      onTap: () {
                        pica();
                        Navigator.of(context).pop();
                      }),
                 
                ],
              ),
            ),
          );
        });
  }


}


