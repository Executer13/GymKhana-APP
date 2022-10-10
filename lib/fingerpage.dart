import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:testing/colors.dart';
import 'package:testing/facepage.dart';
import 'package:testing/main.dart';
import 'package:testing/navbar.dart';
import 'package:testing/smart/login_page.dart';



import 'components/rounded_btn/rounded_btn.dart';
import 'finerprint.dart';
import 'fmain.dart';

var contexts;
bool pika=false;

class FingerWndow extends StatefulWidget {
  const FingerWndow({Key? key, required this.cameras}) : super(key: key);
  final List<CameraDescription> cameras;

  @override
  FfingerWndowState createState() => FfingerWndowState();
}

class FfingerWndowState extends State<FingerWndow> {



Future finger() async {

                          final isAuthenticated =
                            await fingerPrintSevice().authenticate();
                        if (isAuthenticated) {
                          
                           setState(() {
                            pika=true;
                          });

                          await Future.delayed(const Duration(milliseconds: 1750), (){});

                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => BottomNavBarV2(this.widget.cameras)));
                        }
}






@override
  void initState() {
    super.initState();
    pika=false;
    finger();
    

    
  }




  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    contexts=context;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: toneSec,
          title: Container(
            alignment: Alignment.center,
            child: const Text(
              'FingerPrint Authentication',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),backgroundColor: tone,
        body: Container(
            alignment: Alignment.center,
            child: Column(children: [
              SizedBox(
                height: size.height / 5,
              ),
              Container(
                alignment: Alignment.center,
                width: size.width / 1.1,
                height: size.height / 4,
               
                child: 
                  
                
                
                
                
                Column(
                  children: [



                    GestureDetector(
                      onTap: () async{
                         

                          final isAuthenticated =
                            await fingerPrintSevice().authenticate();
                        if (isAuthenticated) {
                          
                           setState(() {
                            pika=true;
                          });

                          await Future.delayed(const Duration(seconds: 2), (){});

                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (_) => BottomNavBarV2(this.widget.cameras)));
                        }


                      },
                      child: Lottie.asset('animation/finger.json',animate: pika,repeat: false,)),
                    
                  ],
                ),
                ),



Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: Text('Please Touch the FingerPrint Sensor.',
                      style: TextStyle(
                      color: Colors.white70,
                      fontWeight: FontWeight.w400,
                      fontSize: 13
                  ),
        ),
                ),



              ]),
              
            ));
  }
}

buildText(String text, bool Checked) => Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Checked
              ? Icon(
                  Icons.check,
                  color: Colors.green,
                )
              : Icon(
                  Icons.close,
                  color: Colors.green,
                ),
          const SizedBox(
            width: 12,
          ),
          Text(
            text,
            style: TextStyle(fontSize: 24),
          )
        ],
      ),
    );



