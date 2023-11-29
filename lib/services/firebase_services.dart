import 'package:cloud_firestore/cloud_firestore.dart';

class CollectionRef {
  static CollectionReference path({String? path}) =>
      FirebaseFirestore.instance.collection(path!);
}

class FireStoreServices {
  static Future<dynamic> listGetter(
      {String? path,
      String? doc,
      String? where,
      String? path1,
      String? doc1}) async {
    List<dynamic> list = [];

    if (path!.isNotEmpty) {
      await CollectionRef.path(path: path).get().then((value) {
        for (var x in value.docs) {
          Map<String, dynamic> obj = x.data() as Map<String, dynamic>;
          list.add(obj);
        }
      });
    } else if (doc!.isNotEmpty && path.isNotEmpty) {
      CollectionRef.path(path: path).doc(doc);
    } else {}
    return list;
  }

  static Future<DocumentReference<Object?>> addToCollection(
      {String? path, dynamic data}) async {
    return await CollectionRef.path(path: path).add(data);
  }

  static Future<void> updateToCollection(
      {String? path, dynamic data, String? docId}) async {
    await CollectionRef.path(path: path).doc(docId).update(data);
  }
}
