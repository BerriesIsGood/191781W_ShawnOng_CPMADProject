import 'package:flutter/material.dart';
import 'utils/weather.dart';
import 'package:intl/intl.dart';

class TimeOfSun extends StatefulWidget {
  TimeOfSun({@required this.weatherData});

  final WeatherData weatherData;

  @override
  _TimeOfSunState createState() => _TimeOfSunState();
}

class _TimeOfSunState extends State<TimeOfSun> {
  String sunrise, sunset; 

  void updateDisplayInfo(WeatherData weatherData) {
    setState((){
      int sunriseUTC = weatherData.sunrise;
      int sunsetUTC = weatherData.sunset;

      sunrise = DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(sunriseUTC*1000));   //Converts UTC to hh:mm (07:05 am etc.) 
      sunset = DateFormat('hh:mm').format(DateTime.fromMillisecondsSinceEpoch(sunsetUTC*1000));
    });
  }

  @override
  void initState() {
    super.initState();

    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
       child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         mainAxisSize: MainAxisSize.max,
         children: <Widget>[
           Padding(
             padding: const EdgeInsets.all(20.0),
             child: Text(
               'Sunrise & Sunset',
               style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
               ),
           ),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Padding(
                 padding: EdgeInsets.only(left: 50.0),
                 child: Text(
                   'Sunrise',
                   style: TextStyle(fontSize: 16.0),
                   ),
               ),
               Padding(
                 padding: EdgeInsets.only(right: 50.0),
                 child: Text(
                   'Sunset',
                   style: TextStyle(fontSize: 16.0),
                   ),
               ),
             ],
           ),

           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Padding(
                 padding: EdgeInsets.only(left: 25.0),
                 child: Text(
                   '$sunrise am',
                   style: TextStyle(fontSize: 25.0),
                   ),
               ),
               Padding(
                 padding: EdgeInsets.only(right: 25.0),
                 child: Text(
                   '$sunset pm',
                   style: TextStyle(fontSize: 25.0),
                   ),
               ),
             ],
           ),

           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
               Padding(
                 padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                 child: Container(
                   width: 400.0,
                   height: 150.0,
                   child: Image.asset('images/SunLoc.png'),
                   ),
               ),
           ],
           ),
         ],
       ),
    );
  }
}