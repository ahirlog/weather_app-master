// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class CityScreen extends StatefulWidget {
  @override
  _CityScreenState createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  late String cityName;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff2F52A5),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Weather Forecast",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            children: <Widget>[
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                    color: Color(0xff4362AD),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: TextField(
                  style: TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    icon: Icon(
                      Icons.location_city_rounded,
                      size: 35,
                      color: Color(0xffFFD059),
                    ),
                    hintText: 'Enter City Name',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (value) {
                    cityName = value;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 90, vertical: 12),
                  primary: Color(0xffFFD059),
                  // padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  // textStyle: TextStyle(
                  // fontSize: 30,
                  // fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, cityName);
                },
                child: Text(
                  'Get Weather',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
