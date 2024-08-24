import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';

import 'Weather_Controller.dart';

class WeatherApp extends StatelessWidget {
  final WeatherController weatherController = Get.put(WeatherController());

  void requestLocationPermission() async {
    PermissionStatus status = await Permission.location.request();
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      weatherController.getRealTimeWeatherByLocation(
          position.latitude, position.longitude);
      weatherController.getWeatherForecastByLocation(
          position.latitude, position.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    requestLocationPermission();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text('Weather App',style: TextStyle(color: Colors.white),),
          actions: [
            IconButton(
              icon: Icon(Icons.search,color: Colors.white,),
              onPressed: () {
                Get.defaultDialog(
                  title: "Search City",
                  content: TextField(
                    onSubmitted: (value) {
                      weatherController.getRealTimeWeatherByCity(value);
                      weatherController.getWeatherForecastByCity(value);
                      Get.back();
                    },
                  ),
                );
              },
            ),
          ],
        ),
        body: Obx(() {
          if (weatherController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              children:[
            Positioned.fill(
            child: Image.asset(
              'assets/Image/bg.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
          child: Column(
          children: [
          // Real-Time Weather Information
          Center(
          child: Card(
          color:Colors.transparent ,
          child: Container(

          width: 330,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Container(
          child: Image.network(

          'http://openweathermap.org/img/wn/${weatherController.realTimeWeather.value.icon}@2x.png',

          errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.error);
          },
          ),
          ),
          Text(
          weatherController.realTimeWeather.value.cityName,
          style: TextStyle(fontSize: 30,color: Colors.white),
          ),
          Text(
          '${weatherController.realTimeWeather.value.temperature}°C',
          style: TextStyle(fontSize: 50,color: Colors.white),
          ),
          Text(
          weatherController.realTimeWeather.value.description,
          style: TextStyle(fontSize: 20,color: Colors.white),
          ),

          ],
          ),
          ),
          ),
          ),
          SizedBox(height: 20),

          // 3-Hour Forecast Horizontal List
          Card(
          color: Colors.transparent,
          child: Container(
          height: 150,
          child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherController.weatherForecast.value.hourlyForecast.length,
          itemBuilder: (context, index) {
          final forecast = weatherController.weatherForecast.value.hourlyForecast[index];
          return Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(forecast.dateTime.split(' ')[1],style: TextStyle(color: Colors.white),), // Time
          Image.network(
          'http://openweathermap.org/img/wn/${forecast.icon}@2x.png',
          height: 50,
          /*color: Colors.white*/
          ),
          Text('${forecast.temperature}°C',style: TextStyle(color: Colors.white),),
          Text(forecast.description,style: TextStyle(color: Colors.white),),
          ],
          ),
          );
          },
          ),
          ),
          ),

          // Tomorrow's Forecast
          Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          'Tomorrow\'s Forecast',
          style: TextStyle(fontSize: 24,color: Colors.white),
          ),
          SizedBox(height: 10),
          Card(
            color: Colors.transparent,
          child: Container(
          height: 150,
          child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: weatherController.getTomorrowForecast().length,
          itemBuilder: (context, index) {
          final forecast = weatherController.getTomorrowForecast()[index];
          return Container(
          width: 100,
          margin: EdgeInsets.all(8.0),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(forecast.dateTime.split(' ')[1],style: TextStyle(color: Colors.white),), // Time
          Image.network(
          'http://openweathermap.org/img/wn/${forecast.icon}@2x.png',
          height: 50,
          ),
          Text('${forecast.temperature}°C',style: TextStyle(color: Colors.white),),
          Text(forecast.description,style: TextStyle(color: Colors.white),),
          ],
          ),
          );
          },
          ),
          ),
          ),
          ],
          ),
          ),

          // Weekly Forecast
          Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
          'Weekly Forecast',
          style: TextStyle(fontSize: 24,color: Colors.white),
          ),
          SizedBox(height: 10),
          Column(
          children: weatherController.getWeeklyForecast().entries.map((entry) {
          final date = entry.key;
          final forecasts = entry.value;
          final dayName = DateFormat('EEEE').format(DateTime.parse(date)); // Get the name of the day
          return Card(
            color: Colors.transparent,
          child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(dayName, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.white)),
          SizedBox(height: 5),
          Container(
          height: 110,
          child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: forecasts.length,
          itemBuilder: (context, index) {
          final forecast = forecasts[index];
          return Container(
          width: 80,
          margin: EdgeInsets.all(4.0),
          child: SingleChildScrollView(
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Text(forecast.dateTime.split(' ')[1],style: TextStyle(color: Colors.white),), // Time
          Image.network(
          'http://openweathermap.org/img/wn/${forecast.icon}@2x.png',
          height: 40,
          ),
          Text('${forecast.temperature}°C',style: TextStyle(color: Colors.white),),
          Text(forecast.description,style: TextStyle(color: Colors.white),),
          ],
          ),
          ),
          );
          },
          ),
          ),
          ],
          ),
          ),
          );
          }).toList(),
          )

          ],
          ),
          ),
          ],
          ),
          ),
          ]
          );
        }
        }));
  }
}


