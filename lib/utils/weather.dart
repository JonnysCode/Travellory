import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travellory/services/api/openWeatherAPI.dart';

class Weather extends StatefulWidget {
  Weather(this.location);
  final String location;

  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

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

  String cutDestinationName(String destination) {
    List firstWord;
    firstWord = destination.split(',');
    return firstWord[0];
  }

  @override
  void initState() {
    super.initState();
    OpenWeatherAPI.getWeather(widget.location);
  }

  @override
  Widget build(BuildContext context) {
    // TODO DELETE
    print(OpenWeatherAPI.getTemperature());
    print(OpenWeatherAPI.getDescription());
    print(widget.location);
    OpenWeatherAPI.getWeather(widget.location);

    return Stack(
        key: Key('weather_page'),
        children: <Widget>[
      Positioned(
        left: 25,
        top: 15,
        child: Image(
          height: 100,
          image: AssetImage(selectImage(OpenWeatherAPI.getDescription())),
        ),
      ),
      OpenWeatherAPI.getTemperature() != null
          ? Positioned(
              top: 70,
              left: 100,
              child: Text(
                OpenWeatherAPI.getTemperature().toString() + '\u00B0',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          : Container(),
          OpenWeatherAPI.getTemperature() != null
          ? Positioned(
              top: 107,
              left: 20,
              child: Container(
                  height: 30,
                  width: 140,
                  child: Center(
                    child: AutoSizeText(
                      cutDestinationName(widget.location),
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'FashionFetish',
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
