import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_weather_forecast_app/utils/location.dart';
import 'package:flutter_weather_forecast_app/utils/weather.dart';
import 'package:flutter_weather_forecast_app/views/main_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Image? ssimage = Image.asset(
    "lib/assets/weather-app.png",
    width: 130,
  );
  LocationHelper? data;
  Future<void> getLocationData() async {
    data = LocationHelper();
    await data!.getLocation();
    if (data!.latitude == null || data!.longitude == null) {
      debugPrint("No location information");
    } else {
      debugPrint(
          "Location information => latitude: ${data!.latitude.toString()}, longitude: ${data!.longitude.toString()}");
    }
  }

  void getWeatherData() async {
    await getLocationData();
    WeatherData weatherData = WeatherData(
      locationData: data!,
    );
    await weatherData.getCurrentTemperature();
    if (weatherData.currentTemperature == null ||
        weatherData.currentCondition == null) {
      debugPrint("Data is empty");
    } else {
      Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) {
        return MainScreen(
          weatherData: weatherData,
        );
      }));
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeatherData();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    precacheImage(ssimage!.image, context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: HexColor("15202B"),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(child: ssimage),
              SizedBox(height: 10,),
              Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white)),
                      color: Colors.transparent),
                  child: Text('Weather',
                      style: GoogleFonts.workSans(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.normal))),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05),
                child: SpinKitCircle(
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
