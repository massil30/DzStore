import 'package:dzstore/models/order.dart';
import 'package:dzstore/models/product.dart';

List<Product> getNameByCategory(String pr, List<Product> allProducts) {
  List<Product> users = [];
  try {
    for (var product in allProducts) {
      if (product.category == pr) {
        users.add(product);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return users;
}

List<Product> getNameByOffer(String pr, List<Product> allProducts) {
  List<Product> users = [];
  try {
    for (var product in allProducts) {
      if (product.offer == pr) {
        users.add(product);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return users;
}

List<Order> getOrderByNumber(String number, List<Order> allOrders) {
  List<Order> orders = [];
  try {
    for (var order in allOrders) {
      if (order.number == number) {
        orders.add(order);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return orders;
}

getTotalPrice(List<Product> products) {
  var price = 0;
  for (var product in products) {
    price += product.quantity * int.parse(product.price);
  }
  return price;
}
