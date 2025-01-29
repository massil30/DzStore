import 'package:dzstore/models/user.dart';
import 'package:dzstore/services/datauser.dart';
import 'package:dzstore/transltae.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    var lan = Provider.of<Translate>(context, listen: true);
    var user = UserData();
    return Directionality(
      textDirection: lan.isEn ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          backgroundColor: Colors.grey[900],
          title: Text(lan.getTexts("settings")),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Column(
                children: [
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Container(
                              height: 200,
                              width: 300,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                      onTap: () {
                                        setState(() {
                                          lan.isEn = false;
                                        });
                                        Navigator.pop(context);
                                      },
                                      trailing: lan.isEn == false
                                          ? Icon(Icons.confirmation_num)
                                          : SizedBox(),
                                      leading: Text("Arabic")),
                                  ListTile(
                                      onTap: () {
                                        setState(() {
                                          lan.isEn = true;
                                        });
                                        Navigator.pop(context);
                                      },
                                      trailing: lan.isEn == true
                                          ? Icon(Icons.confirmation_num)
                                          : SizedBox(),
                                      leading: Text("English")),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    leading: Text(
                      "Select Language",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    trailing: Text(
                      lan.getTexts('language'),
                      style: TextStyle(
                          color: Colors.purple,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.grey[800],
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            backgroundColor: Colors.grey[900],
                            content: Container(
                              child: Container(
                                height: 250,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 9),
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Image.asset(
                                        "images/logo.png",
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(
                                      "Dz Store",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(top: 15, bottom: 20),
                                      child: RichText(
                                          text: TextSpan(
                                              text:
                                                  "jsazpd,apod,apod,azpod,apod,apod,azpsapsako^dak^doakp^dazkdpâzkdp",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18))),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 15),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Version ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text(
                                            "0.001",
                                            style:
                                                TextStyle(color: Colors.purple),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                    leading: Icon(
                      Icons.info,
                      color: Colors.white,
                      size: 30,
                    ),
                    title: Text(
                      "About App",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                  Divider(
                    height: 10,
                    color: Colors.grey[800],
                  ),
                  ListTile(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Container(
                              height: 300,
                              child: Column(
                                children: [
                                  Text("Report"),
                                  TextFormField(
                                    maxLines: 8,
                                  ),
                                  RaisedButton(
                                    child: Text("Send"),
                                    onPressed: () {},
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    leading: Icon(
                      Icons.help,
                      size: 35,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Report",
                      style: TextStyle(color: Colors.white, fontSize: 22),
                    ),
                  ),
                  Builder(
                    builder: (context) => FlatButton(
                        color: Colors.white,
                        onPressed: () {
                          try {
                            user.addUser(
                                UserM(number: "pekaeaz", password: "kdazeeaz"));
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text("Nice"),
                                );
                              },
                            );
                          } catch (e) {
                            Scaffold.of(context).showSnackBar(
                                SnackBar(content: Text(e.message)));
                          }
                        },
                        child: Text("ok")),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
