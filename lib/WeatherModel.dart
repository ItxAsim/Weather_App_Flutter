import 'package:json_annotation/json_annotation.dart';

part 'WeatherModel.g.dart';

@JsonSerializable()
class WeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;
  final List<HourlyForecast> hourlyForecast;

  WeatherModel({
    this.cityName = '',
    this.temperature = 0.0,
    this.description = '',
    this.icon = '',
    this.hourlyForecast = const [],
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['city']['name'] ?? '',
      temperature: json['main'] != null ? (json['main']['temp'] as num).toDouble() : 0.0,
      description: json['weather'] != null ? json['weather'][0]['description'] : '',
      icon: json['weather'] != null ? json['weather'][0]['icon'] ?? '' : '',
      hourlyForecast: (json['list'] as List)
          .map((e) => HourlyForecast.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}

@JsonSerializable()
class HourlyForecast {
  final double temperature;
  final String description;
  final String icon;
  final String dateTime;

  HourlyForecast({
    this.temperature = 0.0,
    this.description = '',
    this.icon = '',
    this.dateTime = '',
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      temperature: json['main']['temp'] != null ? (json['main']['temp'] as num).toDouble() : 0.0,
      description: json['weather'] != null ? json['weather'][0]['description'] : '',
      icon: json['weather'] != null ? json['weather'][0]['icon'] : '',
      dateTime: json['dt_txt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$HourlyForecastToJson(this);
}
@JsonSerializable()
class RealTimeWeatherModel {
  final String cityName;
  final double temperature;
  final String description;
  final String icon;

  RealTimeWeatherModel({
    this.cityName = '',
    this.temperature = 0.0,
    this.description = '',
    this.icon = '',
  });

  factory RealTimeWeatherModel.fromJson(Map<String, dynamic> json) {
    return RealTimeWeatherModel(
      cityName: json['name'] ?? '',
      temperature: json['main'] != null ? (json['main']['temp'] as num).toDouble() : 0.0,
      description: json['weather'] != null ? json['weather'][0]['description'] : '',
      icon: json['weather'] != null ? json['weather'][0]['icon'] ?? '' : '',
    );
  }

  Map<String, dynamic> toJson() => _$RealTimeWeatherModelToJson(this);
}
