import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dzstore/addToCart/cartitem.dart';
import 'package:dzstore/models/order.dart';
import 'package:dzstore/models/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

import 'package:dzstore/Screen/Home.dart';
import 'package:dzstore/constant.dart';
import 'package:dzstore/services/productServices.dart';
import 'package:provider/provider.dart';

class Oks extends StatefulWidget {
  final priceTotal;
  final products;
  Oks({this.priceTotal, this.products});
  @override
  _OksState createState() => _OksState();
}

class _OksState extends State<Oks> {
  int _currentStep = 0;
  int loading = 0;
  StepperType stepperType = StepperType.vertical;
  File _image;
  tapped(int step) {
    setState(() => _currentStep = step);
  }

  cancel() {
    _currentStep > 0
        ? setState(() => _currentStep -= 1)
        : Navigator.pop(context);
  }

  go() {
    _currentStep < 2
        ? setState(() => _currentStep += 1)
        : Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    var noteE;

    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Container(
        child: Theme(
          data: ThemeData(
              canvasColor: Colors.grey[850],
              primaryColor: Colors.deepPurple,
              colorScheme: ColorScheme.light(primary: Colors.deepPurple)),
          child: Column(
            children: [
              Expanded(
                child: Stepper(
                  type: stepperType,
                  physics: ScrollPhysics(),
                  currentStep: _currentStep,
                  onStepTapped: (step) => tapped(step),
                  controlsBuilder: (context, {onStepCancel, onStepContinue}) {
                    return Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              LayoutBuilder(
                                builder: (context, constraints) {
                                  if (loading == 0) {
                                    return InkWell(
                                      onTap: () async {
                                        var _url;
                                        if (_currentStep == 2) {
                                          var store = ProductServices();
                                          try {
                                            setState(() {
                                              loading++;
                                            });

                                            FirebaseStorage storage =
                                                FirebaseStorage(
                                                    storageBucket:
                                                        'gs://dzstore-c4fa7.appspot.com');
                                            StorageReference ref = storage
                                                .ref()
                                                .child(_image.path);
                                            StorageUploadTask
                                                storageUploadTask =
                                                ref.putFile(_image);
                                            StorageTaskSnapshot taskSnapshot =
                                                await storageUploadTask
                                                    .onComplete;

                                            String url = await taskSnapshot.ref
                                                .getDownloadURL();
                                            setState(() {
                                              _url = url;
                                            });

                                            store.storeOrders({
                                              "Date":DateTime.now(),
                                              note: noteE,
                                              imagePicker: _url,
                                              situation: "Pending",
                                              numberO: "0675441798",
                                              totalPrice: widget.priceTotal,
                                              payment: "Not Yet",


                                            }, widget.products);
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Home()),
                                                ModalRoute.withName("/Home"));
                                            AwesomeDialog(
                                                context: context,
                                                dialogType: DialogType.SUCCES,
                                                body: Text("Bsahtek"));
                                          } catch (ex) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                              content: Text(ex.message),
                                            ));
                                          }
                                        } else {
                                          setState(() {
                                            _currentStep++;
                                          });
                                        }
                                      },
                                      child: Container(
                                        height: 35,
                                        child: Center(
                                            child: Text(
                                          _currentStep == 2 ? "Order" : "Next",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: Colors.deepPurple),
                                        width: 120,
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      height: 35,
                                      child: Center(
                                          child: Row(
                                        children: [
                                          Text("Loading.... ",
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                          CircularProgressIndicator()
                                        ],
                                      )),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.deepPurple),
                                      width: 120,
                                    );
                                  }
                                },
                              ),
                              InkWell(
                                onTap: () {
                                  cancel();
                                },
                                child: Container(
                                  height: 35,
                                  child: Center(
                                      child: Text(
                                    "Cacncel",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.red),
                                  width: 120,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  steps: <Step>[
                    Step(
                      title: Text(
                        'First Stage',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RichText(
                                  text: TextSpan(
                                      text: "Send money to 120246456 in CCP")),
                            ),
                            Expanded(child: Image.asset("images/CCP.png"))
                          ],
                        ),
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 0
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text(
                        "Second Stage",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      content: Column(
                        children: [
                          Text(
                            "Add your note here",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                          TextFormField(
                            maxLines: 5,
                            onChanged: (value) {
                              setState(() {
                                noteE = value;
                              });
                            },
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.5,
                                fontWeight: FontWeight.bold),
                            cursorColor: Colors.deepPurple,
                            decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                border: UnderlineInputBorder(),
                                fillColor: Colors.white,
                                hoverColor: Colors.white,
                                labelText: "Note",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                          )
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 1
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                    Step(
                      title: new Text(
                        'Final Stage',
                        style: TextStyle(color: Colors.white),
                      ),
                      content: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  File image = await ImagePicker.pickImage(
                                      source: ImageSource.camera);
                                  print(image);
                                  setState(() {
                                    _image = image;
                                  });
                                },
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.circular(3)),
                                  width: 130,
                                  child: Center(
                                    child: Text(
                                      _image == null
                                          ? "Take a clear Picture"
                                          : "Re-take a Picture",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          _image == null
                              ? Container(
                                  height: 300,
                                  width: 360,
                                  color: Colors.grey[700],
                                  child: Center(child: Text("Image")),
                                )
                              : InkWell(
                                  child: Container(
                                      height: 300,
                                      width: 360,
                                      color: Colors.green,
                                      child: Image.file(
                                        _image,
                                        fit: BoxFit.fill,
                                      )),
                                ),
                        ],
                      ),
                      isActive: _currentStep >= 0,
                      state: _currentStep >= 2
                          ? StepState.complete
                          : StepState.disabled,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FavoriteList extends StatefulWidget {
  final Set<String> data;
  final Function savePrefs;
  final TextStyle biggerFont;
  FavoriteList({Key key, this.data, this.savePrefs, this.biggerFont})
      : super(key: key);

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  Set<String> _saved;

  @override
  void initState() {
    _saved = widget.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = _saved.map(
      (String word) {
        return ListTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                word,
                style: widget.biggerFont,
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    _saved.remove(word);
                    widget.savePrefs(_saved);
                  });
                },
              )
            ],
          ),
        );
      },
    );

    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Suggestions'),
      ),
      body: ListView(children: divided),
    );
  }
}
