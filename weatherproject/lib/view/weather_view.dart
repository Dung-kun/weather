import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weatherproject/controller/ForecastController.dart';
import 'package:weatherproject/model/Weather.dart';
import 'package:weatherproject/service/ForecastService.dart';
import 'package:weatherproject/view/LocationView.dart';
import 'package:weatherproject/view/SreachView.dart';
import 'package:weatherproject/view/WeatherSummaryView.dart';
import 'package:weatherproject/view/supportView.dart/gradient_container.dart';

import 'DailySummaryView.dart';
import 'DescriptionView.dart';
import 'LastUpdateView.dart';

class WeatherView extends StatelessWidget{
  final _controller = Get.find<ForecastController>();
  final forecastservice = Get.find<ForecastService>();

  @override
  Widget build(BuildContext context) {
    _controller.start();
    return Scaffold(
        body: 
        Stack(
          children: [
            Obx(() => _buildGradientContainer(
                _controller.condition.value,
                 _controller.isDayTime.value),
            ),
            buildHomeView(context), 
          ],
        )
    );
  }

  Widget buildHomeView(BuildContext context) {
    return  Container(
            height: MediaQuery.of(context).size.height,
            child: RefreshIndicator(
                color: Colors.transparent,
                backgroundColor: Colors.transparent,
                onRefresh: () => refreshWeather(context),
                child: ListView(
                  children: <Widget>[
                  SearchView(),
                    _controller.isRequestError.value
                          ? Center(
                                child: Text('Ooops...something went wrong',
                                    style: TextStyle(
                                        fontSize: 21, color: Colors.white)
                                        )
                                      )
                            : Obx(() => Column(children: [
                                LocationView(
                                  longitude: _controller.longitude.value,
                                  latitude: _controller.latitude.value,
                                  city: _controller.city.value,
                              
                                ),
                                SizedBox(height: 50),
                                WeatherSummary(
                                    condition: _controller.condition.value,
                                    temp: _controller.temp.value,
                                    feelsLike: _controller.feelsLike.value,
                                    isdayTime: _controller.isDayTime.value
                                
                                ),
                                SizedBox(height: 20),
                                 WeatherDescriptionView(
                                    weatherDescription:
                                        _controller.description.value
                                
                                ),
                                SizedBox(height: 140),
                                buildDailySummary(_controller.daily.value),
                                LastUpdatedView(
                                    lastUpdatedOn:
                                        _controller.lastUpdated.value
                                
                                )
                              ]
                          ),
                      ),
                  ],
                )
              )
          );
  }

  Widget buildBusyIndicator() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, 
      children: [
      CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white)),
      SizedBox(
        height: 20,
      ),
      Text('Please Wait...',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w300,
          )
        )
      ]
    );
  }

  Widget buildDailySummary(List<Weather> dailyForecast) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: dailyForecast
            .map((item) => new DailySummaryView(
                  weather: item,
                ))
            .toList());
  }

  Future<void> refreshWeather(BuildContext context) async{
    return await _controller.getLatestWeather(_controller.city.value);
  }

  GradientContainer _buildGradientContainer(
      WeatherCondition condition, bool isDayTime) {
    GradientContainer container;
    if (!isDayTime)
      container = GradientContainer(color: Colors.blueGrey,
      );
    else {
      switch (condition) {
        case WeatherCondition.clear:
        case WeatherCondition.lightCloud:
          container = GradientContainer(color: Colors.yellow);
          break;
        case WeatherCondition.fog:
        case WeatherCondition.atmosphere:
        case WeatherCondition.rain:
        case WeatherCondition.drizzle:
        case WeatherCondition.mist:
        case WeatherCondition.heavyCloud:
          container = GradientContainer(color: Colors.indigo);
          break;
        case WeatherCondition.snow:
          container = GradientContainer(color: Colors.lightBlue);
          break;
        case WeatherCondition.thunderstorm:
          container = GradientContainer(color: Colors.deepPurple);
          break;
        default:
          container = GradientContainer(color: Colors.lightBlue);
      }
    }

    return container;
  }
}