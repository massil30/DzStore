import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dzstore/Screen/Home/search.dart';
import 'package:dzstore/Widgets/movies.dart';
import 'package:dzstore/addToCart/ATCV.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

Container home(
  context,
) {
  return Container(
    decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
          Colors.grey[900],
          Colors.black,
        ])),
    child: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: AnimationConfiguration.toStaggeredList(
            duration: const Duration(milliseconds: 600),
            childAnimationBuilder: (widget) => SlideAnimation(
              verticalOffset: -50,
              child: FadeInAnimation(
                child: widget,
              ),
            ),
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Icon(
                        Icons.list,
                        color: Colors.white,
                        size: 25,
                      ),
                    ),
                    Text(
                      "Dz Store",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return AddToCart();
                          },
                        ));
                      },
                      child: Icon(
                        Icons.shopping_bag_outlined,
                        size: 25,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15, left: 22, right: 10),
                child: Text("Welcom Massil",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold)),
              ),
              InkWell(
                onTap: () {
                  showSearch(context: context, delegate: Search());
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  margin: EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey[850],
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 20),
                          child: Text(
                            "Search The Games ...",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(
                            Icons.search,
                            size: 30,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Color(0xff313131),
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "gamingtab");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset("images/games.png"),
                                Text(
                                  "Games",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, "music");
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset("images/music.png"),
                                Container(
                                  child: Text(
                                    "Music",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return movies(context);
                              }));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Image.asset("images/movies.png"),
                                Text(
                                  "Movies",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Icon(
                                  Icons.phonelink_lock,
                                  color: Colors.green,
                                  size: 50,
                                ),
                                Text(
                                  "Security",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(
                  "Dz Store Services",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20, top: 10),
                child: CarouselSlider(
                    items: [
                      Image.network("https://wallpapercave.com/wp/wp4131588.jpg",fit: BoxFit.cover,),
                      Image.network("https://wallpapercave.com/wp/wp4131588.jpg",fit: BoxFit.cover,),
                      Image.network("https://wallpapercave.com/wp/wp4131588.jpg",fit: BoxFit.cover,),
                    ],
                    options: CarouselOptions(
                      height: 200,
                      aspectRatio: 16 / 9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: Duration(seconds: 3),
                      autoPlayAnimationDuration: Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text(
                      "Trainding ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 15),
                    child: Text(
                      "View All",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS2Gb5rUe6MDECX9JUrjwR1CS9bXb4njTQ6aQ&usqp=CAU",
                          fit: BoxFit.cover,
                          height: 200,
                          width: 150,
                        ),
                      ),
                    ),
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Image.network(
                          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpcQu7mILTsAP1xFGSdMlBybI3rrG4ODlU3w&usqp=CAU",
                          fit: BoxFit.cover,
                          height: 200,
                          width: 150,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Image.network(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSvCzYu572iz8Otzy2t0vH1Acx-3Xy2o5HH3A&usqp=CAU",
                        fit: BoxFit.cover,
                        height: 200,
                        width: 150,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    ),
  );
}
