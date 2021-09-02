import 'package:clima_app/services/weather.dart';
import 'package:clima_app/utilities/constants.dart';
import 'package:clima_app/screens/city_screen.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LocationScreen extends StatefulWidget {
  late final locationWeather;
  LocationScreen({required this.locationWeather});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();
  var temp,
      condition,
      city,
      description,
      main,
      tempMin,
      tempMax,
      weatherDescription,
      weatherIcon,
      weatherData;
  @override
  void initState() {
    super.initState();
    weatherData = widget.locationWeather;
    updateUI(weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        Alert(
          context: context,
          title: "Alert",
          desc: "Trouble getting location",
        ).show();
        return;
      } else {
        double temperature = weatherData['main']['temp'];
        temp = temperature.toInt();
        tempMin = weatherData['main']['temp_min'];
        tempMax = weatherData['main']['temp_max'];
        description = weatherData['weather'][0]['description'];
        main = weatherData['weather'][0]['main'];
        condition = weatherData['weather'][0]['id'];
        city = weatherData['name'];
        weatherDescription = "${weatherModel.getMessage(temp)} \n $city!";
        weatherIcon = weatherModel.getWeatherIcon(condition);
      }
    });
  }

  void getCurrentLocationData() async {
    weatherData = await weatherModel.getLocationWeather();
    updateUI(weatherData);
  }

  void moveToCityScreen() async {
    var typedName = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CityScreen();
        },
      ),
    );
    var weatherData = await weatherModel.getWeatherByCityName(typedName);
    updateUI(weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpeg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.5),
              BlendMode.dstATop,
            ),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          getCurrentLocationData();
                        });
                      },
                      icon: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        moveToCityScreen();
                      },
                      icon: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    weatherIcon,
                    style: kConditionTextStyle,
                  ),
                  Text(
                    '$temp°',
                    style: kTempTextStyle,
                  ),
                  Text(
                    main,
                    style: kTextStyle,
                  ),
                  Text(
                    description,
                    style: kText1Style,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "↓$tempMin°",
                        style: kText2Style,
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        '↑$tempMax°',
                        style: kText2Style,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  weatherDescription,
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
