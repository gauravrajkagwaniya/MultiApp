import 'package:flutter/material.dart';import 'file:///F:/AndroidStudioProjects/login_signup/lib/presentation/calenderui/data.dart';import 'package:table_calendar/table_calendar.dart';class Calender extends StatefulWidget {  @override  _CalenderState createState() => _CalenderState();}class _CalenderState extends State<Calender> {     CalendarController _controller;     var dat;     void _dayselect(var x){       setState(() {         dat=x;       });     }     @override     // ignore: must_call_super     void initState() {       _controller = CalendarController();     }     @override  // ignore: missing_return  Widget build(BuildContext context) {return       Scaffold(      body: SingleChildScrollView(        child: new Column(          crossAxisAlignment: CrossAxisAlignment.start,          children: <Widget>[            TableCalendar(calendarStyle: CalendarStyle(              todayColor: Theme.of(context).primaryColor,              selectedColor: Colors.amber,            ),              headerStyle: HeaderStyle(                centerHeaderTitle: true,                headerPadding: const EdgeInsets.symmetric(vertical: 8.0),              ),              startingDayOfWeek: StartingDayOfWeek.monday,              initialCalendarFormat: CalendarFormat.month ,              calendarController: _controller,              onDaySelected: (date,events){                var formattedDate="${date.day}/${date.month}/${date.year}";                _dayselect(formattedDate);                Navigator.push(                  context,                  MaterialPageRoute(builder: (context) => Data(value : formattedDate)),);              },            ),//            Padding(//               padding: const EdgeInsets.all(10.0),//               child: Center(child: RaisedButton(child: Text('Add +'),color: Colors.amber,//                   onPressed: (){//                 Navigator.push(context, MaterialPageRoute(builder: (context) => Data(value: selDate)));//    })),//            )//          ],        ),      ),    );  }  }