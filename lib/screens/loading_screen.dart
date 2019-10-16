import 'package:flutter/material.dart';
import 'package:climate/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '5cfee8afdd24be4d600e2f0c6b1080fa';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double lat;
  double long;

  void getYourLocation() async {
    Location location = Location();
    await location.getLocation();
    lat = location.latitude;
    long = location.longitude;
    getData();
  }

  void getData() async {
    String data;
    String url =
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey';

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      data = response.body;
      //print(data);

      var jsonData = jsonDecode(data);

      var temp = jsonData['list'][0]['main']['temp'];
      var tempMin = jsonData['list'][0]['main']['temp_min'];
      var tempMax = jsonData['list'][0]['main']['temp_max'];
      //var city = jsonData['name'];
      //var id = jsonData['weather'][0]['id'];

      //print('ID : $id');
      //print('City : $city');
      print('Tempature : $temp');
      print('Tempature : $tempMin');
      print('Tempature : $tempMax');
    } else {
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    getYourLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            //getYourLocation();
            //getData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
