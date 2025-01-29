import 'package:dzstore/constant.dart';
import 'package:dzstore/funcation.dart';
import 'package:dzstore/models/product.dart';
import 'package:dzstore/services/productServices.dart';
import 'package:flutter/material.dart';

firstType(
  appBarTitle,
  coverImage,
  iconImage,
  color,
) {
  var offer = ProductServices();
  return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          appBarTitle,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.black, border: Border.all(color: Colors.black)),
              height: 230,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      child: Image.network(
                        coverImage,
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
                              image: AssetImage(iconImage),
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
                        colors: [Colors.black, color])),
                child: listWidget(appBarTitle, iconImage))
          ],
        ),
      ));
}

listWidget(appBarTitle, iconImage) {
  var offer = ProductServices();
  return StreamBuilder(
    stream: offer.loadProduct(),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        List<Product> product = [];

        List<Product> _product = [];
        List<int> listI = [];

        for (var doc in snapshot.data.docs) {
          var data = doc.data();

          product.add(Product(
              name: data[pName],
              image: data[pImage],
              price: data[pPrice],
              offer: data[pOffer],
              category: data[pCategory],
              decription: data[pDesciption]));
          _product = [...product];
          product.clear();
          product = getNameByOffer(appBarTitle, _product);
        }

        product
            .sort((a, b) => int.parse(a.price).compareTo(int.parse(b.price)));  

        return Column(
          children: [
            Container(
              height: 110,
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    appBarTitle.toUpperCase(),
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
                    height: 13,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 50, right: 50),
                    height: 12,
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10)),
                  )
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height - 450,
              child: RawScrollbar(
                thumbColor: Colors.white,
                isAlwaysShown: true,
                child: ListView.builder(
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              backgroundColor: Colors.grey[850],
                              content: Container(
                                height: 250,
                                width: 250,
                                child: Center(
                                  child: Text(
                                    product[index].decription.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 8, right: 8, bottom: 8),
                        decoration: BoxDecoration(
                            color: Colors.grey[850],
                            borderRadius: BorderRadius.circular(10)),
                        height: MediaQuery.of(context).size.height / 7,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  height: 70,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: AssetImage(iconImage),
                                      ),
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20)),
                                  width: 70,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      product[index].name,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${product[index].price.toString()} DA",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                AddToCart(context, product[index]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 7, right: 7),
                                decoration: BoxDecoration(
                                    color: Colors.deepPurple,
                                    borderRadius: BorderRadius.circular(10)),
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
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        );
      } else {
        return CircularProgressIndicator(
          backgroundColor: Colors.deepPurple,
        );
      }
    },
  );
}
