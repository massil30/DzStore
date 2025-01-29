import 'package:dzstore/EnterApp/Login.dart';
import 'package:dzstore/models/user.dart';
import 'package:dzstore/services/datauser.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class SignUp extends StatefulWidget {
  static String id = "Signup";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  String number, password, name;
  var verificationId;
  var smsCode;

  @override
  Widget build(BuildContext context) {
    Future enterSmsCode() {
      AwesomeDialog(
          dialogBackgroundColor: Colors.grey[900],
          dialogType: DialogType.NO_HEADER,
          context: context,
          body: Container(
            height: 300,
            child: Column(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Enter Code";
                    }
                  },
                  onChanged: (val) {
                    smsCode = val;
                  },
                ),
                InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.deepPurple),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                    ),
                    onTap: () async {
                      if (_globalKey.currentState.validate()) {
                        _globalKey.currentState.save();
                        try {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          );
                          PhoneAuthCredential phoneAuthCredential =
                              PhoneAuthProvider.credential(
                            verificationId: verificationId,
                            smsCode: smsCode,
                          );

                          // Sign the user in (or link) with the credential
                          var user = UserData();
                          await FirebaseAuth.instance
                              .signInWithCredential(phoneAuthCredential);
                          user.addUser(
                              UserM(number: number, password: password));
                        } catch (e) {
                          AwesomeDialog(
                                  dialogType: DialogType.ERROR,
                                  context: context,
                                  body: Text("Wrong SmsCode"))
                              .show();
                        }
                      }
                    })
              ],
            ),
          ))
        ..show();
    }

    final PhoneCodeAutoRetrievalTimeout autoRetrievalTimeout = (String verId) {
      this.verificationId = verId;
    };
    final PhoneCodeSent smsCodeSent = (String verId, [int forceCodeResend]) {
      this.verificationId = verId;

      enterSmsCode().then((value) {
        print("SignedIn");
      });
    };

    final PhoneVerificationCompleted verificationSucces = (var user) {
      print("verified");
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException ok) {
      AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          body: LayoutBuilder(
            builder: (context, constraints) {
              print(ok.message);
              if (ok.message ==
                  "A network error (such as timeout, interrupted connection or unreachable host) has occurred.") {
                return Text("U have no Internet Conexion");
              }
              return Text(ok.message);
            },
          ))
        ..show();
    };
    return Form(
        key: _globalKey,
        child: Scaffold(
            body: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.grey[900]])),
              width: double.infinity,
              child: AnimationLimiter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: AnimationConfiguration.toStaggeredList(
                    duration: const Duration(seconds: 2),
                    childAnimationBuilder: (widget) => SlideAnimation(
                      horizontalOffset: -100,
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
                                  "Sign Up ",
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
                                  "SignUp if you dont have Acc",
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
                              child: Text("Name",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold)),
                            ),
                            buildPadding(
                              "Massil",
                              Icon(
                                Icons.person,
                                color: Colors.grey[600],
                              ),
                              name,
                              (val) {
                                if (val.isEmpty) {
                                  return "Name Cant Be Empty";
                                }
                                if (val.length < 4) {
                                  return "Name Cant be less than 4 letters";
                                }
                              },
                              TextInputType.name,
                              LengthLimitingTextInputFormatter(16),
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
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(10)
                                ],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17),
                                decoration: InputDecoration(

                                    //hint Text
                                    hintStyle:
                                        TextStyle(color: Colors.grey[600]),
                                    hintText: "0675441798",
                                    filled: true,
                                    fillColor: Colors.black,
                                    prefixIcon: Icon(Icons.phone),
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
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "Yo Rani hna";
                                  }
                                },
                                onSaved: (val) {
                                  number = val;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, top: 8, bottom: 8),
                              child: Text("Password",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.bold)),
                            ),
                            buildPadding(
                              "*******",
                              Icon(
                                Icons.lock,
                                color: Colors.grey[600],
                              ),
                              password,
                              (val) {
                                if (val.isEmpty) {
                                  return "Password Cant Be Empty";
                                }
                                if (val.length < 6) {
                                  return "Bad Password";
                                }
                              },
                              TextInputType.visiblePassword,
                              LengthLimitingTextInputFormatter(20),
                            ),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 26),
                                child: Builder(
                                  builder: (context) => InkWell(
                                    onTap: () async {
                                      var user = UserData();
                                      if (_globalKey.currentState.validate()) {
                                        _globalKey.currentState.save();
                                        try {
                                          final valid =
                                              await user.loadnumbers(number);
                                          if (valid) {
                                            try {
                                              await FirebaseAuth.instance
                                                  .verifyPhoneNumber(
                                                      codeAutoRetrievalTimeout:
                                                          autoRetrievalTimeout,
                                                      phoneNumber:
                                                          "+213$number",
                                                      codeSent: smsCodeSent,
                                                      verificationCompleted:
                                                          verificationSucces,
                                                      verificationFailed:
                                                          verificationFailed);
                                              print("never existed");
                                              print(number);
                                            } catch (e) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text("ok"),
                                              ));
                                            }
                                          } else {
                                            AwesomeDialog(
                                                dialogType: DialogType.ERROR,
                                                context: context,
                                                body: Text(
                                                    "This Number Already Exists"))
                                              ..show();
                                            print(number);
                                          }
                                        } catch (e) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(e.message),
                                          ));
                                        }
                                      }
                                    },
                                    child: Container(
                                      child: Text(
                                        "SignUp",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Roboto",
                                            fontSize: 18),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 70, vertical: 10),
                                      color: Colors.deepPurple,
                                    ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    "You  Have Account ?",
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (BuildContext context) {
                                        return Login();
                                      }));
                                    },
                                    child: Text(
                                      "Login",
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
                      )
                    ],
                  ),
                ),
              )),
        )));
  }

  Padding buildPadding(hint, icon, something, validator, keybordtype, ok) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        inputFormatters: [ok],
        style: TextStyle(color: Colors.white, fontSize: 17),
        decoration: InputDecoration(

            //hint Text
            hintStyle: TextStyle(color: Colors.grey[600]),
            hintText: hint,
            filled: true,
            fillColor: Colors.black,
            prefixIcon: icon,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
                borderRadius: BorderRadius.circular(10)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10)),
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10))),
        validator: validator,
        onSaved: (val) {
          something = val;
        },
      ),
    );
  }
}
