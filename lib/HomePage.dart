import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:data_recorder/DataPointGraphPage.dart';

class HomePage extends StatelessWidget {
  final String title;

  HomePage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Container(
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage("assets/images/home_bg.png"),
                fit: BoxFit.cover,),
            ),
          ),
          new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Center(
                child: new Text(
                  "Data\n    Recorder",
                  style: new TextStyle(
                    fontFamily: "Orbitron",
                    fontSize: 50.0,
                    color: Colors.black87,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 3.0,
                        color: Color.fromRGBO(240, 255, 240, 100),
                      ),
                      Shadow(
                        offset: Offset(3.0, 3.0),
                        blurRadius: 8.0,
                        color: Color.fromRGBO(110, 110, 110, 100),
                      ),
                    ],
                  ),
                ),
              ),
              new Center(
                child: new OutlineButton(
                  padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 45.0),
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(15.0)
                  ),
                  color: Colors.green,
                  borderSide: BorderSide(width: 3.0,color: Colors.black),
                  child: new Text(
                    "Start",
                    style: new TextStyle(
                        fontSize: 28.0,
                        color: Colors.black
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>
                          DataVisualizerLineGraph(title: 'Record some data!')),
                    );
                  }
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}