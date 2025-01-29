import 'package:dzstore/EnterApp/SignUp.dart';
import 'package:dzstore/Screen/Home.dart';
import 'package:dzstore/constant.dart';
import 'package:dzstore/models/user.dart';
import 'package:dzstore/services/datauser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class Login extends StatefulWidget {
  static String id = "Login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String number;
  TextEditingController controller;
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _globalKey,
        child: Scaffold(
            backgroundColor: Colors.grey[900],
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.grey[900]])),
              width: double.infinity,
              child: Center(
                child: AnimationLimiter(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: AnimationConfiguration.toStaggeredList(
                      duration: const Duration(seconds: 2),
                      childAnimationBuilder: (widget) => SlideAnimation(
                            horizontalOffset: 100,
                            child: FadeInAnimation(
                              child: widget,
                            ),
                          ),
                      children: [
                        Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              color: Color(0xFF222225),
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Sign in ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 22,
                                        fontFamily: "Roboto",
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Login if you have Acc",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[600],
                                        fontFamily: "Roboto"),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 12, top: 8, bottom: 8),
                                child: Text("Phone Number",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: controller,
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(10),
                                  ],
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 17),
                                  decoration: InputDecoration(

                                      //hint Text
                                      hintStyle:
                                          TextStyle(color: Colors.grey[600]),
                                      hintText: "0675441798",
                                      filled: true,
                                      fillColor: Colors.black,
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.grey[700],
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      errorBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.black),
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  // ignore: missing_return
                                  validator: (val) {
                                    if (val.isEmpty) {
                                      return "Phone Number Cant Be Empty";
                                    }
                                  },
                                  onChanged: (val) {
                                    number = val;
                                  },
                                ),
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 26),
                                  child: Builder(
                                    builder: (context) => RaisedButton(
                                      child: Text(
                                        "Login",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Roboto",
                                            fontSize: 18),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 70, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      color: Colors.deepPurple,
                                      onPressed: () async {
                                        if (_globalKey.currentState
                                            .validate()) {
                                          _globalKey.currentState.save();
                                          var user = UserData();
                                          try {
                                            final valid =
                                                await user.loadnumbers(number);
                                            if (valid) {
                                              try {
                                                showDialog(
                                                    builder: (context) {
                                                      return AlertDialog(
                                                        backgroundColor:
                                                            Colors.grey[900],
                                                        content: Container(
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceAround,
                                                            children: [
                                                              Text(
                                                                "Never seen this Before",
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    color: Colors
                                                                            .grey[
                                                                        400],
                                                                    fontFamily:
                                                                        "Roboto"),
                                                              ),
                                                              CircularProgressIndicator(
                                                                backgroundColor:
                                                                    Colors
                                                                        .deepPurple,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    context: context);

                                                print("never existed");
                                                print(number);
                                              } catch (e) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text("ok"),
                                                ));
                                              }
                                            } else {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                builder: (context) {
                                                  return Scaffold(
                                                    body: Center(
                                                      child: Container(
                                                        height: 300,
                                                        width: double.infinity,
                                                        margin: EdgeInsets.only(
                                                            left: 10,
                                                            right: 10),
                                                        child: StreamBuilder(
                                                          stream: user
                                                              .loadDataUsers(),
                                                          builder: (context,
                                                              snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              List<UserM> user =
                                                                  [];
                                                              List<UserM>
                                                                  _user = [];

                                                              for (var doc
                                                                  in snapshot
                                                                      .data
                                                                      .docs) {
                                                                var data =
                                                                    doc.data();
                                                                user.add(data[
                                                                    pPassword]);

                                                                _user = [
                                                                  ...user
                                                                ];
                                                                user.clear();
                                                                user =
                                                                    getAccbyNumber(
                                                                        number,
                                                                        _user);
                                                              }
                                                              String password;
                                                              return Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceAround,
                                                                children: [
                                                                  Text(
                                                                      'Phone Number $user[0].number'),
                                                                  Text(
                                                                      "Enter Your Password"),
                                                                  TextField(
                                                                    onChanged:
                                                                        (value) {
                                                                      password =
                                                                          value;
                                                                    },
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Navigator.pop(context);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            child:
                                                                                Text("Cancel"),
                                                                          )),
                                                                      Builder(
                                                                        builder:
                                                                            (context) =>
                                                                                InkWell(
                                                                          onTap:
                                                                              () {
                                                                            if (password ==
                                                                                user[0].password) {
                                                                              Navigator.pushNamed(context, Home.id);
                                                                            } else {
                                                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Wrong Password")));
                                                                            }
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            color:
                                                                                Colors.orange,
                                                                            child:
                                                                                Text("GO"),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  )
                                                                ],
                                                              );
                                                            } else {
                                                              return CircularProgressIndicator();
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ));
                                            }
                                          } catch (e) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(e.message),
                                            ));
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 20, right: 50, left: 50),
                                child: Divider(
                                  color: Colors.grey[600],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Text(
                                      "You dont Have Account? ",
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder:
                                                (BuildContext context) {
                                          return SignUp();
                                        }));
                                      },
                                      child: Text(
                                        "Create Account",
                                        style: TextStyle(
                                            color: Colors.purple, fontSize: 16),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(8),
                          width: double.infinity,
                        ),
                      ]),
                )),
              ),
            )));
  }
}

List<UserM> getAccbyNumber(String phone, List<UserM> allUsers) {
  List<UserM> users = [];
  try {
    for (UserM user in allUsers) {
      if (user.password == phone) {
        users.add(user);
      }
    }
  } on Error catch (ex) {
    print(ex);
  }
  return users;
}
