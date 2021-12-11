import 'package:cloud_firestore/cloud_firestore.dart';

class Database {
  FirebaseFirestore? firestore;
  initiliase() {
    firestore = FirebaseFirestore.instance;
  }

  Future<void> create(String name, String price) async {
    try {
      await firestore!.collection("products").add({
        'name': name,
        'price': price,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> delete(String id) async {
    try {
      await firestore!.collection("products").doc(id).delete();
    } catch (e) {
      print(e);
    }
  }

  Future<List?> read() async {
    QuerySnapshot querySnapshot;
    List docs = [];
    try {
      querySnapshot =
          await firestore!.collection('products').orderBy('name').get();
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs.toList()) {
          Map a = {"id": doc.id, "name": doc['name'], "price": doc["price"]};
          docs.add(a);
        }
        return docs;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> update(String id, String name, String price) async {
    try {
      await firestore!
          .collection("products")
          .doc(id)
          .update({'name': name, 'price': price});
    } catch (e) {
      print(e);
    }
  }
}
