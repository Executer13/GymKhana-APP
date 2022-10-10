import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gallery_saver/files.dart';
import 'package:path_provider/path_provider.dart';
import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'FACE/detector_painters.dart';
import 'FACE/utils.dart';
import 'package:image/image.dart' as imglib;
import 'package:tflite_flutter/tflite_flutter.dart' as tfl;
import 'package:quiver/collection.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'cast_vote.dart';
import 'methods.dart';
import 'navbar.dart';
 final FirebaseAuth _auth = FirebaseAuth.instance;
CameraController? _camera=null;
class MyFacePage extends StatefulWidget {
  final List<CameraDescription> cameras;
  MyFacePage(this.cameras);
  @override
  _MyFacePageState createState() => _MyFacePageState();
}

class _MyFacePageState extends State<MyFacePage> {

  
  late File jsonFile;
  dynamic _scanResults;
 
  var interpreter;
  bool _isDetecting = false;
  CameraLensDirection _direction = CameraLensDirection.front;
  dynamic data = {};
  double threshold = 1.0;
 late Directory tempDir;
  late List e1=[];
  late List ex=[];
  bool _faceFound = false;
  
  final TextEditingController _name = new TextEditingController();
 
bool sigma = true;
bool beta = false;
  @override
  void initState() {
    super.initState();
    
    _camera = CameraController(widget.cameras[0],ResolutionPreset.high);
    
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

          _initializeCamera();


        

   
   
   
  
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

    void _initializeCamera() async {
    await loadModel();
    CameraDescription description = await getCamera(_direction);

    ImageRotation rotation = rotationIntToImageRotation(
      description.sensorOrientation,
    );

    _camera =
        CameraController(description, ResolutionPreset.low, enableAudio: false);
    await _camera!.initialize();
    await Future.delayed(Duration(milliseconds: 500));
    tempDir = await getApplicationDocumentsDirectory();
    String _embPath = tempDir.path + '/emb.json';
    jsonFile = new File(_embPath);
    if (jsonFile!.existsSync()) data = json.decode(jsonFile!.readAsStringSync());

    _camera!.startImageStream((CameraImage image) {
      if (_camera != null) {
        if (_isDetecting) return;
        _isDetecting = true;
        String res;
        dynamic finalResult = Multimap<String, Face>();
        detect(image, _getDetectionMethod(), rotation).then(
          (dynamic result) async {
            if (result.length == 0)
              _faceFound = false;
            else
              _faceFound = true;
            Face _face;
            imglib.Image convertedImage =
                _convertCameraImage(image, _direction);
            for (_face in result) {
              double x, y, w, h;
              x = (_face.boundingBox.left - 10);
              y = (_face.boundingBox.top - 10);
              w = (_face.boundingBox.width + 10);
              h = (_face.boundingBox.height + 10);
              imglib.Image croppedImage = imglib.copyCrop(
                  convertedImage, x.round(), y.round(), w.round(), h.round());
              croppedImage = imglib.copyResizeCropSquare(croppedImage, 112);
              // int startTime = new DateTime.now().millisecondsSinceEpoch;
              res = _recog(croppedImage);
              // int endTime = new DateTime.now().millisecondsSinceEpoch;
              // print("Inference took ${endTime - startTime}ms");
              finalResult.add(res, _face);
            }
            setState(() {
              _scanResults = finalResult;
            });

            _isDetecting = false;
          },
        ).catchError(
          (_) {
            _isDetecting = false;
          },
        );
      }
    });
  }

imglib.Image convertFileToImage(File picture)  {
  List<int> imageBase64 = picture.readAsBytesSync();
  String imageAsString = base64Encode(imageBase64);
  Uint8List uint8list = base64.decode(imageAsString);
  imglib.Image image = imglib.decodeImage(picture.readAsBytesSync())!;
  
  return image;
}

  List? setImage(File SrcImg){
    
     detectImg(SrcImg, _getDetectionMethod()).then(
          (dynamic result) async {
            if (result.length == 0)
              _faceFound = false;
            else
              _faceFound = true;
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

  HandleDetection _getDetectionMethod() {
    final faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
      ),
    );
    return faceDetector.processImage;
  }

  Widget _buildResults() {
    const Text noResultsText = const Text('');
    if (_scanResults == null ||
        _camera == null ||
        !_camera!.value.isInitialized) {
      return noResultsText;
    }
    CustomPainter painter;

    final Size imageSize = Size(
      _camera!.value.previewSize!.height,
      _camera!.value.previewSize!.width,
    );
    painter = FaceDetectorPainter(imageSize, _scanResults);
    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    if (_camera == null || !_camera!.value.isInitialized) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Container(
      constraints: const BoxConstraints.expand(),
      child: _camera == null
          ? const Center(child: null)
          : Stack(
              fit: StackFit.expand,
              children: <Widget>[
                CameraPreview(_camera!),
                _buildResults(),
              ],
            ),
    );
  }

 

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          visible: beta,
          child:CastVote(),
          ),
        Visibility(
          visible: sigma,
          child: Container(
            height: 800,
            child: Scaffold(
             
              body: _buildImage(),
              floatingActionButton:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                FloatingActionButton(
                  backgroundColor: (_faceFound) ? Colors.blue : Colors.blueGrey,
                  child: Icon(Icons.how_to_vote),
                  onPressed: () {
                    if (_faceFound) _addLabel();
                  },
                  heroTag: null,
                ),
                SizedBox(
                  height: 10,
                ),
              
              ]),
            ),
          ),
        ),
      ],
    );
  }

  imglib.Image _convertCameraImage(
      CameraImage image, CameraLensDirection _dir) {
    int width = image.width;
    int height = image.height;
    // imglib -> Image package from https://pub.dartlang.org/packages/image
    var img = imglib.Image(width, height); // Create Image buffer
    const int hexFF = 0xFF000000;
    final int uvyButtonStride = image.planes[1].bytesPerRow;
    final int? uvPixelStride = image.planes[1].bytesPerPixel;
    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride! * (x / 2).floor() + uvyButtonStride * (y / 2).floor();
        final int index = y * width + x;
        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];
        // Calculate pixel color
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        img.data[index] = hexFF | (b << 16) | (g << 8) | r;
      }
    }
    var img1 = (_dir == CameraLensDirection.front)
        ? imglib.copyRotate(img, -90)
        : imglib.copyRotate(img, 90);
    return img1;
  }

  String _recog(imglib.Image img) {
    List input = imageToByteListFloat32(img, 112, 128, 128);
    input = input.reshape([1, 112, 112, 3]);
    List output = List.filled(1 * 192, null, growable: false).reshape([1, 192]);
    interpreter.run(input, output);
    output = output.reshape([192]);
    e1 = List.from(output);
    
    
    return compare(e1).toUpperCase();
    
  }

  String compare(List currEmb) {
    if (data.length == 0) return "No Face saved";
    double minDist = 999;
    double currDist = 0.0;
    String predRes = "NOT RECOGNIZED";
    for (String label in data.keys) {
      currDist = euclideanDistance(data[label], currEmb);
      if (currDist <= threshold && currDist < minDist) {
        minDist = currDist;
        predRes = label;
       
        
         setState(() {
   _camera=null;
      sigma=false;
    beta=true;
});
      }
    }
    print(minDist.toString() + " " + predRes);
   
    return predRes;
  }

  void _resetFile() {
    data = {};
    jsonFile!.deleteSync();
  }

  void _viewLabels() {
    setState(() {
      _camera = null;
    });
    String name;
    var alert = new AlertDialog(
      title: new Text("Saved Faces"),
      content: new ListView.builder(
          padding: new EdgeInsets.all(2),
          itemCount: data.length,
          itemBuilder: (BuildContext context, int index) {
            name = data.keys.elementAt(index);
            return new Column(
              children: <Widget>[
                new ListTile(
                  title: new Text(
                    name,
                    style: new TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                  ),
                ),
                new Padding(
                  padding: EdgeInsets.all(2),
                ),
                new Divider(),
              ],
            );
          }),
      actions: <Widget>[
        new ElevatedButton(
          child: Text("OK"),
          onPressed: () {
            _initializeCamera();
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
  }

  void _addLabel() {
    setState(() {
      _camera = null;
    });
    print("Adding new face");
 
    var alert =  
    
    AlertDialog( content:alertboxfun(context, 'Identify Yourself', 'Kindly Identify Yourself', 'images/recognition.gif',() async {
        
         await _handle('ali');
      _initializeCamera();
            Navigator.pop(context);})
    );

       
    showDialog(
        context: context,
        builder: (context) {
          return alert;
        });
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
  Future<void> _handle(String text) async {
  


      _camera=null;

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


data={};

    ex=setImage(file)!;
    setState(() {
       data['Recognized'] = ex;
    print('Its DONE');
    jsonFile!.writeAsStringSync(json.encode(data));
    });


  }
}
