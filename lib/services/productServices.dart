import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dzstore/constant.dart';
import 'package:dzstore/models/product.dart';

class ProductServices {
  var firestore = FirebaseFirestore.instance;
  addProduct(Product product) {
    firestore.collection(cProduct).add({
      pName: product.name,
      pPrice: product.price,
      pCategory: product.category,
      pImage: product.image
    });
  }

  loadProduct() {
    return firestore.collection("Product").snapshots();
  }

  Stream<QuerySnapshot> loadOrderDetails(documentId) {
    return firestore
        .collection("Orders")
        .doc(documentId)
        .collection("OrderD")
        .snapshots();
  }

  loadOrders() {
    return firestore.collection("Orders").snapshots();
  }

  storeOrders(data, List<Product> products) {
    var documentRef = firestore.collection("Orders").doc();
    documentRef.set(data);
    for (var product in products) {
      documentRef.collection("OrderD").doc().set({
        pName: product.name,
        pPrice: product.price,
        "Date":product.date,
        pQuantity: product.quantity,
        pOffer: product.offer
      });
    }
  }
}
