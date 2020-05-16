import 'dart:convert';

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
    switch (description) {
      case 'clear sky':
        return 'assets/images/home/weather/041-clear_sky.png';
        break;
      case 'few clouds':
        return 'assets/images/home/weather/011-few_clouds.png';
        break;
      case 'scattered clouds':
        return 'assets/images/home/weather/013-scattered_clouds.png';
        break;
      case 'broken clouds':
        return 'assets/images/home/weather/025-broken_clouds.png';
        break;
      case 'overcast clouds':
        return 'assets/images/home/weather/014-overcast_cloud.png';
        break;
      case 'shower rain':
        return 'assets/images/home/weather/060-shower_rain.png';
        break;
      case 'rain':
        return 'assets/images/home/weather/002-rain.png';
        break;
      case 'thunderstorm':
        return 'assets/images/home/weather/003-thunderstorm.png';
        break;
      case 'snow':
        return 'assets/images/home/weather/033-snow.png';
        break;
      case 'mist':
        return 'assets/images/home/weather/016-mist.png';
        break;
    }
    return '';
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
    return Positioned(
      left: 30,
      top: 30,
      child: Column(
        children: <Widget>[
          Image(
            height: 100,
            image: AssetImage(selectImage(description)),
          ),
          Text(
            widget.location,
            style: TextStyle(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            temperature.toString() + '\u00B0',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black87,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
