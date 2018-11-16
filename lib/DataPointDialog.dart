import 'dart:async';
import 'package:data_recorder/DateTimeItem.dart';
import 'package:flutter/material.dart';
import 'package:data_recorder/models/TimeSeriesDataPoint.dart';

class DataPointDialog extends StatefulWidget {

  // Declare initial values
  final double initialPoint;
  final TimeSeriesDataPoint dataPointToEdit;

  // Constructor
  DataPointDialog.add(this.initialPoint) : dataPointToEdit = null;

  DataPointDialog.edit(this.dataPointToEdit)
      : initialPoint = dataPointToEdit.value;

  // Create the initial state
  @override
  DataPointDialogState createState() {
    if (dataPointToEdit != null) {
      return new DataPointDialogState(dataPointToEdit.time,
          dataPointToEdit.value);
    } else {
      return new DataPointDialogState(
          new DateTime.now(), initialPoint);
    }
  }
}

class DataPointDialogState extends State<DataPointDialog> {

  // Declare state variables
  DateTime _dateTime = new DateTime.now();
  double _pointValue;

  DataPointDialogState(this._dateTime, this._pointValue);

  _showDataPointInput(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return new SimpleDialog(
          title: new Text('Enter some data'),
          children: <Widget>[
            new Container(
              padding: const EdgeInsets.all(32.0),
              child:  new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new TextField(
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) {
                      if (value != null) {
                        setState(() => _pointValue = double.parse(value));
                        Navigator.pop(context);
                      }
                    },
                  ),
                ],
              )
            )
          ]
        );
      }
    ).then((value) {
      if (value != null) {
        setState(() => _pointValue = value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("New Data Point"),
          actions: [
            new FlatButton(
                onPressed: () {
                  Navigator
                      .of(context)
                      .pop(new TimeSeriesDataPoint(_dateTime,_pointValue));
                },
                child: new Text('Save Point',
                    style: Theme
                        .of(context)
                        .textTheme
                        .subhead
                        .copyWith(color: Colors.white))),
          ],
        ),
        body:
        new Container(
            padding: const EdgeInsets.all(32.0),
            child:
            Column(
              children: <Widget>[
                new DateTimeItem(
                  dateTime: _dateTime,
                  onChanged: (dateTime) =>
                      setState(() => _dateTime = dateTime),
                ),
                new ListTile(
                  leading: new Icon(Icons.bubble_chart, color: Colors.green[500]),
                  title: new Padding(padding:
                    EdgeInsets.symmetric(vertical: 15.0),
                    child: new Text(
                      "$_pointValue",
                      textAlign: TextAlign.left,
                      style: new TextStyle(fontSize: 30.0)
                    ),
                  ),
                  onTap: () => _showDataPointInput(context),
                ),
              ],
            )
        )

    );
  }
}

