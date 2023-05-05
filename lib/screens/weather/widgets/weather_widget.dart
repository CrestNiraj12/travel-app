import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:traveller/screens/weather/model/weather.dart';
import 'package:traveller/screens/weather/widgets/value_tile.dart';
import 'package:traveller/screens/weather/widgets/weather_swipe_pager.dart';

import 'forecast_horizontal_widget.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  WeatherWidget({required this.weather});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            (this.weather.cityName ?? 'Kathmandu').toUpperCase(),
            style: TextStyle(
              fontWeight: FontWeight.w900,
              letterSpacing: 5,
              color: Color.fromRGBO(0, 0, 0, 1),
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            (this.weather.description ?? '').toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.w100,
                letterSpacing: 5,
                fontSize: 15,
                color: Colors.black),
          ),
          WeatherSwipePager(weather: weather),
          Padding(
            child: Divider(
              color: Colors.black.withAlpha(50),
            ),
            padding: EdgeInsets.all(10),
          ),
          ForecastHorizontal(weathers: weather.forecast ?? []),
          Padding(
            child: Divider(
              color: Colors.black.withAlpha(50),
            ),
            padding: EdgeInsets.all(5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ValueTile("wind speed", '${this.weather.windSpeed} m/s'),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Center(
                    child: Container(
                  width: 1,
                  height: 30,
                  color: Colors.black.withAlpha(50),
                )),
              ),
              ValueTile(
                  "sunrise",
                  DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          (this.weather.sunrise ?? 0) * 1000))),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Center(
                    child: Container(
                  width: 1,
                  height: 30,
                  color: Colors.black.withAlpha(50),
                )),
              ),
              ValueTile(
                  "sunset",
                  DateFormat('hh:mm a').format(
                      DateTime.fromMillisecondsSinceEpoch(
                          (this.weather.sunset ?? 0) * 1000))),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Center(
                  child: Container(
                    width: 1,
                    height: 30,
                    color: Colors.black.withAlpha(50),
                  ),
                ),
              ),
              ValueTile("humidity", '${this.weather.humidity}%'),
            ],
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
