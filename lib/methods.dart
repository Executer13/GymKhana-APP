import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imglib;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:testing/colors.dart';
import 'package:testing/constants.dart';
import 'package:testing/home.dart';
import 'package:testing/pages/onboarding_page.dart';
import 'package:testing/skelton.dart';
import 'package:testing/smart/login_page.dart';
import 'package:http/http.dart' as http;
import 'package:testing/userCheck.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:geolocator/geolocator.dart';

import 'FACE/utils.dart';
String mem='';
String  dtimes='';
FirebaseAuth _auth = FirebaseAuth.instance;



void showSimpleBar(BuildContext context, String str) {
  final Scaffold = ScaffoldMessenger.of(context);
  Scaffold.showSnackBar(SnackBar(
    content: Text(str),
    ));
}




Future<UserCredential?> createAccount(BuildContext context,String email, String password,String des,String name,String cnic,String income,String datetimes,String city,String country,String imgpath,String phno,String cname) async {

sucess() async {


      Navigator.of(context).pop();
     alertbox(context,'Verification Email Sent',
                    "Email Verification Sent, Please verify the Email First",'images/mail-verification.gif');

}

failure(String e){


   Navigator.of(context).pop();
     alertbox(context, 'Signup Failed', e, 'images/alerts.gif');
     return null;
}


  try {
    
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    userCredential.user?.sendEmailVerification();

    final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
       mem=DateTime.now().millisecond.toString()+DateTime.now().microsecond.toString()+'3'+DateTime.now().day.toString()+DateTime.now().hour.toString()+DateTime.now().millisecond.toString();
      
    dtimes=mem+"-"+name+'.jpg';
    Map<String, dynamic> g = {
      "email": email,
      "password": password,
      "CNIC":cnic,
      "CompanyName":cname,
      "name":name,
      "Designation":des,
      "Income":income,
      "MemberId":mem,
      "category":"",
      "city":city,
      "country":country,
      "imagename":dtimes,
      "keyy":userCredential.user!.uid,
      "membership":"pending",
      "phoneNumber":phno,
      "type":"user",
      "paymet":"",
      'imageurl':'',
      'voted':0
      
      
      };
    users.doc(_auth.currentUser!.uid).set(g);
  
    sucess();


  } on FirebaseAuthException catch (e) {
    print('aag'+e.toString());
    
    failure(e.toString());
    return null;
  }
}

Future<UserCredential?> signin(String email, String password) async {
  try {

    print(email+'  '+password);
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return userCredential;
  } catch (e) {
    print(e);
    return null;
  }
}

reset(String email) async {
  FirebaseAuth _auth = FirebaseAuth.instance;
  await _auth.sendPasswordResetEmail(email: email);
}

logout(BuildContext context) async {






sucess() async {


      
    
   Navigator.pop(context,true);
  await _auth.signOut();
  Navigator.of(context)
      .push(MaterialPageRoute(builder: (context) => OnboardingPage(cameras: [],)));

}

failure(){


   Navigator.of(context).pop();
     alertbox(context, 'Connection Failed', 'Please Check your Internet Connection', 'images/alerts.gif');
     return null;
}



                      showDialog(context: context, builder: (context){
            
                                          return Center(child: CircularProgressIndicator());
            
                                       });
sucess();

}

class EnterData {
  final String drinkName;
  final String drinkDesc;
  EnterData(this.drinkName, this.drinkDesc);

  final CollectionReference cartCollection =
      FirebaseFirestore.instance.collection(_auth.currentUser!.uid);

  addData() {
    Map<String, String> g = {
      "Drink Name": drinkName,
      "Drink Desc": drinkDesc,
    };

    cartCollection.doc().set(g);
  }
}

class GetData {
  final CollectionReference captures =
      FirebaseFirestore.instance.collection('items');


   getData() async {
 List captureList = [];

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await captures.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    captureList = allData;

    
    return captureList;


  }



}





