import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:traveller/screens/weather/api/api_keys.dart';
import 'package:traveller/screens/weather/api/weather_api_client.dart';
import 'package:traveller/screens/weather/bloc/weather_bloc.dart';
import 'package:traveller/screens/weather/bloc/weather_event.dart';
import 'package:traveller/screens/weather/bloc/weather_state.dart';
import 'package:traveller/screens/weather/repository/weather_repository.dart';
import 'package:traveller/screens/weather/widgets/weather_widget.dart';
import 'package:traveller/utils/colors.dart';

class Weather extends StatefulWidget {
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
      apiKey: ApiKey.OPEN_WEATHER_MAP,
    ),
  );
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  late WeatherBloc _weatherBloc;
  late TextEditingController _textController;
  late Position position;

  @override
  void initState() {
    super.initState();
    _weatherBloc = WeatherBloc(
      widget.weatherRepository,
      initialState: WeatherLoading(),
    );
    _textController = TextEditingController(text: 'Kathmandu');

    _fetchWeatherWithLocation().catchError((error) {
      _fetchWeatherWithCity();
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.blue,
          elevation: 0,
          title: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                style: TextStyle(color: Colors.white, fontSize: 14),
              )
            ],
          ),
          actions: <Widget>[
            BlocBuilder(
              bloc: _weatherBloc,
              builder: (_, WeatherState weatherState) {
                return Container(
                  margin: EdgeInsets.only(right: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.my_location,
                      size: 25,
                      color: Colors.white,
                    ),
                    onPressed: (weatherState is WeatherLoading ||
                            weatherState is WeatherEmpty)
                        ? null
                        : _showCityChangeDialog,
                  ),
                );
              },
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: Material(
          child: Container(
              constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 30.0,
                  ),
                  BlocBuilder(
                    bloc: _weatherBloc,
                    builder: (_, WeatherState weatherState) {
                      if (weatherState is WeatherLoading ||
                          weatherState is WeatherEmpty) {
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: AppColors.blue,
                          ),
                        );
                      } else if (weatherState is WeatherLoaded) {
                        _textController.text =
                            weatherState.weather.cityName ?? '';
                        return WeatherWidget(
                          weather: weatherState.weather,
                        );
                      } else if (weatherState is WeatherError) {
                        String errorText =
                            'There was an error fetching weather data';
                        if (weatherState.errorCode == 404) {
                          errorText =
                              'We have trouble fetching weather for ${_textController.text}';
                        }
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: Colors.redAccent,
                              size: 24,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              errorText,
                              style: TextStyle(color: Colors.redAccent),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18.0),
                                ),
                                side: BorderSide(
                                  color: AppColors.blue,
                                ),
                              ),
                              child: Text(
                                "Try Again",
                                style: TextStyle(color: AppColors.blue),
                              ),
                              onPressed: _fetchWeatherWithCity,
                            ),
                            FilledButton(
                              style: FilledButton.styleFrom(
                                backgroundColor: AppColors.blue,
                              ),
                              child: Text(
                                "Reset",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: _fetchDefaultWeather,
                            )
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              )),
        ));
  }

  void _showCityChangeDialog() {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text('Change city', style: TextStyle(color: Colors.black)),
            actions: <Widget>[
              FilledButton(
                child: Text(
                  'ok',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
                onPressed: () {
                  _fetchWeatherWithCity();
                  Navigator.of(context).pop();
                },
              ),
            ],
            content: TextField(
              autofocus: true,
              controller: _textController,
              decoration: InputDecoration(
                  hintText: 'Name of your city',
                  hintStyle: TextStyle(color: Colors.black),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _fetchWeatherWithLocation().catchError((error) {
                        _fetchWeatherWithCity();
                      });
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.my_location,
                      color: Colors.black,
                      size: 16,
                    ),
                  )),
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black,
            ),
          );
        });
  }

  _fetchWeatherWithCity() {
    if (_textController.text.isEmpty)
      _fetchDefaultWeather();
    else
      _weatherBloc.add(FetchWeather(cityName: _textController.text));
  }

  _fetchWeatherWithLocation() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    _weatherBloc.add(
      FetchWeather(
        longitude: position.longitude,
        latitude: position.latitude,
      ),
    );
  }

  void _fetchDefaultWeather() {
    _weatherBloc.add(
      FetchWeather(
        longitude: position.longitude,
        latitude: position.latitude,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
