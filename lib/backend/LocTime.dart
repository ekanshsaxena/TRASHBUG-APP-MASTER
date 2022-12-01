import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocTime extends StatefulWidget {
  @override
  _LocTimeState createState() => _LocTimeState();
}

class _LocTimeState extends State<LocTime> {
  String _loc =  ' ';
  // String _lat =  ' ';
  // String _long =  ' ';
  // String _time =  ' ';

  void _getCurLoc() async {
    var dTime =    DateTime.now();

    var daytimee = dTime.toString();
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position);

    _loc = 'Current Latitude : ${position.latitude}, \n Current Longitude: ${position.longitude} $daytimee ';
    setState(() {
      // _lat = position.latitude.toString();
      // _long = position.longitude.toString();
      // _time = daytimee.toString();
      _loc =
           'Current Latitude : ${position.latitude}, \n Current Longitude: ${position.longitude} $daytimee ';
    });
  }

  @override
  Widget build(BuildContext context) {
    _getCurLoc();

    return Container(
      color: Colors.blue,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Text( 'Current location is : $_loc ')),
      ),
    );
  }
}
