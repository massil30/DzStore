import 'package:dzstore/constant.dart';
import 'package:dzstore/models/product.dart';
import 'package:dzstore/services/productServices.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  static String id = "Details";

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  var productO = ProductServices();

  @override
  Widget build(BuildContext context) {
    String docId = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Details",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w900)),
      ),
      backgroundColor: Colors.grey[850],
      body: StreamBuilder(
        stream: productO.loadOrderDetails(docId),
        builder: (context, snapshot) {
          List<Product> products = [];

          if (snapshot.hasData) {
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              products.add(Product(
                  name: data[pName],
                  price: data[pPrice],
                  quantity: data[pQuantity],
                  offer: data[pOffer]));
            }
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[700],
                      borderRadius: BorderRadius.circular(10)),
                  height: MediaQuery.of(context).size.height / 6,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 7,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.red[900],
                        ),
                      ),
                      SizedBox(
                        width: 7,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            '${products[index].offer} ${products[index].name}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 19),
                          ),
                          Text(" Quantity: ${products[index].quantity}",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900)),
                          Text(
                            "Price: ${products[index].quantity * int.parse(products[index].price.toString())} DA",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
