import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
// import '';
class WeatherLocations {


  final String city;
  final String dateTime;
  final String temperature;
  final String weatherType;
  final String iconUrl;
  final num wind;
  final num cloud;
  final num pressure;
  final num humidity;

  WeatherLocations({
  required this.cloud,
  required this.city,
  required this.dateTime,
  required this.temperature,
  required this.weatherType,
  required this.iconUrl,
  required this.wind,
  required this.pressure,
  required this.humidity
  });

  factory WeatherLocations.fromJson(Map<String, dynamic> json) {
    DateTime now = DateTime.now();
    String dateTime = DateFormat('kk:mm - EEE , d MMM 2021').format(now);
    return WeatherLocations(
      city: json["name"],
      dateTime: dateTime,
      temperature: (json['main']['temp']-273.15).toStringAsFixed(2),
      weatherType: json['weather'][0]['main'],
      wind: json['wind']['speed'],
      cloud: json["clouds"]["all"],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      iconUrl: json['weather'][0]['icon'],
    );
  }
}
// fetchWeather() async {
//   String weatherurl = "https://api.openweathermap.org/data/2.5/weather?q=Ranchi,in&appid=f74917363ea01c303f930d140c4833b1";
//   final http.Response response =
//     await http.get(Uri.parse(weatherurl));
//
//   if (response.statusCode == 200) {
//
//     // print(response.body);
//     Map<String, dynamic> map = json.decode(response.body);
//     List<dynamic> weatherTypeDetail = map["weather"];
//     var weatherType = weatherTypeDetail[0]["main"];
//     // print(weatherType);
//     Map<String, dynamic> tempHumidDetails = map["main"];
//     num temp = tempHumidDetails["temp"] - 273.15;
//     // print(temp);
//     int humidity = tempHumidDetails["humidity"];
//     // print(humidity);
//     var pressure = tempHumidDetails["pressure"];
//     // print(pressure);
//     Map<String, dynamic> windDetails = map["wind"];
//     num wind = windDetails["speed"];
//     // print(wind);
//
//     Map<String, dynamic> cloudDetail = map["clouds"];
//     num cloud = cloudDetail["all"];
//     print(cloud);
//
//     DateTime now = DateTime.now();
//     String dateTime = DateFormat('kk:mm - EEE , d MMM YYYY').format(now);
//
//     var tempList = WeatherLocations(
//         city: "city",
//         dateTime: dateTime,
//         temperature: temp.toString(),
//         weatherType: weatherType,
//         iconUrl: "assets/",
//         wind: wind,
//         cloud: cloud,
//         pressure: pressure,
//         humidity: humidity
//     );
//
//   } else {
//     throw Exception('Failed to load Weather!!');
//   }
// }

Future fetchWeather(String city) async {
  WeatherLocations weather;
  // String city = "Ranchi";
  String apiKey = "f74917363ea01c303f930d140c4833b1";
  var url = "https://api.openweathermap.org/data/2.5/weather?q=$city,in&appid=$apiKey";

  final response = await http.get(Uri.parse(url));


  if (response.statusCode == 200) {
    weather = WeatherLocations.fromJson(jsonDecode(response.body));
    WeatherLocations temp = WeatherLocations(cloud: 0,
        city: "",
        dateTime: "",
        temperature: "",
        weatherType: "",
        iconUrl: "",
        wind: 0,
        pressure: 0,
        humidity: 0
    );
    // print(weather.iconUrl.runtimeType);
    var existingLocation = locationList.firstWhere((element) =>
    weather.city == element.city,
      orElse: () => temp);
    // print(existingLocation.city);
    if(existingLocation == temp) {
      locationList.add(weather);
      // print("in if");
    } else {
      locationList.remove(existingLocation);
      locationList.add(weather);
      // print("In else");
    }

  } else {
    print("Exception occured");
    throw Exception('Failed to load Weather!!');
  }
  return null;
}

var locationList = [
  WeatherLocations(
    city: "Kolkata",
    dateTime: "07:50 PM -Monday, 9 Nov 2021",
    temperature: "24\u2103",
    weatherType: "Night",
    iconUrl: "01d",
    wind: 10,
    cloud: 78,
    pressure: 2,
    humidity: 10,
  ),
  WeatherLocations(
    city: "London",
    dateTime: "07:50 PM -Monday, 9 Nov 2021",
    temperature: "15\u2103",
    weatherType: "Cloudy",
    iconUrl: "01d",
    wind: 10,
    cloud: 7,
    pressure: 2,
    humidity: 10,
  ),WeatherLocations(
    city: "New York",
    dateTime: "07:50 PM -Monday, 9 Nov 2021",
    temperature: "17\u2103",
    weatherType: "Sunny",
    iconUrl: "01d",
    wind: 5,
    cloud: 3,
    pressure: 15,
    humidity: 61,
  ),
];