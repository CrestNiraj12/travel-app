import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:traveller/weather/model/weather.dart';
import 'package:traveller/weather/widgets/temperature_line_chart.dart';

import 'current_conditions.dart';
import 'empty_widget.dart';

class WeatherSwipePager extends StatelessWidget {
  const WeatherSwipePager({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: Swiper(
        itemCount: 2,
        index: 0,
        itemBuilder: (context, index) {
          if (index == 0) {
            return CurrentConditions(
              weather: weather,
            );
          } else if (index == 1) {
            return TemperatureLineChart(
              weather.forecast,
              animate: true,
            );
          }
          return EmptyWidget();
        },
        pagination: SwiperPagination(
          margin: EdgeInsets.all(5.0),
          builder: DotSwiperPaginationBuilder(
            size: 5,
            activeSize: 5,
            color: Colors.black.withOpacity(0.4),
            activeColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
