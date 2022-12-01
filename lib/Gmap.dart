import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'src/locations.dart' as locations;

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  final Map<String, Marker> _markers = {};
  //Map<double, double> locationss = {};
  List<double> latt = List<double>();
  // ignore: deprecated_member_use
  List<double> longg = List<double>();
  // final CollectionReference userCollection =Firestore.instance.collection('users');

  Future<void> _onMapCreated(GoogleMapController controller) async {
    //Firestore.instance.collection('users').getDocuments();
    // Firestore.instance.collection('user').get().then((QuerySnapshot querySnapshot) => {
    //     querySnapshot.docs.forEach((doc) {
    //         print(doc["first_name"]);
    //     });
    // });

    // StreamBuilder<QuerySnapshot>(
    //     stream: Firestore.instance.collection('user').snapshots(),

    //     // ignore: missing_return
    //     builder: (context, snapshot) {
    //       if (!snapshot.hasData) {
    //         return Text('Loading!!!');
    //       }
    //       var countOfMarker = 0;

    //       for (var i = 0; i < snapshot.data.documents.length; i++) {
    //         if (snapshot.data.documents[i]['Datas'] == null) continue;

    //         for (var j = 0;
    //             j < snapshot.data.documents[i]['Datas'].length;
    //             j++) {
    //           countOfMarker++;
    //           locationss[double.parse(
    //                   snapshot.data.documents[i]['Datas'][j]['lat'])] =
    //               double.parse(snapshot.data.documents[i]['Datas'][j]['long']);
    //         }
    //       }
    //       // final marker = Marker(
    //       //   markerId:
    //       //       MarkerId('${snapshot.data.documents[i]['names']} $j'),
    //       //   position: LatLng(
    //       //       double.parse(
    //       //           snapshot.data.documents[i]['Datas'][j]['lat']),
    //       //       double.parse(
    //       //           snapshot.data.documents[i]['Datas'][j]['long'])),
    //       //   // infoWindow: InfoWindow(
    //       //   //   title: office.name,
    //       //   //   snippet: office.address,
    //       //   // ),
    //       // );
    //       // _markers['${snapshot.data.documents[i]['names']} $j'] = marker;
    //       //   }
    //       // }
    //       // });
    //       print('\n\n\n yessssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss $countOfMarker jai mata diiiiiiiiiiiiiiiiiii\n\n\n\n');
    //     });

    final googleOffices = await locations.getGoogleOffices();
    print(googleOffices.runtimeType);

    // print(locationss);

    setState(() {
      _markers.clear();
      print(latt.length);
      print("***********************************************************");
      if (latt.length != longg.length) {
        print(" There is some error");
      } else {
        for (var i = 0; i < latt.length; i++) {
          // ignore: omit_local_variable_types
          String ss = '$i  - Trash';

          // print('$key                  $value');
          final marker = Marker(
            markerId: MarkerId(ss),
            position: LatLng(latt[i], longg[i]),
            infoWindow: InfoWindow(
              title: 'Trash Found Here !',
              snippet: ' ',
            ),
          );

          _markers[ss] = marker;
        }
      }

      // for (final office in googleOffices.offices) {
      //   // print(office.name);
      //   final marker = Marker(
      //     markerId: MarkerId(office.name),
      //     position: LatLng(office.lat, office.lng),
      //     infoWindow: InfoWindow(
      //       title: office.name,
      //       snippet: office.address,
      //     ),
      //   );
      //   _markers[office.name] = marker;
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Marked Locations'),
          backgroundColor: Colors.green[700],
        ),
        body: buildLocations(context)

        // GoogleMap(
        //   onMapCreated: _onMapCreated,
        //   initialCameraPosition: CameraPosition(
        //     target: const LatLng(0, 0),
        //     zoom: 2,
        //   ),
        //   markers: _markers.values.toSet(),
        // ),

        );
  }

  Widget buildLocations(BuildContext context) {
    // CollectionReference users = FirebaseFirestore.instance.collection('user');
    // ignore: omit_local_variable_types
    CollectionReference users = Firestore.instance.collection('user');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        // if (snapshot.hasError) {
        //   return Text('Something went wrong');
        // }

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Text('Loading');
        // }
        if (!snapshot.hasData) {
          return Text("Loading!!!");
        }
        var countOfMarker = 0;

        for (var i = 0; i < snapshot.data.documents.length; i++) {
          if (snapshot.data.documents[i]['Datas'] == null) continue;

          for (var j = 0; j < snapshot.data.documents[i]['Datas'].length; j++) {
            countOfMarker++;
            // Map<double, double> loccc;
            latt.add(
                double.parse(snapshot.data.documents[i]['Datas'][j]['lat']));
            longg.add(
                double.parse(snapshot.data.documents[i]['Datas'][j]['long']));

            // loccc[] =
            //     double.parse(snapshot.data.documents[i]['Datas'][j]['long']);
            // locationss.add(loccc);
          }
        }
        print(latt);
        print(longg);
        // print(
        //     '\n\n\n yessssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss $countOfMarker jai mata diiiiiiiiiiiiiiiiiii\n\n\n\n');
        // print(
        //     '\n\n\n yessssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss $countOfMarker jai mata diiiiiiiiiiiiiiiiiii\n\n\n\n');
        print(
            '\n\n\n yessssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss $countOfMarker jai mata diiiiiiiiiiiiiiiiiii\n\n\n\n');

        // print(countOfMarker);
        return GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: const LatLng(0, 0),
            zoom: 1,
          ),
          markers: _markers.values.toSet(),
        );
      },
    );
  }
}
