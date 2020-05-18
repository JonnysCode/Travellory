import 'package:http/http.dart' as http;
import 'dart:convert';

class OpenWeatherAPI {

  var result;

  String get temperature {
    if(result == null || result['main']){
      return null;
    }
    var temperature = result['main']['temp'];
    temperature = (temperature - 273.15).toStringAsFixed(1);
    return temperature;
  }

  String get description {
    if(result == null || result['weather'] == null){
      return null;
    }
    var description = result['weather'][0]['description'];
    return description;
  }

  Future<void> getWeather(String city) async {
    http.Response response = await http.get(
        'https://api.openweathermap.org/data/2.5/weather?q=$city&APPID=c27dae6ae632670cbed96f9173b8529f');
    result = json.decode(response.body);
  }
}