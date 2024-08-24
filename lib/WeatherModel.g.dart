// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'WeatherModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      cityName: json['cityName'] as String? ?? '',
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      hourlyForecast: (json['hourlyForecast'] as List<dynamic>?)
              ?.map((e) => HourlyForecast.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'cityName': instance.cityName,
      'temperature': instance.temperature,
      'description': instance.description,
      'icon': instance.icon,
      'hourlyForecast': instance.hourlyForecast,
    };

HourlyForecast _$HourlyForecastFromJson(Map<String, dynamic> json) =>
    HourlyForecast(
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      dateTime: json['dateTime'] as String? ?? '',
    );

Map<String, dynamic> _$HourlyForecastToJson(HourlyForecast instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'description': instance.description,
      'icon': instance.icon,
      'dateTime': instance.dateTime,
    };

RealTimeWeatherModel _$RealTimeWeatherModelFromJson(
        Map<String, dynamic> json) =>
    RealTimeWeatherModel(
      cityName: json['cityName'] as String? ?? '',
      temperature: (json['temperature'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );

Map<String, dynamic> _$RealTimeWeatherModelToJson(
        RealTimeWeatherModel instance) =>
    <String, dynamic>{
      'cityName': instance.cityName,
      'temperature': instance.temperature,
      'description': instance.description,
      'icon': instance.icon,
    };
