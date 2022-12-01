import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:trashbug/ui/static/loading.dart';
import 'package:trashbug/ui/wrapper.dart';
import 'models/user.dart';
// import 'backend/LocTime.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User>(
      create: (_) => User(),
      child:  MaterialApp(
        title: 'Trash Bug',
        debugShowCheckedModeBanner: false,
        theme:  ThemeData(
          primarySwatch: Colors.blue,
        ),
        // home: Gmap(),
        home: Wrapper(),
        // home: new MapDash(),
      ),
    );
  }
}