alertbox(context,text,subtext,path){



  showDialog(
  context: context,builder: (_) => AssetGiffyDialog(
    buttonCancelColor: tone,
    onlyCancelButton: true,
    image: Image(image: AssetImage(path)),
    title: Text(text,
            style: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.w600),
    ),
    description: Text(subtext,
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
    entryAnimation: EntryAnimation.BOTTOM,
    buttonCancelText: Text('OK',style: TextStyle(color: Colors.white)),
  ) );
}







alertboxfun(context,text,subtext,path,Function pik){



  showDialog(
  context: context,builder: (_) => AssetGiffyDialog(
    buttonCancelColor: tone,
    onlyCancelButton: true,
    image: Image(image: AssetImage(path)),
    title: Text(text,
            style: TextStyle(
            fontSize: 22.0, fontWeight: FontWeight.w600),
    ),
    description: Text(subtext,
          textAlign: TextAlign.center,
          style: TextStyle(),
        ),
    entryAnimation: EntryAnimation.BOTTOM,
    buttonCancelText: Text('OK',style: TextStyle(color: Colors.white)),
    onCancelButtonPressed: (){pik();},
  ) );
}


shrink(){



  Row(
      children: [
        const Skeleton(height: 120, width: 120),
        const SizedBox(width: defaultPadding),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Skeleton(width: 80),
              const SizedBox(height: defaultPadding / 2),
              const Skeleton(),
              const SizedBox(height: defaultPadding / 2),
              const Skeleton(),
              const SizedBox(height: defaultPadding / 2),
              Row(
                children: const [
                  Expanded(
                    child: Skeleton(),
                  ),
                  SizedBox(width: defaultPadding),
                  Expanded(
                    child: Skeleton(),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
}



class GetCandidates {
  final CollectionReference captures =
      FirebaseFirestore.instance.collection('candidates');


   getData() async {
 List candidateList = [];

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await captures.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    candidateList = allData;

    
    return candidateList;


  }}


Future<File> get _localFile async {

    String name='';
   await  FirebaseFirestore.instance
.collection('users').doc(_auth.currentUser!.uid)
.get()
.then((value) =>
name=value.data()?["imagename"]);
  var status = await Permission.storage.status;
      if (status.isDenied) {
        // You can request multiple permissions at once.
        Map<Permission, PermissionStatus> statuses = await [
          Permission.storage,
        ].request();
        print(statuses[Permission.storage]); // this must show permission granted. 
      }
  
  return File('/storage/emulated/0/$name');
}


class facehanlder{



  File? jsonFile;
  dynamic _scanResults;
  late CameraController? _camera;
  var interpreter;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.front;
  dynamic data = {};
  double threshold = 1.0;
  late Directory tempDir;
  late List e1;
  List? ex;
  int i=0;
  bool _faceFound = false;

  imglib.Image convertFileToImage(File picture)  {
  List<int> imageBase64 = picture.readAsBytesSync();
  String imageAsString = base64Encode(imageBase64);
  Uint8List uint8list = base64.decode(imageAsString);
  imglib.Image image = imglib.decodeImage(picture.readAsBytesSync())!;
  
  return image;
}
  List? setImage(File SrcImg){
      HandleDetection _getDetectionMethod() {
    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
      ),
    );
    return faceDetector.processImage;
  }

     detectImg(SrcImg, _getDetectionMethod()).then(
          (dynamic result) async {

            Face _face;
            imglib.Image convertedImage =
                convertFileToImage(SrcImg);
            for (_face in result) {
              double x, y, w, h;
              x = (_face.boundingBox.left - 10);
              y = (_face.boundingBox.top - 10);
              w = (_face.boundingBox.width + 10);
              h = (_face.boundingBox.height + 10);
              imglib.Image croppedImagesrc = imglib.copyCrop(
                  convertedImage, x.round(), y.round(), w.round(), h.round());
              croppedImagesrc = imglib.copyResizeCropSquare(croppedImagesrc, 112);
              
              // int endTime = new DateTime.now().millisecondsSinceEpoch;
              // print("Inference took ${endTime - startTime}ms");
               List input = imageToByteListFloat32(croppedImagesrc, 112, 128, 128);
    input = input.reshape([1, 112, 112, 3]);
    List output = List.filled(1 * 192, null, growable: false).reshape([1, 192]);
    interpreter.run(input, output);
    output = output.reshape([192]);
    ex = List.from(output);
    
    
  }});
  
  return ex;
  
  }

Future getStoragePermission() async {
  PermissionStatus status = await Permission.storage.request();
  //PermissionStatus status1 = await Permission.accessMediaLocation.request();
  PermissionStatus status2 = await Permission.manageExternalStorage.request();
  print('status $status   -> $status2');
  if (status.isGranted && status2.isGranted) {
    return true;
  } else if (status.isPermanentlyDenied || status2.isPermanentlyDenied) {
    await openAppSettings();
  } else if (status.isDenied) {
    print('Permission Denied');
  }
}


  
  

  Future<void> handle(String text) async {
  await loadModel();
  tempDir = await getApplicationDocumentsDirectory();
    String _embPath = tempDir.path + '/emb.json';
    jsonFile = new File(_embPath);
    if (jsonFile!.existsSync()) data = json.decode(jsonFile!.readAsStringSync());

     

    File file=await _localFile ;
  String url='';
   await FirebaseFirestore.instance
.collection('users').doc(_auth.currentUser!.uid)
.get()
.then((value) =>
url=value.data()!['imageurl']);
print(url+'yeh hai');
Uri uri = Uri.parse(url);


await getStoragePermission();
var request = await http.get(uri);
      var bytes = await request.bodyBytes;//close();
      await file.writeAsBytes(bytes);
      print(file.path);




    setImage(file);
    
       data['Recognized'] = ex;
    print('Its DONE');
    jsonFile!.writeAsStringSync(json.encode(data));
    

  }

  Future loadModel() async {
    try {
      final gpuDelegateV2 = tfl.GpuDelegateV2(
          options: tfl.GpuDelegateOptionsV2(
        isPrecisionLossAllowed: false,
        inferencePreference: tfl.TfLiteGpuInferenceUsage.fastSingleAnswer,
        inferencePriority1: tfl.TfLiteGpuInferencePriority.minLatency,
        inferencePriority2: tfl.TfLiteGpuInferencePriority.auto,
        inferencePriority3: tfl.TfLiteGpuInferencePriority.auto,
      ));

      var interpreterOptions = tfl.InterpreterOptions()
        ..addDelegate(gpuDelegateV2);
      interpreter = await tfl.Interpreter.fromAsset('mobilefacenet.tflite',
          options: interpreterOptions);
    } on Exception {
      print('Failed to load model.');
    }
  }


}


Future<Map>  getprofData()  async {
 Map prof={};
   await
      FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).get()
    .then((value) {
      

      
            
            
      
       print("value is "+value.data()!['name']);
    
       prof=value.data()!;


       // Access your after your get the data
     });
return prof;

  }


  Future<Position> getLocation() async {

 var position = await GeolocatorPlatform.instance
            .getCurrentPosition();

            return position;



  }


  placeOrder(String adr,String phno,String str,String posx,String posy,String count,) async {

Map s=await getprofData();
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');
       mem=DateTime.now().toString();
       DateTime now=DateTime.now();
       String date=DateTime(now.year, now.month, now.day).toString();
   
    Map<String, dynamic> g = {
        
      "customerAdress": adr,
      "customerName": s['name'],
      "customerPhone":phno,
      "date":date,
      "items":str,
      "latitude":posx,
      "longitude":posy,
      "orderid":s['MemberId'],
      "time":mem,
      "total":count,
      "userid":_auth.currentUser!.uid,
      "watch":'deliver',
      };
    orders.doc(_auth.currentUser!.uid).set(g);




  }