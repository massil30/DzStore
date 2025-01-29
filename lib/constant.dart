import 'package:flutter/material.dart';

final List<String> titles = [
  "",
  "",
  "",
];

final List<Widget> musics = [
  Container(
    width: double.infinity,
    decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            "images/dezzer.png",
          ),
        ),
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(20)),
  ),
  Container(
    width: double.infinity,
    decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            "images/anghami.png",
          ),
        ),
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(20)),
  ),
  Container(
    width: double.infinity,
    decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQW4tupAVnrL2zBy-uozePnoKQGU4wq_1P5iw&usqp=CAU",
          ),
        ),
        color: Colors.grey[600],
        borderRadius: BorderRadius.circular(20)),
  ),
];

//User
const pNumber = "phone Number";
const pPassword = "password";

//Cellections
var cProduct = "Product";

//Product
var pDesciption = "Description";
var pName = "Name";
var pPrice = "Price";
var pQuantity = "Quantity";
var pImage = "Image";
var pCategory = "Category";
var pOffer = "Offer";

//Orders
var note = "Note";
var numberO = "Number";
var payment = "Payment";
var totalPrice = "Totalprice";
var situation = "Situiation";
var imagePicker = "ImagePicker";
