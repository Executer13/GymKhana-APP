
import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:testing/colors.dart';
import 'package:testing/facepage.dart';
import 'package:testing/membership.dart';
import 'package:testing/methods.dart';
import 'package:testing/navbar.dart';


import '../common/theme_helper.dart';
import 'forgot_password_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';
var email = TextEditingController();
var password = TextEditingController();
bool sigma = true;
bool beta = false;
String rtspReal='https://media.w3.org/2010/05/sintel/trailer.mp4';
FirebaseAuth _auth = FirebaseAuth.instance;

Future getrtsp()  async {
 
   await
      FirebaseFirestore.instance.collection('DB').doc(_auth.currentUser!.uid).get()
    .then((value) {
      

      
             rtspReal= value.data()!['RTSP'];
            
      
       print("value is "+rtspReal);
       return value.data()!['RTSP'];



       // Access your after your get the data
     });
  }




class LoginPage extends StatefulWidget{
  final List<CameraDescription> cameras;
  const LoginPage({Key? key, required this.cameras}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 250;
  
  Key _formKey = GlobalKey<FormState>();

@override
initState(){
  super.initState();
   sigma = true;
 beta = false;
}
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [      Visibility(visible: beta,
            child: Column(
              children: [
                 Container(padding: EdgeInsets.fromLTRB(20, 320, 20, 0),
                   child: Text(
                                'Enter Your OTP',
                                style: GoogleFonts.bebasNeue(fontSize: 52,color: Color(0xfff192a56)),
                              ),
                 ),
                            
                            SizedBox(height: 30.0),
                Container(padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                          child: TextField(
                                            controller: password,
                                            obscureText: true,
                                            decoration: ThemeHelper().textInputDecoration('OPT', 'Enter your Enter Your OTP'),
                                          ),
                                          decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                        ), 
                                        
                                           Container(margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                                      decoration: ThemeHelper().buttonBoxDecoration(context),
                                      child: ElevatedButton(
                                        style: ThemeHelper().buttonStyle(),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                          child: Text('SUBMIT'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                        ),
                                        onPressed: () async {
                                        },
                                      ),
                                    ),
              ],
            ),
          ),


            Visibility(visible: sigma,
              child: Column(
                children: [
                  Container(
                    height: _headerHeight,
                    child: HeaderWidget(_headerHeight, false, Icon(Icons.login_rounded),true, fun: (){}, notiText: '',), //let's create a common header widget
                  ),
                  SafeArea(
                    child: Container( 
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        margin: EdgeInsets.fromLTRB(20, 40, 20, 10),// This will be the login form
                      child: Column(
                        children: [
                          Text(
                            'HELLO AGAIN',
                            style: GoogleFonts.bebasNeue(fontSize: 52,color: Color(0xfff192a56)),
                          ),
                          
                          SizedBox(height: 30.0),
                          Form(
                            key: _formKey,
                              child: Column(
                                children: [
                                  Container(
                                    child: TextField(controller: email,
                                      decoration: ThemeHelper().textInputDecoration('Email', 'Enter your Email Adress'),
                                    ),
                                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                  ),
                                  SizedBox(height: 30.0),
                                  Container(
                                    child: TextField(
                                      controller: password,
                                      obscureText: true,
                                      decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                                    ),
                                    decoration: ThemeHelper().inputBoxDecorationShaddow(),
                                  ),
                                  SizedBox(height: 15.0),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(0,0,10,20),
                                    alignment: Alignment.center,
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push( context, MaterialPageRoute( builder: (context) => ForgotPasswordPage()), );
                                      },
                                      child: Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: ThemeHelper().buttonBoxDecoration(context),
                                    child: ElevatedButton(
                                      style: ThemeHelper().buttonStyle(),
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                        child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                      ),
                                      onPressed: () async {
                                       //bar
                                       showDialog(context: context, builder: (context){
            
                                          return Center(child: CircularProgressIndicator());
            
                                       });
            
            
                              // Add login code
                              
                              
                                  UserCredential? userCredential =
                          await signin(email.text, password.text);
                      if (userCredential?.user != null) {
                        userCredential!.user!.emailVerified
                            ? {

                                                              await FirebaseAuth.instance.verifyPhoneNumber(timeout: Duration(seconds: 60),
  phoneNumber: '+92 302 7733 780',
  verificationCompleted: (PhoneAuthCredential credential) async {
 
    
Navigator.of(context).push(MaterialPageRoute(builder: (_) => BottomNavBarV2(this.widget.cameras)));

  },
  verificationFailed: (FirebaseAuthException e) {},
  codeSent: 
  
  
  (String verificationId, int? resendToken) {
    Navigator.of(context).pop();
setState(() {
  print(verificationId+' this is it');
      sigma=false;
    beta=true;
});
  },
  codeAutoRetrievalTimeout: (String verificationId) {
     alertbox(context,'Signin Eror','Something Went Wrong!','images/cancel.gif');

  },
)
                            
                                }
                            :() {Navigator.of(context).pop(); 
                            alertbox(context,'Please Verify Email ',
                          "Email Verification was sent to your Email, Please verify the Email First",'images/mail-verification.gif');};
                      } else {
                        Navigator.of(context).pop();
                        alertbox(context,'Signin Eror','Incorrect Email or Password. Kindly Type Correct Credentials!','images/cancel.gif');
                        print('error');
                      }
                                
                                      },
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.fromLTRB(10,100,10,0),
                                    //child: Text('Don\'t have an account? Create'),
                                    child: Text.rich(
                                      TextSpan(
                                        children: [
                                          TextSpan(text: "Don\'t have an account? "),
                                          TextSpan(
                                            text: 'Create',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = (){
                                                Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()));
                                              },
                                            style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                          ),
                                        ]
                                      )
                                    ),
                                  ),
                                ],
                              )
                          ),
                        ],
                      )
                    ),
                  ),
                ],
              ),
            ),
            Container( height: 150,
            
                 margin: EdgeInsets.fromLTRB(100,140,0,0),
                                padding: EdgeInsets.all(17),
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
                                child: Container(child: Image.asset('images/fflogo.png')),
                                )
          ],
        ),
      ),
    );

  }
}