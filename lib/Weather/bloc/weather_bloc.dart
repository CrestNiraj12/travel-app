import 'package:bloc/bloc.dart';
import 'package:traveller/Weather/api/http_exception.dart';
import 'package:traveller/Weather/bloc/weather_event.dart';
import 'package:traveller/Weather/bloc/weather_state.dart';
import 'package:traveller/Weather/model/weather.dart';
import 'package:traveller/Weather/repository/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository, {WeatherState initialState})
      : super(WeatherEmpty());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield WeatherLoading();
      try {
        final Weather weather = await weatherRepository.getWeather(
            event.cityName,
            latitude: event.latitude,
            longitude: event.longitude);
        yield WeatherLoaded(weather: weather);
      } catch (exception) {
        print(exception);
        if (exception is HTTPException) {
          yield WeatherError(errorCode: exception.code);
        } else {
          yield WeatherError(errorCode: 500);
        }
      }
    }
  }
}
