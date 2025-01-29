import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dzstore/constant.dart';
import 'package:dzstore/models/user.dart';

class UserData {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  addUser(UserM user) {
    firestore
        .collection("Users")
        .add({pPassword: user.password, pNumber: user.number});
  }

  Stream<QuerySnapshot> loadDataUsers() {
    return firestore.collection("Users").snapshots();
  }

  Future<bool> loadnumbers(phone) async {
    var result = await firestore
        .collection("Users")
        .where(
          pNumber,
          isEqualTo: phone,
        )
        .get();
    return result.docs.isEmpty;
  }
}
