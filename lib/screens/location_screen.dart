// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_typing_uninitialized_variables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:weather_app/services/weather.dart';
import 'city_screen.dart';
import 'package:intl/intl.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.locationWeather});

  final locationWeather;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  late int temperature;
  late String weatherIcon;
  late String cityName;
  late String weatherMessage;

  late String formattedDate;

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);

    // Current Date
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    formattedDate = formatter.format(now);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        temperature = 0;
        weatherIcon = 'Error';
        weatherMessage = 'Unable to get weather data';
        cityName = '';
        return;
      }

      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff2F52A5),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "Weather Forecast",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ),
        body: Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(left: 10, right: 10, top: 10),
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Color(0xff4362AD),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Today',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            formattedDate.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: Row(
                          children: <Widget>[
                            RichText(
                              // textAlign: TextAlign.center,
                              text: TextSpan(children: <TextSpan>[
                                TextSpan(
                                    text: "$temperature",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 50)),
                                TextSpan(
                                    text: "°C   ",
                                    style: TextStyle(
                                        color: Color(0xffF6C32B),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                              ]),
                            ),
                            Text(weatherIcon,
                                style: TextStyle(
                                  fontSize: 100.0,
                                )),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(
                                child: Icon(Icons.location_on,
                                    color: Color(0xffF3C02A), size: 25),
                              ),
                              TextSpan(
                                  text: " $cityName",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  )),
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 20),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 5),
                decoration: BoxDecoration(
                    color: Color(0xff4362AD),
                    borderRadius: BorderRadius.all(Radius.circular(15))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      splashColor: Colors.greenAccent,
                      onPressed: () async {
                        var weatherData = await weather.getLocationWeather();
                        updateUI(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 40.0,
                        color: Colors.white,
                      ),
                    ),
                    FlatButton(
                      splashColor: Colors.greenAccent,
                      onPressed: () async {
                        var typedName = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return CityScreen();
                            },
                          ),
                        );
                        if (typedName != null) {
                          var weatherData =
                              await weather.getCityWeather(typedName);
                          updateUI(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 40.0,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 75, vertical: 50),
                child: Text(
                  '$weatherMessage',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
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
