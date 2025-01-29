import 'package:dzstore/EnterApp/Login.dart';
import 'package:dzstore/EnterApp/SignUp.dart';
import 'package:dzstore/Screen/Home.dart';
import 'package:dzstore/Screen/Home/initialpage.dart';
import 'package:dzstore/Screen/details.dart';
import 'package:dzstore/Screen/listpage.dart';
import 'package:dzstore/Widgets/Game.dart';
import 'package:dzstore/Widgets/movies.dart';
import 'package:dzstore/Widgets/music.dart';
import 'package:dzstore/addToCart/cartitem.dart';
import 'package:dzstore/transltae.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Translate>(create: (context) => Translate()),
        ChangeNotifierProvider<CartItem>(create: (context) => CartItem())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home:Home(),
        routes: {
          Details.id: (context) => Details(),
          Login.id: (context) => Login(),
          SignUp.id: (context) => SignUp(),
          Home.id: (context) => Home(),
          "gamingtab": (context) => gamingTab(context),
          "music": (context) => music(context),
          "movies": (context) => movies(context),
          ListOffers.id: (context) => ListOffers(),
        },
      ),
    );
  }
}
