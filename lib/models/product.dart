import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dzstore/addToCart/cartitem.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Product {
  String name;
  String price;
  String image;
  String category;
  var date;
  String offer;

  var quantity;
  var decription;
  Product(
      {this.name,
      this.category,this.date,
      this.image,
      this.price,
      this.offer,
      this.quantity,
      this.decription});
}

void AddToCart(context, Product product) {
  CartItem cartItem = Provider.of<CartItem>(context, listen: false);
  bool existe = false;
  int quantity = 1;
  product.quantity = quantity;
  var productInCart = cartItem.products;
  for (var productInCart in productInCart) {
    if (productInCart.name == product.name &&
        productInCart.offer == product.offer) {
      existe = true;
    }
  }
  if (existe) {
    AwesomeDialog(
        context: context,
        body: Text("Existed Before !"),
        dialogType: DialogType.NO_HEADER)
      ..show();
  } else {
    cartItem.addProduct(product);
    AwesomeDialog(
      autoHide: Duration(seconds: 5),
      context: context,
      headerAnimationLoop: false,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Nice',
      desc: 'Your Product Was Added',
    )..show();
  }
}
