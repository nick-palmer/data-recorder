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
                    fontSize: 50.0
                ),
                ),
              ),
              new Center(
                child: new RaisedButton(
                  padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  color: Colors.lightGreenAccent,
                  child: new Text(
                    "Start",
                    style: new TextStyle(
                        fontSize: 36.0,
                        color: Colors.green
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