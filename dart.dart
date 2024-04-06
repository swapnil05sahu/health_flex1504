// main.dart
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String API_KEY = 'YOUR_API_KEY';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Weather App'),
        ),
        body: WeatherPage(),
      ),
    );
  }
}

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String weatherData = '';
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchWeatherData();
  }

  Future<void> fetchWeatherData() async {
    setState(() {
      loading = true;
    });
    try {
      final response = await http.get('https://api.tomorrow.io/v4/timelines?location=0,0&fields=temperature&timesteps=current&apikey=$API_KEY');
      final responseData = json.decode(response.body);
      setState(() {
        weatherData = responseData['data']['timelines'][0]['intervals'][0]['values']['temperature'].toString();
        loading = false;
      });
    } catch (error) {
      print('Error fetching weather data: $error');
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: loading
          ? CircularProgressIndicator()
          : Text('Temperature: $weatherData'),
    );
  }
}
