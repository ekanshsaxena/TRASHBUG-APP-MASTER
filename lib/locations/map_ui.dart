// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:latlong/latlong.dart';
// // import 'package:geolocation/geolocation.dart';

// class MapDash extends StatefulWidget {
//   @override
//   _MapDashState createState() => _MapDashState();
// }

// class _MapDashState extends State<MapDash> {
//   var _lat = 0.0, _long = 0.0;

//   getCurLoc() async {
//     final position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high);
//     print('the positionnnnnnnnnnnnnnnnnnnnnnn isssssssssssss $position');

//     setState(() {
//       _lat = position.latitude;
//       _long = position.longitude;
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//     getCurLoc();
//   }

//   MapController controller = new MapController();

//   // getPermission() async {
//   //   final GeolocationResult result =
//   //       await Geolocation.requestLocationPermission(
//   //     permission: const LocationPermission(
//   //       android: LocationPermissionAndroid.fine,
//   //       ios: LocationPermissionIOS.whenInUse,
//   //     ),
//   //     openSettingsIfDenied: true,
//   //   );

//   //   if (result.isSuccessful) {
//   //     return result;
//   //     // location permission is granted (or was already granted before making the request)
//   //   } else {
//   //     Navigator.pop(context);
//   //     // location permission is not granted
//   //     // user might have denied, but it's also possible that location service is not enabled, restricted, and user never saw the permission request dialog. Check the result.error.type for details.
//   //   }
//   // }

//   // var coords;
//   // getLoc() {
//   //   return getPermission().then((result) async {
//   //     if (result.isSuccessful) {
//   //       var coor = await Geolocation.currentLocation(accuracy: LocationAccuracy.best );
//   //       setState(() {
//   //         coords = coor;
//   //       });
//   //     }
//   //     return coords;
//   //   });
//   // }

//   // buildMap() {
//   //   getLoc().then((response) {
//   //     if (response.isSuccessful) {
//   //       controller.move(
//   //           new LatLng(response.location.latitude, response.location.longitude),
//   //           15.0);
//   //       // print('${coords.location.latitude}, ${coords.location.longitude}');
//   //     }
//   //   });
//   // }

//   List<Marker> allMarkers = [];
//   // setMarkers() {
//   //   setState(() {
//   //     allMarkers.add(
//   //       new Marker(
//   //         width: 45.0,
//   //         height: 45.0,
//   //         point: new LatLng(25.3419033, 82.4785833),
//   //         builder: (context) => new Container(
//   //           child: IconButton(
//   //             icon: Icon(Icons.location_on),
//   //             color: Colors.red,
//   //             iconSize: 45.0,
//   //             onPressed: () {
//   //               print("Marker Tapped");
//   //             },
//   //           ),
//   //         ),
//   //       ),
//   //     );
//   //   });
//   //   return allMarkers;
//   // }

//   Widget loadMap() {
//     return StreamBuilder<QuerySnapshot>(
      
//         stream: Firestore.instance.collection('user').snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Text("Loading!!!");
//           }
//           //   return FlutterMap(
//           //   mapController: controller,
//           //   options: new MapOptions(
//           //     // center: buildMap(),
//           //     center: LatLng(_lat, _long),
//           //     minZoom: 15.0,
//           //   ),
//           //   layers: [
//           //     new TileLayerOptions(
//           //         urlTemplate:
//           //             "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//           //         subdomains: ['a', 'b', 'c']),
//           //     new MarkerLayerOptions(
//           //       markers: allMarkers,
//           //     ),
//           //   ],
//           // );
//           //   // return new Text("Loading!!!");
//           // }
//           int countOfMarker = 0;

//           for (int i = 0; i < snapshot.data.documents.length; i++) {
//             if (snapshot.data.documents[i]['Datas'] == null) continue;
//             if (snapshot.data.documents[i] == null) continue;

//             for (int j = 0;
//                 j < snapshot.data.documents[i]['Datas'].length;
//                 j++) {
//               countOfMarker++;
//               allMarkers.add(
//                 Marker(
//                   width: 25.0,
//                   height: 25.0,
//                   point: new LatLng(
//                       double.parse(
//                           snapshot.data.documents[i]['Datas'][j]['lat']),
//                       double.parse(
//                           snapshot.data.documents[i]['Datas'][j]['long'])),
//                   builder: (context) => new Container(
//                     child: IconButton(
//                       icon: Icon(Icons.location_on),
//                       color: Colors.blue,
//                       iconSize: 45.0,
//                       onPressed: () {
//                         print("Marker Tapped");
//                       },
//                     ),
//                   ),
//                 ),
//               );
//             }
//           }
//           print("countOfMarker $countOfMarker");
//           return new FlutterMap(
//             mapController: controller,
//             options: new MapOptions(
//               // center: buildMap(),
//               center: LatLng(_lat, _long),
//               minZoom: 15.0,
//             ),
//             layers: [
//               new TileLayerOptions(
//                   urlTemplate:
//                       "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                   subdomains: ['a', 'b', 'c']),
//               new MarkerLayerOptions(
//                 markers: allMarkers,
//               ),
//             ],
//           );

//           // await Future.delayed(const Duration(milliseconds: 500);
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         backgroundColor: Colors.pinkAccent,
//         title: Text('Marked Map'),
//       ),
//       body: loadMap(),
//     );
//   }
// }
