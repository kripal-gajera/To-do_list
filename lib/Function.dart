import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do/screens/Homepage.dart';
import 'package:to_do/screens/add_note.dart';
import 'package:to_do/screens/update_note.dart';

CollectionReference firestore = FirebaseFirestore.instance.collection("task");

class FirebaseDatabaseClass {
  static Future<void> addData({String? data, bool? complete = false}) async {
    DocumentReference documentReference = firestore.doc();
    Map<String, dynamic> data = {"data": controller.text, "complete": complete};

    await documentReference
        .set(data)
        .whenComplete(() => print("item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> upedetdata(
      {String? data, required String id, bool? complete = false}) async {
    DocumentReference document = firestore.doc(id);
    Map<String, dynamic> data = {
      "data": controller1.text,
      "complete": complete
    };
    await document.update(data);
  }

  static Future<void> updateStatus({
    required bool status,
    required String id,
  }) async {
    DocumentReference documentReference = firestore.doc(id);
    Map<String, dynamic> data = <String, dynamic>{
      "complete": status,
    };

    await documentReference
        .update(data)
        .whenComplete(() => print("item updated in the database"))
        .catchError((e) => print(e));
  }

  static Future<void> deleteData({
    required String id,
  }) async {
    DocumentReference documentReference = firestore.doc(id);
    await documentReference
        .delete()
        .whenComplete(() => print('item deleted from the database'))
        .catchError((e) => print(e));
  }
}
