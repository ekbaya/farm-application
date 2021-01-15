import 'package:farm_app/models/Farmer.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CalenderPage extends StatefulWidget {
  Farmer farmer;
  CalenderPage({this.farmer});
  @override
  _CalenderPageState createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.farmer.name+"'s Calender"),
      ),
      
    );
  }
}