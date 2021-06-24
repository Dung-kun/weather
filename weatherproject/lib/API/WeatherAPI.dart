import 'package:weatherproject/model/Forecast.dart';
import 'package:weatherproject/model/location.dart';

abstract class WeatherApi {
  Future<Forecast> getWeather(Location location);
  Future<Location> getLocation(String city);
}