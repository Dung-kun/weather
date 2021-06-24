import 'package:get/get.dart';
import 'package:weatherproject/controller/ForecastController.dart';
import 'package:weatherproject/service/ForecastService.dart';

class WeatherBinding extends Bindings {
  @override
  void dependencies() {
    //Service
    Get.put(ForecastService());
    Get.put(ForecastController());
  }
}