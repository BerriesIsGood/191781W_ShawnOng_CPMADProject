import 'dart:convert';
import 'package:http/http.dart';

class WeatherData {
  double amkTemperature, amkFeels, bedokTemperature, bedokFeels, yishunTemperature, yishunFeels;
  int amkHumidity, bedokHumidity, yishunHumidity, sunrise, sunset, cloud, rain;
  String weatherType;

  Future<void> getWeather() async {
    Response amk = await get(    //Ang Mo Kio weather details
        'http://api.openweathermap.org/data/2.5/weather?lat=1.3690&lon=103.8455&appid=fd35b0beae848a99be436df8322f87f6&units=metric'
        );

    if (amk.statusCode == 200) {
      String data = amk.body;
      var currentWeather = jsonDecode(data);

      try {
        amkTemperature = currentWeather['main']['temp'];
        amkHumidity = currentWeather['main']['humidity'];
        amkFeels = currentWeather['main']['feels_like'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature for Ang Mo Kio!');
    }

    Response bedok = await get(    //Bedok weather details
        'http://api.openweathermap.org/data/2.5/weather?lat=1.3234&lon=103.9272&appid=fd35b0beae848a99be436df8322f87f6&units=metric'
        );

    if (bedok.statusCode == 200) {
      String data = bedok.body;
      var currentWeather = jsonDecode(data);

      try {
        bedokTemperature = currentWeather['main']['temp'];
        bedokHumidity = currentWeather['main']['humidity'];
        bedokFeels = currentWeather['main']['feels_like'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature for Bedok!');
    }

    Response yishun = await get(    //Yishun weather details
        'http://api.openweathermap.org/data/2.5/weather?lat=1.4303&lon=103.8353&appid=fd35b0beae848a99be436df8322f87f6&units=metric'
        );

    if (yishun.statusCode == 200) {
      String data = yishun.body;
      var currentWeather = jsonDecode(data);

      try {
        yishunTemperature = currentWeather['main']['temp'];
        yishunHumidity = currentWeather['main']['humidity'];
        yishunFeels = currentWeather['main']['feels_like'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch temperature for Yishun!');
    }

    Response sunloc = await get(    //Get sunrise/sunset details
        'http://api.openweathermap.org/data/2.5/weather?q=Singapore&appid=fd35b0beae848a99be436df8322f87f6&units=metric'
        );

    if (sunloc.statusCode == 200) {
      String data = sunloc.body;
      var currentWeather = jsonDecode(data);

      try {
        sunrise = currentWeather['sys']['sunrise'];
        sunset = currentWeather['sys']['sunset'];
        cloud = currentWeather['clouds']['all'];
        weatherType = currentWeather['weather']['main'];
        rain = currentWeather['rain']['3h'];
      } catch (e) {
        print(e);
      }
    } else {
      print('Could not fetch time!');
    }
  }
}