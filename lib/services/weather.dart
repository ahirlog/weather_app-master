import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

const apiKey = 'Your_API_Key';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
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
      return "🚫‍";
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Ice is most welcome in a cold drink on a hot day.';
    } else if (temp > 20) {
      return 'Good time for shorts and t shirts.';
    } else if (temp < 10) {
      return 'The fire is winter’s fruit.';
    } else {
      return 'I love being in a city with great weather.';
    }
  }
}
