import 'package:dzstore/Screen/details.dart';
import 'package:dzstore/constant.dart';
import 'package:dzstore/funcation.dart';
import 'package:dzstore/models/order.dart';
import 'package:dzstore/services/productServices.dart';
import 'package:flutter/material.dart';

orders() {
  var ordersS = ProductServices();
  return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          "My Orders",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
        stream: ordersS.loadOrders(),
        builder: (context, snapshot) {
          List<Order> _orders = [];
          List<Order> orders = [];

          if (snapshot.hasData) {
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              orders.add(Order(
                  addSomething: data[note],
                  number: data[numberO],
                  docId: doc.id,
                  totalPrice: data[totalPrice].toString(),
                  payment: data[payment],
                  situation: data[situation]));
              _orders = [...orders];
              orders.clear();
              orders = getOrderByNumber("0675441798", _orders);
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return Container(
                    height: MediaQuery.of(context).size.height / 5.4,
                    width: double.infinity,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey[850]),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "Phone Number : ${orders[index].number}".toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.5),
                        ),
                        Text(
                          "Total Price : ${orders[index].totalPrice} DA",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.7),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, Details.id,
                                    arguments: orders[index].docId);
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  "Details",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.grey[850],
                                      content: Container(
                                          height: 200,
                                          width: 200,
                                          child: RichText(
                                              text: TextSpan(
                                                  text: orders[index]
                                                      .addSomething
                                                      .toString(),
                                                  style: TextStyle(
                                                      color: Colors.white)))),
                                    );
                                  },
                                );
                              },
                              child: Container(
                                height: 30,
                                width: 80,
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                    child: Text(
                                  "Note",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                              ),
                            ),
                          ],
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            if (orders[index].situation == "Accepted" ??
                                orders[index].situation == "Not Accepted") {
                              return Text(
                                orders[index].situation,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              );
                            } else {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      'Order: ${orders[index].situation}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                  Container(
                                    height: 30,
                                    width: 140,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Center(
                                        child: Text(
                                      'Cancel Order',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )),
                                  ),
                                ],
                              );
                            }
                          },
                        )
                      ],
                    ));
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ));
}
