
import 'package:weatherproject/API/connectAPI.dart';
import 'package:weatherproject/model/Forecast.dart';

class ForecastService {
  Future<Forecast> getWeather(String city) async {
    final ConnectApi connectApi= ConnectApi();
    final location = await connectApi.getLocation(city);
    return await connectApi.getWeather(location);
  }
}