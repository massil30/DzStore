import 'package:dzstore/constant.dart';
import 'package:dzstore/funcation.dart';
import 'package:dzstore/models/product.dart';
import 'package:dzstore/services/productServices.dart';
import 'package:flutter/material.dart';

class ListOffers extends StatefulWidget {
  static String id = "Offers";
  @override
  _ListOffersState createState() => _ListOffersState();
}

class _ListOffersState extends State<ListOffers> {
  @override
  Widget build(BuildContext context) {
    var offer = ProductServices();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            'Netflix',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    border: Border.all(color: Colors.black)),
                height: 230,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoNLkeO3gsU4WNcZRM_q9XUp2g6e1T_EtNEg&usqp=CAU",
                          height: 180,
                          fit: BoxFit.cover,
                          width: 500,
                        ),
                      ),
                    ),
                    Positioned(
                        top: 140,
                        left: 170,
                        child: Container(
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage("images/backnetflix.png"),
                              ),
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(20)),
                          width: 70,
                        )),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, Colors.red[900]])),
                  child: StreamBuilder(
                    stream: offer.loadProduct(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Product> product = [];

                        List<Product> _product = [];

                        for (var doc in snapshot.data.docs) {
                          var data = doc.data();

                          product.add(Product(
                              name: data[pName],
                              image: data[pImage],
                              price: data[pPrice],
                              offer: data[pOffer],
                              category: data[pCategory]));
                          _product = [...product];
                          product.clear();
                          product = getNameByOffer("Netflix", _product);
                        }
                        return Column(
                          children: [
                            Container(
                              height: 100,
                              child: Column(
                                children: [
                                  Text(
                                    "Netflix".toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${product.length} Offers Availables",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 50, right: 50),
                                    height: 12,
                                    decoration: BoxDecoration(
                                        color: Colors.grey[800],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height -
                                  230 -
                                  100,
                              child: ListView.builder(
                                itemCount: product.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(
                                        left: 8, right: 8, bottom: 8),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[850],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    height:
                                        MediaQuery.of(context).size.height / 7,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, right: 10),
                                              height: 70,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: AssetImage(
                                                        "images/backnetflix.png"),
                                                  ),
                                                  color: Colors.blue,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              width: 70,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                  product[index].name,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "4000 DA",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                          onTap: () {},
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 7, right: 7),
                                            decoration: BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            height: 50,
                                            width: 120,
                                            child: Center(
                                              child: Text(
                                                "Add To Cart",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        );
                      } else {
                        return CircularProgressIndicator();
                      }
                    },
                  ))
            ],
          ),
        ));
  }
}
