import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Weather extends StatefulWidget {
  Weather(this.location);

  final String location;

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  var temperature;
  var description;

  Future getWeather(String city) async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=c27dae6ae632670cbed96f9173b8529f');
    var result = jsonDecode(response.body);
    setState(() {
      this.temperature = result['main']['temp'];
      temperature = (temperature - 273.15).toStringAsFixed(1);
      this.description = result['weather'][0]['description'];
    });
  }

  String selectImage(String description) {
    String path;
    switch (description) {
      case 'clear sky':
        path = 'assets/images/home/weather/041-clear_sky.png';
        break;
      case 'few clouds':
        path = 'assets/images/home/weather/011-few_clouds.png';
        break;
      case 'scattered clouds':
        path = 'assets/images/home/weather/013-scattered_clouds.png';
        break;
      case 'broken clouds':
        path = 'assets/images/home/weather/025-broken_clouds.png';
        break;
      case 'overcast clouds':
        path = 'assets/images/home/weather/014-overcast_cloud.png';
        break;
      case 'shower rain':
        path = 'assets/images/home/weather/060-shower_rain.png';
        break;
      case 'rain':
        path = 'assets/images/home/weather/002-rain.png';
        break;
      case 'thunderstorm':
        path = 'assets/images/home/weather/003-thunderstorm.png';
        break;
      case 'snow':
        path = 'assets/images/home/weather/033-snow.png';
        break;
      case 'mist':
        path = 'assets/images/home/weather/016-mist.png';
        break;
      case 'haze':
        path = 'assets/images/home/weather/016-mist.png';
        break;
      default:
        path = 'assets/images/home/weather/011-few_clouds.png';
        break;
    }
    return path;
  }

  @override
  void initState() {
    super.initState();
    getWeather(widget.location);
  }

  @override
  Widget build(BuildContext context) {
    print(temperature);
    print(description);
    print(widget.location);
    getWeather(widget.location);
    return Stack(children: <Widget>[
      Positioned(
        left: 25,
        top: 15,
        child: Image(
          height: 100,
          image: AssetImage(selectImage(description)),
        ),
      ),
      temperature != null
          ? Positioned(
              top: 70,
              left: 100,
              child: Text(
                temperature.toString() + '\u00B0',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : Container(),
      temperature != null
          ? Positioned(
              top: 107,
              left: 20,
              child: Container(
                  height: 30,
                  width: 140,
                  child: Center(
                    child: AutoSizeText(
                      widget.location,
                      style: TextStyle(
                        fontSize: 24.0,
                        //fontFamily: 'FashionFetish',
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: 1,
                    ),
                  )),
            )
          : Container(),
    ]);
  }
}
