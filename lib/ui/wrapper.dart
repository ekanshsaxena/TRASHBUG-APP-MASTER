// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trashbug/models/user.dart';
// import 'package:trashbug/services/firebaseservices.dart';
import 'package:trashbug/ui/dashboard.dart';
import 'package:trashbug/ui/login_page.dart';

// import 'static/loading.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user.id == null) {
      return LoginPage();
    } else {
        Provider.of<User>(context).id = user.id;
        Provider.of<User>(context).name = user.name;
        Provider.of<User>(context).count = user.count;
        Provider.of<User>(context).datas = user.datas;
        Provider.of<User>(context).email = user.email;
        return DashboardOnePage();
    }
    // Text("yessss"),
  }
}

    // User user = User();
    // Future loadData() async {
    //   AuthService firebaseService = AuthService();
    //   try {
    //     user = await firebaseService.getCurrentUser();
    //     return true;
    //     // true only denotes that a user has been returned, but doesnt convey the assurance of having data
    //   } catch (e) {
    //     print("exception");
    //     return false;
    //   }
    // }
    // return either home or authenticate widget
    // return FutureBuilder(
    //     future: loadData(),
    //     builder: (context, snapshot) {
    //       if (snapshot.data == null) {
    //         return SplashScreen();
    //       } else {
    //         print(
    //             "yha par chud gya hai::::::::::::::::::::::::        ::::::::::::::::::::::::::: lauda pakad ke nacho ab !!!!!!!!!");
    //         if (user.id == null) print("khali hai!!");
    //         print(user.id);
    //         print(user);
    //         if (user.id != null) {
    //           Provider.of<User>(context).id = user.id;
    //           Provider.of<User>(context).count = user.count;
    //           Provider.of<User>(context).datas = user.datas;
    //           Provider.of<User>(context).email = user.email;
    //           return DashboardOnePage();
    //         } else {
    //           // var doc = Firestore.instance.collection('users').document(user.id);
    //           //return Navigator.push(context, MaterialPageRoute(builder: (context) {
    //           return LoginPage();
    //           //}));
    //         }
    //       }
    //     });