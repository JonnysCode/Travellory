import 'package:flutter/material.dart';
import 'package:travellory/src/services/api/open_weather.dart';

class WeatherProvider extends ChangeNotifier {
  WeatherProvider(OpenWeatherAPI weatherAPI, String city) {
    _openWeatherAPI = weatherAPI;
    _city = city;
  }

  String temperature;
  String description;
  OpenWeatherAPI _openWeatherAPI;
  String _city;

  Future<void> initWeather() async {
    await _openWeatherAPI.getWeather(_city);
    temperature = _openWeatherAPI.temperature;
    description = _openWeatherAPI.description;
    notifyListeners();
  }
}
