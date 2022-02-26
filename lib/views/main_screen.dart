import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast_app/utils/weather.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key? key, required this.weatherData}) : super(key: key);
  final WeatherData weatherData;
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? temperature;
  String? weatherIcon;
  Color? backgroundImage;
  String? city;
  String? country;
  int? maxTemp;
  int? minTemp;
  String? weather;
  void updateDisplayInfo(WeatherData data) {
    setState(() {
      temperature = data.currentTemperature!.round();
      DisplayWeatherData displayWeatherData = data.getWeatherDisplayData();
      backgroundImage = displayWeatherData.backgroundColor;
      weatherIcon = displayWeatherData.weatherIcon.assetName;
      city = data.city;
      country = data.country;
      maxTemp = data.maxTemp!.round();
      minTemp = data.minTemp!.round();
      weather = data.weather;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: backgroundImage,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'TODAY',
                      style: GoogleFonts.workSans(
                          fontSize: 20,
                          color: Colors.white,
                          letterSpacing: 3,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  '$city',
                  style: GoogleFonts.workSans(
                      fontSize: 45,
                      color: Colors.white,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w300),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  '$country',
                  style: GoogleFonts.workSans(
                      fontSize: 25,
                      color: Colors.white,
                      letterSpacing: 3,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 20.0),
                      child: Image.asset(weatherIcon!, height: 70),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$temperature',
                          style: GoogleFonts.workSans(
                              fontSize: 60,
                              color: Colors.white,
                              letterSpacing: 3,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          '°C',
                          style: GoogleFonts.workSans(
                              fontSize: 60,
                              color: Colors.white,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    VerticalDivider(
                      color: Colors.white.withOpacity(0.3),
                      width: 40,
                      thickness: 1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            'Max: $maxTemp',
                            style: GoogleFonts.workSans(
                                fontSize: 12,
                                color: Colors.white,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            'Min: $minTemp',
                            style: GoogleFonts.workSans(
                                fontSize: 12,
                                color: Colors.white,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '$weather',
                            style: GoogleFonts.workSans(
                                fontSize: 12,
                                color: Colors.white,
                                letterSpacing: 3,
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
