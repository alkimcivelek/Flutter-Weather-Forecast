import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast_app/views/loading_screen.dart';
import 'package:flutter_weather_forecast_app/views/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: 'Weather Forecast',
        home: LoadingScreen());
  }
}
