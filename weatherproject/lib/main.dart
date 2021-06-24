import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherproject/view/weather_view.dart';
import 'controller/WeatherBinding.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Thời tiết',
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      getPages: [
        GetPage(name: "WeatherView", page: () => WeatherView(), binding: WeatherBinding()),
      ],
      initialRoute: "WeatherView",
    );
  }
}
