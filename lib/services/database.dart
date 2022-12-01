import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trashbug/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection Reference
  final CollectionReference userCollection =
      Firestore.instance.collection('user');

  Future updateUserData(String name, List<Map> datas, int count) async {
    return await userCollection.document(uid).setData({
      'name': name,
      'datas': [],
      // 'id':id,
      'count': 0,
    });
  }

  // Future updateGoogleUserData(
  //     String name, String occupation, String city) async {
  //   return await userCollection.document(uid).setData({}, merge: true);
  //   // userCollection.document(uid).get().then((doc) async {
  //   //   if (doc.exists) {
  //   //     print("doc exists!");
  //   //     return userCollection.document(uid);
  //   //   } else {
  //   //     print("User creation started");
  //   //     await userCollection.document(uid).setData({
  //   //       'name': name,
  //   //       'occupation': occupation,
  //   //       'city': city,
  //   //       'flag': 0,
  //   //       'fav': [],
  //   //       'req': [],
  //   //       'admin_approval': 0,
  //   //     });
  //   //     print("User created");
  //   //     return userCollection.document(uid);
  //   //   }
  //   // });
  // }

//user list from snapshot
  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
        id: doc.documentID,
        name: doc.data['name'] ?? "",
        datas: doc.data['datas'] ?? [],
        count: doc.data['count'] ?? 0,
      );
    }).toList();
  }

//get users stream
  Stream<List<User>> get users {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }
}
