import 'dart:convert';

import 'package:http/http.dart' as http;

import 'weather.dart';

class WeatherApiClient {
  static const baseUrl =
      'https://api.weatherapi.com/v1/current.json?key=c46a3f9081be4dffb30143532222508&';

  Future<String> getLocationId(String city) async {
    final locationUrl = Uri.parse('$baseUrl\q=$city');
    final locationResponse = await http.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw Exception("Error getting the id of $city");
    }

    final locationJson = jsonDecode(locationResponse.body);
    return locationJson['location']['name'];
  }

  Future<Weather> fetchWeather(String location) async {
    final weatherUrl = Uri.parse('$baseUrl\q=$location');
    final weatherResponse = await http.get(weatherUrl);
    if (weatherResponse.statusCode != 200) {
      throw Exception('Error getting weather for $location');
    }
    final weatherJson = jsonDecode(weatherResponse.body);
    final currentWeather = weatherJson['current'];
    // print(currentWeather);
    return Weather.fromJson(currentWeather);
  }

  Future<Weather> getWeather(String city) async {
    final location = await getLocationId(city);
    // print(location);
    return fetchWeather(location);
  }
}
