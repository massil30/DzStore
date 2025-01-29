import 'package:dzstore/constant.dart';
import 'package:dzstore/models/product.dart';
import 'package:dzstore/services/productServices.dart';
import 'package:flutter/material.dart';

class Search extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = "";
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    var product = ProductServices();
    return StreamBuilder(
      stream: product.loadProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];

          List<String> _products = [];
          for (var doc in snapshot.data.docs) {
            var data = doc.data();

            products.add(Product(
                name: data[pName], offer: data[pOffer], price: data[pPrice]));
            _products.add(data[pOffer]);
          }
          var prod = query.isEmpty
              ? _products
              : _products.where((p) => p.contains(query)).toList();
          return ListView.builder(
            itemCount: prod.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: InkWell(
                  onTap: () {
                    AddToCart(context, products[index]);
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(5)),
                    width: 120,
                    child: Center(
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                subtitle: Text(
                  "${products[index].name}  ${products[index].price} DA",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                title: Text(
                  prod[index],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var product = ProductServices();
    return StreamBuilder(
      stream: product.loadProduct(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Product> products = [];

          List<String> _products = [];
          for (var doc in snapshot.data.docs) {
            var data = doc.data();

            products.add(Product(
                name: data[pName], offer: data[pOffer], price: data[pPrice]));
            _products.add(data[pOffer]);
          }
          var prod = query.isEmpty
              ? _products
              : _products.where((p) => p.contains(query)).toList();
          return ListView.builder(
            itemCount: prod.length,
            itemBuilder: (context, index) {
              return ListTile(
                trailing: InkWell(
                  onTap: () {
                    AddToCart(context, products[index]);
                  },
                  child: Container(
                    height: 30,
                    decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(5)),
                    width: 120,
                    child: Center(
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                subtitle: Text(
                  "${products[index].name}  ${products[index].price} DA",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                title: Text(
                  prod[index],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
                ),
              );
            },
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
