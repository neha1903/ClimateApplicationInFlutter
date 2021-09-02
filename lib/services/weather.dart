import 'package:clima_app/services/location.dart';
import 'package:clima_app/services/networking.dart';
import 'package:clima_app/utilities/constants.dart';

class WeatherModel {
  Future getWeatherByCityName(String city) async {
    var urlString = '$IP?q=$city&appid=$appId&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: urlString);
    return await networkHelper.getData();
  }

  Future getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();
    var urlString =
        '$IP?lat=${location.getLatitude()}&lon=${location.getLongitude()}&appid=$appId&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url: urlString);
    return await networkHelper.getData();
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
