import 'dart:io';

import 'package:dzstore/Screen/Home.dart';
import 'package:dzstore/Screen/Home/Myorder.dart';
import 'package:dzstore/Widgets/Loading.dart';
import 'package:dzstore/addToCart/cartitem.dart';
import 'package:dzstore/constant.dart';
import 'package:dzstore/funcation.dart';
import 'package:dzstore/models/product.dart';
import 'package:dzstore/services/productServices.dart';
import "package:flutter/material.dart";
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:dzstore/test.dart';

class AddToCart extends StatefulWidget {
  @override
  _AddToCartState createState() => _AddToCartState();
}

class _AddToCartState extends State<AddToCart> {
  @override
  Widget build(
    BuildContext context,
  ) {
    List<Product> products = Provider.of<CartItem>(context).products;

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Text(
            "My Cart",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (products.length == 0) {
              return Center(
                child: Text(
                  "Empty Cart",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                ),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height / 1.4,
                      child: ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.grey[850],
                                borderRadius: BorderRadius.circular(10)),
                            height: MediaQuery.of(context).size.height / 6,
                            width: double.infinity,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 7,
                                ),
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.red[900],
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      '${products[index].offer} ${products[index].name}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.9),
                                    ),
                                    Row(
                                      children: [
                                        Text("Quantity:",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (products[index].quantity >
                                                  1) {
                                                products[index].quantity--;
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Icon(
                                                Icons.remove,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                            products[index].quantity.toString(),
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20)),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              if (products[index].quantity ==
                                                  30) {
                                                return null;
                                              } else {
                                                products[index].quantity++;
                                              }
                                            });
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Icon(
                                                Icons.add,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Price: ${products[index].quantity * int.parse(products[index].price)} DA",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w900),
                                    )
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Provider.of<CartItem>(context,
                                            listen: false)
                                        .deletep(products[index]);
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(10),
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.grey[850], Colors.black])),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).size.height / 1.4 -
                          Scaffold.of(context).appBarMaxHeight,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Total Price: ${getTotalPrice(products)} DA',
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () async {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Oks(
                                    priceTotal: getTotalPrice(products),
                                    products: products,
                                  );
                                },
                              ));
                            },
                            child: Container(
                                alignment: Alignment.bottomCenter,
                                width: double.infinity,
                                height: 50,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10))),
                                child: Center(
                                  child: Text(
                                    "NEXT",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            }
          },
        ));
  }
}
