import 'dart:async';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  final f = new DateFormat('hh:mm');

  @override
  Widget build(BuildContext context) {
    return new Column(
      children: <Widget>[
        new ListTile(
          leading: new Icon(Icons.calendar_today, color: Colors.green[500]),
          title:
            new InkWell(
              onTap: (() => _showDatePicker(context)),
              child: new Padding(
                  padding: new EdgeInsets.symmetric(vertical: 15.0),
                  child: new Text(
                      formatDate(date,[mm, '-', dd, '-', yyyy]),
                      textAlign: TextAlign.left,
                      style: new TextStyle(fontSize: 30.0))
                ),
              ),
            ),
        new ListTile(
          leading: new Icon(Icons.access_time, color: Colors.green[500]),
          title:new InkWell(
                onTap: (() => _showTimePicker(context)),
                child: new Padding(
                    padding: new EdgeInsets.symmetric(vertical: 15.0),
                    child: new Text(
                        //DateFormat('yyyy-MM-dd – kk:mm').format(time),
                        '${time.hourOfPeriod.toString().padLeft(2, '0')}:'
                            '${time.minute.toString().padLeft(2, '0')} '
                            '${time.hour > 11 ? "PM" : "AM"}',
                        textAlign: TextAlign.left,
                        style: new TextStyle(fontSize: 30.0)
                    )
                ),
            ),
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