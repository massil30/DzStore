import 'package:dzstore/models/product.dart';
import 'package:flutter/material.dart';

class CartItem extends ChangeNotifier {
  List<Product> products = [];
  addProduct(Product product) {
    products.add(product);
    notifyListeners();
  }

  deletep(Product product) {
    products.remove(product);
    notifyListeners();
  }

  clearAll() {
    products.clear();
    notifyListeners();
  }
}
