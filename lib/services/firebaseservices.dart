import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
import 'package:trashbug/models/user.dart';
import 'package:trashbug/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference userCollection =
      Firestore.instance.collection('user');
  //final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  //create user obj based on firebase user
  _userfromfirebaseuser(FirebaseUser user) async {
    //return user != null ? User(id: user.uid) : null;
    User _user = User(datas: []);
    if (user != null) {
      try {
        await userCollection.document(user.uid).get().then((value) {
          _user.name = value.data["name"];
          _user.id = user.uid;
          _user.email = user.email;
          _user.count = value.data["count"];
          var datas = value.data["Datas"];
          for (Map i in datas) {
            _user.datas.add(i);
          }
        });
        return _user;
      } catch (e) {
        print(e.toString());
        return e;
      }
    }
  }

  getCurrentUser() async {
    try {
      User user = User();
      user = await _userfromfirebaseuser(await _auth.currentUser());
      return user != null ? user : User();
    } catch (e) {
      print(e);
    }
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        //.map((FirebaseUser user) => _userfromfirebaseuser(user));
        .map(_userfromfirebaseuser);
  }

  //sign in with email & password
  Future login(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // print("result is $result");
      FirebaseUser user = result.user;
      _userfromfirebaseuser(user);
      // return "success";
      return _userfromfirebaseuser(user);
    } catch (e) {
      // print("NOT found");
      return e;
    }

    // if (user.isEmailVerified) {v
    //   return _userfromfirebaseuser(user);
    // }
    // return null;
  }

  //register with email & password
  Future signUp(String email, String password, String name) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // print("\n\n\n\n");
      // print("User id is ");
      // print("\n\n\n\n");
      FirebaseUser user = result.user;
      await DatabaseService(uid: user.uid).updateUserData(name, [], 0);
      // print("\n\n\n\n");
      // print("User id is $user");
      // print("\n\n\n\n");
      return _userfromfirebaseuser(user);
    } catch (e) {
      return e;
      // showInSnackBar(e.toString());
    }

    //print("user created");
    // try {
    //   await user.sendEmailVerification();
    //   //print("mail send successfully");
    // } catch (e) {
    //   print("An error occured while trying to send email verification");
    //   print(e.message);
    //   return null;
    // }
    // create a new document for the user with the uid
  }

  //sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //password reset
  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return null;
    }
  }

//   Future signInWithGoogle() async{
//     try{

//       GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
//       GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
//       AuthCredential credential = GoogleAuthProvider.getCredential(idToken: googleSignInAuthentication.idToken, accessToken: googleSignInAuthentication.accessToken);
//       print(" accessToken="+googleSignInAuthentication.accessToken);

//       AuthResult result = await _auth.signInWithCredential(credential);
//       FirebaseUser user = result.user;

//       await DatabaseService(uid: user.uid).updateGoogleUserData('Unknown', 'student', 'Gorakhpur');

//       return _userfromfirebaseuser(user);

//     }
//     catch(e){
//       print(e.code);
//     }
//   }

//   Future<void> googleSignOut() async{
//     await _auth.signOut().then((onValue){
//       _googleSignIn.signOut();
//     });
//   }
}
