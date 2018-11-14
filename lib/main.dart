import 'dart:async';
import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:data_recorder/DataPointDialog.dart';
import 'package:data_recorder/models/TimeSeriesDataPoint.dart';


void main() => runApp(new LineChart());

class LineChart extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Data Recorder',
      theme: new ThemeData(
        primarySwatch: Colors.green,
      ),
      home: new DataVisualizerLineGraph(title: 'Record some data!'),
    );
  }

}


class DataVisualizerLineGraph extends StatefulWidget {

  // Widget properties
  final String title;

  // Constructor
  DataVisualizerLineGraph({Key key, this.title}) : super(key: key);

  // Create the state of the widget
  @override
  _DataVisualizerLineGraphState createState() => new _DataVisualizerLineGraphState();
}

class _DataVisualizerLineGraphState extends State<DataVisualizerLineGraph> {

  // Define state properties
  List<TimeSeriesDataPoint> dataPoints = new List<TimeSeriesDataPoint>();
  final bool animate = true;

  /// Define any functions that modify the state here...

  // Add a random data point
  void _addDataPoint(TimeSeriesDataPoint dataPoint) {
    final random = new Random();
    setState(() {
      // If the point is not specified, create a random point
      if(dataPoint == null) {
        dataPoints.add(new TimeSeriesDataPoint(new DateTime.now(),
            random.nextDouble() * 100));
      } else {
        dataPoints.add(dataPoint);
      }
    });
  }

  // Open uop the dialog to add a new point
//  void _openAddDataPointDialog() {
//    Navigator.of(context).push(new MaterialPageRoute<Null>(
//        builder: (BuildContext context) {
//          return new DataPointDialog.add(1.0);
//        },
//        fullscreenDialog: true
//    ));
//  }

  // Open the dialog and return the value asynchronously
  Future _openAddDataPointDialogAsync() async {
    TimeSeriesDataPoint save = await Navigator.of(context).push(
        new MaterialPageRoute<TimeSeriesDataPoint>(
        builder: (BuildContext context) {
          return new DataPointDialog.add(1.0);
        },
        fullscreenDialog: true
    ));
    if (save != null) {
      _addDataPoint(save);
    }
  }

  // Perform any initialization here, e.g. send http request
  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
        title: new Text("Super Awesome Data Recorder!"),
      ),
      body: createGraph(),
      floatingActionButton: new FloatingActionButton(
        onPressed: _openAddDataPointDialogAsync,
        tooltip: 'Add Data',
        child: new Icon(Icons.add),
      ),
    );
  }

  Widget createGraph() {

    // Initialize the list of data points
    if(dataPoints == null || dataPoints.length == 0) {
      dataPoints.add(new TimeSeriesDataPoint(new DateTime.now(), 0.0));
    }

    // Define the series
    var series = [
      new charts.Series<TimeSeriesDataPoint, DateTime>(
        id: 'Date Value',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeriesDataPoint coinsPrice, _) => coinsPrice.time,
        measureFn: (TimeSeriesDataPoint coinsPrice, _) => coinsPrice.value,
        data: dataPoints,
      ),
    ];

    // Define the chart object
    var chart = new charts.TimeSeriesChart(
      series,
      animate: true,
    );

    // Return the container with chart and data
    return new Container(
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Padding(
            padding: new EdgeInsets.all(32.0),
            child: new SizedBox(
              height: 400.0,
              child: chart,
            ),
          ),
        ],
      ),
    );
  }
}