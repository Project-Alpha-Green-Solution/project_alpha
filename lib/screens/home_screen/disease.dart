import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projectalpha/mongo_schema/schema.dart';
import 'package:sizer/sizer.dart';
import '../../constants.dart';
import '../../mongodb.dart';
import '../../send_email.dart';
import '../auth_screens/utils.dart';
import '../pdf/pdf_gen.dart';
import 'cure.dart';
import 'package:tflite/tflite.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:firebase_auth/firebase_auth.dart';

final user = FirebaseAuth.instance.currentUser!;

class Disease extends StatefulWidget {
  const Disease({super.key});

  @override
  State<Disease> createState() => _DiseaseState();
}

class _DiseaseState extends State<Disease> {
  File? _image;
  // List? _recognitions;
  List<dynamic>? _recognitions;
  String diseaseName = "";
  bool _busy = false;

  Future _showDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Select an option "),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Pick image from gallery "),
                    onTap: () {
                      predictImagePickerGallery(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  GestureDetector(
                    child: Text("Take a picture "),
                    onTap: () {
                      predictImagePickerCamera(context);
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  GestureDetector(
                    child: Text("Generate PDF Report"),
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      bool result = await makeReport(
                        plant: cropName,
                        disease: plantDisease,
                        remedy: remedy,
                      );
                      setState(() {
                        isLoading = false;
                      });
                      print(result);

                      Utils.successSnackBar(
                          'THE CROP ANALYSIS REPORT HAS BEEN GENERATED AND SAVED TO DOWNLOADS');
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  GestureDetector(
                    child: Text("Send Alert"),
                    onTap: () async {
                      await sendEmail(plantDisease, cropName, remedy);
                      Navigator.pop(context);
                      Utils.successSnackBar(
                          'THE ALERT HAS BEEN SENT TO EVERYONE');
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  var imagePicker = ImagePicker();

  Future<void> predictImagePickerGallery(BuildContext context) async {
    var image = await imagePicker.pickImage(source: ImageSource.gallery);
    if (image == null) return;
    setState(() {
      _busy = true;
      // _image = image;
      _image = File(image.path);
    });
    Navigator.of(context).pop();
    recognizeImage(image);
  }

  Future<void> predictImagePickerCamera(BuildContext context) async {
    var image = await imagePicker.pickImage(source: ImageSource.camera);
    if (image == null) return;
    setState(() {
      _busy = true;
      // _image = image;
      _image = File(image.path);
    });
    Navigator.of(context).pop();
    recognizeImage(image);
  }

  final plantName = {
    "Healthy_Tomato": "Tomato",
    "Tomato_Late_Blight": "Tomato",
    "Tomato_mosaic_virus": "Tomato",
    "Healthy_Bell_Pepper": "Pepper",
    "Bell_Pepper_Bacterial_spot": "Pepper",
    "Healthy_Maize": "Maize",
    "Maize_Cercospora_leaf_spot_and_Gray_leaf_spot": "Maize",
    "Maize_common_rust": "Maize"
  };

  final disease = {
    "Healthy_Tomato": "This tomato leaf/plant is healthy.",
    "Tomato_Late_Blight":
        "Tomato Late Blight is a devastating fungal disease that causes water-soaked lesions on leaves, stems, and fruits. It thrives in cool, moist conditions. Fungicides can help control the disease, but prevention through crop rotation, good airflow, and resistant tomato varieties is crucial. Fungicides containing active ingredients like chlorothalonil, mancozeb, or metalaxyl are commonly used to manage late blight in tomatoes.",
    "Tomato_mosaic_virus":
        "Tomato Mosaic Virus causes mottled leaves, stunted growth, and distorted fruits. There is no cure for this viral disease, so prevention is key. It involves using virus-free seeds, practicing strict sanitation, and controlling aphids, which can transmit the virus. There is no specific fungicide treatment for viral diseases like tomato mosaic virus. Prevention through the use of virus-free seeds, strict sanitation practices, and controlling the vectors, such as aphids, is crucial.",
    "Healthy_Bell_Pepper": "This pepper leaf/plant is healthy",
    "Bell_Pepper_Bacterial_spot":
        "Bell Pepper Bacterial Spot causes dark, raised spots on leaves and fruits. Infected fruits may also develop lesions. Copper-based sprays can be used to control the disease. Preventative measures include planting disease-resistant varieties, practicing crop rotation, and avoiding overhead watering. ",
    "Healthy_Maize": "This maize leaf/plant is healthy",
    "Maize_Cercospora_leaf_spot_and_Gray_leaf_spot":
        "Maize Cercospora Leaf Spot and Gray Leaf Spot are fungal diseases that cause circular lesions on maize leaves, which turn brown or gray. Fungicides can be used to manage the diseases, and cultural practices like crop rotation and residue management help prevent their occurrence. Fungicides containing active ingredients such as azoxystrobin, pyraclostrobin, or propiconazole can help manage cercospora leaf spot and gray leaf spot in maize.",
    "Maize_common_rust":
        "Maize Common Rust is a fungal disease characterized by orange or rust-colored pustules on leaves. Fungicides can be applied to control the disease. Planting resistant varieties and practicing crop rotation can help prevent the disease. Fungicides like triazoles (e.g., tebuconazole) or strobilurins (e.g., azoxystrobin) are commonly used to control common rust in maize."
  };

  @override
  void initState() {
    super.initState();

    _busy = true;

    loadModel().then((val) {
      setState(() {
        _busy = false;
      });
    });
  }

  Future loadModel() async {
    try {
      await Tflite.loadModel(
        model: "assets/model_unquant.tflite",
        labels: "assets/labels.txt",
      );
    } on PlatformException {
      print('Failed to load model.');
    }
  }

  Future<void> recognizeImage(XFile image) async {
    var recognitions = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 6,
      threshold: 0.05,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    setState(() {
      _busy = false;
      _recognitions = recognitions;
    });
  }

  handleCure() {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Cure(diseaseName),
    ));
  }

  var isLoading = false;
  var plantDisease;
  var remedy;
  var cropName;

  Future _showDialog2(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Choose an option"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  GestureDetector(
                    child: Text("Generate PDF Report"),
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      bool result = await makeReport(
                        plant: cropName,
                        disease: plantDisease,
                        remedy: remedy,
                      );
                      setState(() {
                        isLoading = false;
                      });
                      print(result);

                      Utils.successSnackBar(
                          'THE CROP ANALYSIS REPORT HAS BEEN GENERATED AND SAVED TO DOWNLOADS');
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  GestureDetector(
                    child: Text("Send Alert"),
                    onTap: () async {
                      await sendEmail(plantDisease, cropName, remedy);
                      Utils.successSnackBar(
                          'THE ALERT HAS BEEN SENT TO EVERYONE');
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> insertDiseaseData(
      var diseaseName, var plantName, var diseaseSolution) async {
    var _id = M.ObjectId();
    var timestamp = DateTime.now();
    final data = PlantDisease(
        id: _id,
        name: diseaseName,
        plant: plantName,
        solution: diseaseSolution,
        user: user.email!,
        timestamp: timestamp
        );

    var result = await MongoDatabase.insertDiseaseData(data);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<Widget> stackChildren = [];

    stackChildren.add(Positioned(
      top: 0.0,
      left: 0.0,
      width: size.width,
      child: _image == null
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No image selected,\nUpload by clicking on the button at the bottom right corner!',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            )
          : GestureDetector(
              onTap: () {
                _showDialog2;
                print("Tap event detected");
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.file(
                  _image!,
                  height: MediaQuery.of(context).size.height / 2.5,
                  width: MediaQuery.of(context).size.width - 50,
                  fit: BoxFit.cover,
                ),
              ),
            ),
    ));

    stackChildren.add(Positioned(
      width: size.width,
      left: 0,
      top: MediaQuery.of(context).size.height / 2.3,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: _recognitions?.map((res) {
                diseaseName = res['label'] as String; // Added type cast
                plantDisease = diseaseName;
                remedy = disease[diseaseName];
                cropName = plantName[diseaseName];
                insertDiseaseData(plantDisease, cropName, remedy);
                return Text(
                  "${res["label"]}",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList() ??
              [],
        ),
      ),
    ));

    if (_image != null && _recognitions != null) {
      // Added null check for _recognitions
      stackChildren.add(
        Positioned(
          left: 0,
          width: size.width,
          top: MediaQuery.of(context).size.height / 1.90,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Solution: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                SizedBox(height: 5),
                Text(disease[diseaseName] ??
                    ""), // Added null check for disease[diseaseName]
              ],
            ),
          ),
        ),
      );
    }
    if (_busy) {
      stackChildren.add(const Opacity(
        child: ModalBarrier(dismissible: false, color: Colors.grey),
        opacity: 0.3,
      ));
      stackChildren.add(const Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: lightbg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        title: Text(
          'Plant Disease Detection',
          style: TextStyle(fontSize: 17.sp, color: themeColor),
        ),
      ),
      body: Center(
        child: Stack(
          children: stackChildren,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: themeColor,
        onPressed: () {
          _showDialog(context);
        },
        tooltip: 'Pick Image',
        child: Icon(Icons.camera),
      ),
    );
  }
}
