import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'WeatherModel.dart';

class WeatherController extends GetxController {
  var realTimeWeather = RealTimeWeatherModel().obs;
  var weatherForecast = WeatherModel().obs;
  var isLoading = true.obs;

  final String apiKey = '07e3243c2e3020426c4a3cf53d269a65';
  final String baseUrl = 'https://api.openweathermap.org/data/2.5';

  Future<void> getRealTimeWeatherByLocation(double lat, double lon) async {
    isLoading(true);
    final response = await http.get(Uri.parse('$baseUrl/weather?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      realTimeWeather.value = RealTimeWeatherModel.fromJson(json.decode(response.body));
    } else {
      Get.snackbar('Error', 'Failed to load real-time weather data');
    }
    isLoading(false);
  }

  Future<void> getWeatherForecastByLocation(double lat, double lon) async {
    isLoading(true);
    final response = await http.get(Uri.parse('$baseUrl/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      weatherForecast.value = WeatherModel.fromJson(json.decode(response.body));
    } else {
      Get.snackbar('Error', 'Failed to load weather forecast data');
    }
    isLoading(false);
  }

  Future<void> getRealTimeWeatherByCity(String city) async {
    isLoading(true);
    final response = await http.get(Uri.parse('$baseUrl/weather?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      realTimeWeather.value = RealTimeWeatherModel.fromJson(json.decode(response.body));
    } else {
      Get.snackbar('Error', 'Failed to load real-time weather data');
    }
    isLoading(false);
  }

  Future<void> getWeatherForecastByCity(String city) async {
    isLoading(true);
    final response = await http.get(Uri.parse('$baseUrl/forecast?q=$city&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      weatherForecast.value = WeatherModel.fromJson(json.decode(response.body));
    } else {
      Get.snackbar('Error', 'Failed to load weather forecast data');
    }
    isLoading(false);
  }

  // Get the forecast for tomorrow
  List<HourlyForecast> getTomorrowForecast() {
    final forecasts = weatherForecast.value.hourlyForecast;
    final tomorrowDate = DateTime.now().add(Duration(days: 1)).toIso8601String().split('T')[0];
    return forecasts.where((forecast) => forecast.dateTime.startsWith(tomorrowDate)).toList();
  }

  // Get the forecast for the week
  Map<String, List<HourlyForecast>> getWeeklyForecast() {
    final forecasts = weatherForecast.value.hourlyForecast;
    final weeklyForecast = <String, List<HourlyForecast>>{};

    for (var forecast in forecasts) {
      final date = forecast.dateTime.split(' ')[0];
      if (weeklyForecast.containsKey(date)) {
        weeklyForecast[date]!.add(forecast);
      } else {
        weeklyForecast[date] = [forecast];
      }
    }

    return weeklyForecast;
  }
}

