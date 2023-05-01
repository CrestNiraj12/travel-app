import 'package:flutter/material.dart';
import 'package:traveller/weather/utils/converters.dart';
import 'package:weather_icons/weather_icons.dart';

class Weather {
  int? id;
  int? time;
  int? sunrise;
  int? sunset;
  int? humidity;

  String? description;
  String? iconCode;
  String? main;
  String? cityName;

  double? windSpeed;

  Temperature? temperature;
  Temperature? maxTemperature;
  Temperature? minTemperature;

  List<Weather>? forecast;

  Weather({
    this.id,
    this.time,
    this.sunrise,
    this.sunset,
    this.humidity,
    this.description,
    this.iconCode,
    this.main,
    this.cityName,
    this.windSpeed,
    this.temperature,
    this.maxTemperature,
    this.minTemperature,
    this.forecast,
  });

  static Weather fromJson(Map<String, dynamic> json) {
    final weather = json['weather'][0];
    return Weather(
      id: weather['id'],
      time: json['dt'],
      description: weather['description'],
      iconCode: weather['icon'],
      main: weather['main'],
      cityName: json['name'],
      temperature: Temperature(intToDouble(json['main']['temp'])),
      maxTemperature: Temperature(intToDouble(json['main']['temp_max'])),
      minTemperature: Temperature(intToDouble(json['main']['temp_min'])),
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      humidity: json['main']['humidity'],
      windSpeed: intToDouble(json['wind']['speed']),
    );
  }

  static List<Weather> fromForecastJson(Map<String, dynamic> json) {
    final weathers = <Weather>[];
    for (final item in json['list']) {
      weathers.add(Weather(
          time: item['dt'],
          temperature: Temperature(intToDouble(
            item['main']['temp'],
          )),
          iconCode: item['weather'][0]['icon']));
    }
    return weathers;
  }

  IconData getIconData() {
    switch (this.iconCode) {
      case '01d':
        return WeatherIcons.day_sunny;
      case '01n':
        return WeatherIcons.night_clear;
      case '02d':
        return WeatherIcons.cloud;
      case '02n':
        return WeatherIcons.cloud;
      case '03d':
      case '04d':
        return WeatherIcons.day_cloudy;
      case '03n':
      case '04n':
        return WeatherIcons.night_clear;
      case '09d':
        return WeatherIcons.day_showers;
      case '09n':
        return WeatherIcons.night_showers;
      case '10d':
        return WeatherIcons.day_rain;
      case '10n':
        return WeatherIcons.night_rain;
      case '11d':
        return WeatherIcons.day_thunderstorm;
      case '11n':
        return WeatherIcons.night_thunderstorm;
      case '13d':
        return WeatherIcons.day_snow;
      case '13n':
        return WeatherIcons.night_snow;
      case '50d':
        return WeatherIcons.day_fog;
      case '50n':
        return WeatherIcons.night_fog;
      default:
        return WeatherIcons.day_sunny;
    }
  }
}
