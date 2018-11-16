import 'dart:async';
import 'dart:math';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:data_recorder/DateTimeItem.dart';
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
                new ListTile(
                  leading: new Icon(Icons.today, color: Colors.grey[500]),
                  title: new DateTimeItem(
                    dateTime: _dateTime,
                    onChanged: (dateTime) =>
                        setState(() => _dateTime = dateTime),
                  ),
                ),
                new ListTile(
                  leading: new Icon(Icons.bubble_chart, color: Colors.grey[500]),
                  title: new Text(
                    "$_pointValue",
                  ),
                  onTap: () => _showDataPointInput(context),
                ),
              ],
            )
        )

    );
  }
}

class DateTimeItem extends StatelessWidget {
  DateTimeItem({Key key, DateTime dateTime, @required this.onChanged})
      : assert(onChanged != null),
        date = dateTime == null
            ? new DateTime.now()
            : new DateTime(dateTime.year, dateTime.month, dateTime.day),
        time = dateTime == null
            ? new DateTime.now()
            : new TimeOfDay(hour: dateTime.hour, minute: dateTime.minute),
        super(key: key);

  final DateTime date;
  final TimeOfDay time;
  final ValueChanged<DateTime> onChanged;

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Expanded(
          child: new InkWell(
            onTap: (() => _showDatePicker(context)),
            child: new Padding(
                padding: new EdgeInsets.symmetric(vertical: 8.0),
                child: new Text(formatDate(date,[mm, '-', dd, '-', yyyy]))),
          ),
        ),
        new InkWell(
          onTap: (() => _showTimePicker(context)),
          child: new Padding(
              padding: new EdgeInsets.symmetric(vertical: 8.0),
              child: new Text('${time.hourOfPeriod}:${time.minute}')),
        ),
      ],
    );
  }

  Future _showDatePicker(BuildContext context) async {
    DateTime dateTimePicked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date.subtract(const Duration(days: 20000)),
        lastDate: date.add(const Duration(days: 20000))
    );

    if (dateTimePicked != null) {
      onChanged(new DateTime(dateTimePicked.year, dateTimePicked.month,
          dateTimePicked.day, time.hour, time.minute));
    }
  }

  Future _showTimePicker(BuildContext context) async {
    TimeOfDay timeOfDay =
    await showTimePicker(context: context, initialTime: time);

    if (timeOfDay != null) {
      onChanged(new DateTime(
          date.year, date.month, date.day, timeOfDay.hour, timeOfDay.minute));
    }
  }
}