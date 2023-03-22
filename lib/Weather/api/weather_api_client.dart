import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:traveller/Weather/api/http_exception.dart';
import 'package:traveller/Weather/model/weather.dart';

class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  final apiKey;
  final http.Client httpClient;

  WeatherApiClient({@required this.httpClient, this.apiKey})
      : assert(httpClient != null),
        assert(apiKey != null);

  Future<String> getCityNameFromLocation(
      {double latitude, double longitude}) async {
    final url = Uri.parse(
        '$baseUrl/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey');
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return weatherJson['name'];
  }

  Future<Weather> getWeatherData(String cityName) async {
    final url =
        Uri.parse('$baseUrl/data/2.5/weather?q=$cityName&appid=$apiKey');
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final weatherJson = json.decode(res.body);
    return Weather.fromJson(weatherJson);
  }

  Future<List<Weather>> getForecast(String cityName) async {
    final url =
        Uri.parse('$baseUrl/data/2.5/forecast?q=$cityName&appid=$apiKey');
    final res = await this.httpClient.get(url);
    if (res.statusCode != 200) {
      throw HTTPException(res.statusCode, "unable to fetch weather data");
    }
    final forecastJson = json.decode(res.body);
    List<Weather> weathers = Weather.fromForecastJson(forecastJson);
    return weathers;
  }
}
