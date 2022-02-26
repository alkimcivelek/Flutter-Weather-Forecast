import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast_app/utils/location.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';

const apiKey = '48fd18acd989acf3c98457e127f1cc6d';

class DisplayWeatherData {
  final AssetImage weatherIcon;
  final Color backgroundColor;

  DisplayWeatherData(
      {required this.weatherIcon, required this.backgroundColor});
}

class WeatherData {
  WeatherData({
    required this.locationData,
  });
  final LocationHelper locationData;
  double? currentTemperature;
  int? currentCondition;
  String? city;
  String? country;
  double? maxTemp;
  double? minTemp;
  String? weather;

  Future<void> getCurrentTemperature() async {
    Response response = await get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=${locationData.latitude}&lon=${locationData.longitude}&appid=${apiKey}&units=metric"));

    if (response.statusCode == 200) {
      String data = response.body;
      dynamic currentWeather = json.decode(data);
      try {
        currentTemperature = currentWeather['main']['temp'];
        currentCondition = currentWeather['weather'][0]['id'];
        city = currentWeather['name'];
        country = currentWeather['sys']['country'];
        maxTemp = currentWeather['main']['temp_max'];
        minTemp = currentWeather['main']['temp_min'];
        weather = currentWeather['weather'][0]['main'];
      } catch (e) {
        debugPrint("Error: " + e.toString());
      }
    } else {
      debugPrint("No Data.");
    }
  }

  DisplayWeatherData getWeatherDisplayData() {
    if (currentCondition! == 800) {
      return DisplayWeatherData(
          weatherIcon: AssetImage("lib/assets/sun.png"),
          backgroundColor: HexColor("15202B"));
    }
    if (currentCondition! >= 500 && currentCondition! < 600) {
      return DisplayWeatherData(
          weatherIcon: AssetImage("lib/assets/rain.png"),
          backgroundColor: HexColor("15202B"));
    }
    if (currentCondition! < 700 || currentCondition! > 800) {
      return DisplayWeatherData(
          weatherIcon: AssetImage("lib/assets/cloud.png"),
          backgroundColor: HexColor("15202B"));
    } else {
      return DisplayWeatherData(
          weatherIcon: AssetImage("lib/assets/cloud.png"),
          backgroundColor: HexColor("15202B"));
    }
  }
}
