import 'package:flutter/cupertino.dart';

class User extends ChangeNotifier {
  /* More attributes will be added or customised. These are just for sake of testing*/
  static String _email = "";
  String get email => _email;

  static String _username = "";
  String get username => _username;

  static String _pass = "";
  String get pass => _pass;

  static String _name = "";
  String get name => _name;

  static String _id = "0";
  String get id => _id;

  List<Map> _datas = [];
  List<Map> get datas => _datas;

  static int _count = 0;
  int get count => _count;

  User(
      {String email,
      String username,
      String pass,
      String name,
      String id,
      List<Map> datas,
      int count}) {
    _email = email;
    _username = username;
    _pass = pass;
    _name = name;
    _id = id;
    _datas = datas;
    _count = count;
  }

  set email(String a) {
    _email = a;
    //notifyListeners();
  }

  set pass(String a) {
    _pass = a;
    //notifyListeners();
  }

  set username(String a) {
    _username = a;
    //notifyListeners();
  }

  set name(String a) {
    _name = a;
    //notifyListeners();
  }

  set id(String a) {
    _id = a;
    //notifyListeners();
  }

  set datas(List<Map> a) {
    _datas = a;
  }

  set count(int a) {
    _count = a;
  }
}
// String email = "";
//   String eemail = "";
//   String username = "";
//   String uusername = "";
//   String ppass = "";
//   String nname = "";
//   String iid = "";
//   List ddatas = <Map>[];
//   int ccount = 0;
//   String pass = "";
//   String name = "";
//   String id = "";
//   List datas = <Map>[];
//   int count = 0;

//   User(
//       {this.email,
//       this.username,
//       this.pass,
//       this.name,
//       this.id,
//       this.datas,
//       this.count}) {
//     eemail = email;
//     ppass = pass;
//     uusername = username;
//     nname = name;
//     iid = id;
//     ddatas = datas;
//     ccount = count;
//   }
