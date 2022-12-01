import 'dart:async';
import 'dart:typed_data';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:trashbug/models/user.dart';
import 'package:trashbug/ui/dashboard.dart';
import 'package:geolocator/geolocator.dart';

class Scan extends StatefulWidget {
  @override
  _ScanState createState() => _ScanState();
}

//Provider.of<User>(context, listen:false) = user
class _ScanState extends State<Scan> {
  // String _loc = "";
  String _lat = "";
  String _long = "";
  // var _time = "";
  bool _statusOfGarbage = false;

  //--------------------------------------------------

  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  final CollectionReference trashCollection =
      Firestore.instance.collection('location');

  Future savingData(Uint8List img) async {
    final user = Provider.of<User>(context, listen: false);
    print("====================================================>");
    print(user.id);
    print("====================================================>");
    // String fileName = user.id + (user.count + 1).toString();
    // //var storageRef = firebase.storage().ref();

    // StorageReference firebaseStorageRef =
    //     FirebaseStorage.instance.ref().child(fileName);
    // StorageUploadTask uploadTask = firebaseStorageRef.put(img);
    // // ignore: unused_local_variable
    // StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    // // if (taskSnapshot.error == null) {
    // //   return null;
    // // }
    // final String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    user.count = user.count == null ? 1 : user.count + 1;

    Map mp = {
      "image": Blob(img),
      'lat': _lat,
      'long': _long,
      'time': DateTime.now(),
    };
    if (user.datas == null) {
      user.datas = <Map>[];
    }
    user.datas.add(mp);

    try {
      print("try reached");
      print(FieldValue.arrayUnion(user.datas));

      

      await userCollection.document(user.id).setData({
        'name': user.name,
        'Datas': FieldValue.arrayUnion(user.datas),        
        'count': user.count,
      });
      //user.count = user.count + 1;
      //user.datas.add(mp);
      print("data uploaded");
      return userCollection.document(user.id);
    } catch (e) {
      print(e.toString());
      print(e.code);
      return null;
    }
  }

  //---------------------
  _noImage(BuildContext context) {
    return GestureDetector(
        onTap: () {
          _scanImage();
        },
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.camera_alt,
                  size: 50,
                ),
                Text(
                  "Tap to open camera",
                  style: TextStyle(fontSize: 30),
                )
              ]),
        ));
  }

  bool loading = false;
  String result = '';
  File _aadhar;
  bool success = false;
  Uint8List bytedimage;
  Image onDisplay;

  _addData() async {
    var url = "http://165.22.209.211:8080/";
    Dio dio = new Dio();
    String filename1 = _aadhar == null ? " " : _aadhar.path.split('/').last;
    FormData formData = new FormData.fromMap({
      "file": _aadhar == null
          ? ""
          : await MultipartFile.fromFile(_aadhar.path,
              filename: filename1,
              contentType: MediaType('image', "png/jpeg/jpg")),
    });
    final response = await dio.post(url, data: formData);
    if (response.statusCode == 200) {
      // print(response.data);
      setState(() {
        bytedimage = base64Decode(json.decode(response.data)["img"]);
        onDisplay = Image.memory(bytedimage);
        // print(bytedimage.runtimeType);
        // print(onDisplay.runtimeType);
        loading = false;
        _aadhar = null;
        success = true;
        _statusOfGarbage = json.decode(response.data)["statusOfGarbage"];
        if (_statusOfGarbage) {
          result = "Trash Detected";
        } else {
          result = "Trash Not Detected";
        }
      });
      //Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));

    } else {
      // print("fail");
      setState(() {
        bytedimage = null;
        success = false;
        _aadhar = null;
        onDisplay = null;
        loading = false;
        result = "Trash Not Detected";
      });
      // print(response.toString());
    }
  }

  Future _scanImage() async {
    // ignore: deprecated_member_use
    _getCurLoc();
    var img = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _aadhar = img;
      onDisplay = Image.file(_aadhar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("Scan the trash"),
      ),
      body: Column(children: <Widget>[
        Container(
          child: Card(
            child: onDisplay == null ? _noImage(context) : onDisplay,
            color: onDisplay == null ? Colors.white : Colors.black87,
            semanticContainer: true,
            margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
          ),
          margin: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width - 40,
          height: MediaQuery.of(context).size.width - 40,
          decoration: BoxDecoration(
            border: Border.all(width: 5, color: Colors.black),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        RaisedButton(
            child: Container(
              height: 50,
              width: 70,
              child: Center(
                child: loading
                    ? SpinKitFadingCube(
                        size: 20,
                        itemBuilder: (BuildContext context, int index) {
                          return DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.pink,
                            ),
                          );
                        },
                      )
                    : Text(
                        "Scan",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                      ),
              ),
            ),
            color: Color(0xFFfbab66),
            onPressed: () async {
              if (!loading && onDisplay != null && !success) {
                setState(() {
                  loading = true;
                });
                await _addData();
              }
            }),
        Padding(
            padding: const EdgeInsets.all(50),
            child: Text(
              result,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: _statusOfGarbage ? Colors.green : Colors.red),
            )),
      ]),
      floatingActionButton: success
          ? FloatingActionButton.extended(
              onPressed: () async {
                if (_statusOfGarbage) {
                  await savingData(bytedimage);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DashboardOnePage()),
                      (Route<dynamic> route) => false);
                  // _getCurLoc();
                } else {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DashboardOnePage()),
                      (Route<dynamic> route) => false);
                }
              },
              label: _statusOfGarbage ? Text("Continue") : Text("Dashboard"),
              icon: Icon(Icons.forward),
            )
          : null,
    );
  }

  void _getCurLoc() async {
    // var dTime = new DateTime.now();

    // String daytimee = dTime.toString();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _lat = position.latitude.toString();
      _long = position.longitude.toString();
      // _time = dTime;
      // _loc =
      //     "Current Latitude : ${position.latitude}, \n Current Longitude: ${position.longitude} ";
    });
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////FutureBuilder(
  // Future updateRatingtoTutor(String myuid) async {
  //   try {
  //     await userCollection.document(myuid).updateData({
  //       'rated': FieldValue.arrayUnion([id]),
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  //   return true;
  // }
}

/////////////////////////////////////////////////////////////////////////////////////////////////////////////
