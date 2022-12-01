// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:trashbug/models/user.dart';
import 'package:trashbug/utils/constants/values.dart';

import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  String authUrl = baseApiUrl;

  var _auth;
  Future login(String email, String password) async {

    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      // if (user.isEmailVerified) {
      //   print("verified");
      // return _userfromfirebaseuser(user);
      // }
      // return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signUp(String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      //print("user created");
      // try {
      //   await user.sendEmailVerification();
      //   //print("mail send successfully");
      // } catch (e) {
      //   print("An error occured while trying to send email verification");
      //   print(e.message);
      //   return null;
      // }
      //create a new document for the user with the uid
      // await DatabaseService(uid: user.uid)
      //     .updateUserData('Unknown', 'student', 'Gorakhpur');
      // return _userfromfirebaseuser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
    //___________________________________________________________________________________________
    // Map data = {
    //   'username': email,
    //   'password': pass,
    //   'email': "",
    //   'first_name': name,
    //   'last_name': ""
    // };
    // var jsonResponse;
    // final response = await http.post(
    //     Uri.encodeFull(authUrl + "account/api/register/"),
    //     body: json.encode(data),
    //     headers: {"Content-Type": "application/json"});
    // print("response sent");
    // print(response.statusCode);
    // if (response.statusCode == 200) {
    //   jsonResponse = jsonDecode(response.body);
    // } else if (response.statusCode == 400 ||
    //     response.statusCode == 401 ||
    //     response.statusCode == 402)
    //   throw Exception(jsonDecode(response.body)['detail']);
    // if (jsonResponse != null &&
    //     jsonResponse['refresh'] != null &&
    //     jsonResponse['access'] != null) {
    //   User user = User(email: email, pass: pass);
    //   return true;
    // } else {
    //   throw Exception("Some error occurred");
    // }

    // ignore: unused_local_variable

    // final user = (await _auth.createUserWithEmailAndPassword(
    //   email: email,
    //   password: pass,
    // ))
    //     .user;
    // if (user != null) {
    //   return true;
    // } else {
    //   return false;
    // }
  }
}
