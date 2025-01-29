import 'package:dzstore/offer/firstT.dart';
import 'package:flutter/material.dart';

thType(appBarTitle, title1, title2, title3, iconImage, coverImage, color,
    context, tab1, tab2, tab3) {
  return DefaultTabController(
    length: 3,
    child: Scaffold(
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
                height: 35,
                color: Colors.grey[850],
                child: TabBar(
                    indicator: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(5)),
                    indicatorColor: Colors.blue,
                    tabs: [
                      Text(
                        tab1,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(tab2, style: TextStyle(fontWeight: FontWeight.bold)),
                      Text(tab3, style: TextStyle(fontWeight: FontWeight.bold)),
                    ]),
              ),
              Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.black, color])),
                  child: Container(
                    height: MediaQuery.of(context).size.height - 330,
                    child: TabBarView(children: [
                      listWidget(title1, iconImage),
                      listWidget(title2, iconImage),
                      listWidget(title3, iconImage)
                    ]),
                  ))
            ],
          ),
        )),
  );
}
