import 'package:flutter/material.dart';
import 'package:project/utils/weather.dart';

class WeatherTab extends StatefulWidget {
  WeatherTab({@required this.weatherData});

  final WeatherData weatherData;

  @override
  _WeatherTabState createState() => _WeatherTabState();
}

class _WeatherTabState extends State<WeatherTab> {
  double amkTemp, amkFeel, bedokTemp, bedokFeel, yishunTemp, yishunFeel, celamkTemp, celamkFeel, celbedokTemp, celbedokFeel, celyishunTemp, celyishunFeel;
  int amkHumid, bedokHumid, yishunHumid;
  String tempState = '\u2103';
  bool _isCelcius = true;

  void updateDisplayInfo(WeatherData weatherData){
    setState((){
      celamkTemp = weatherData.amkTemperature;
      celamkFeel = weatherData.amkFeels;
      celbedokTemp = weatherData.bedokTemperature;
      celbedokFeel = weatherData.bedokFeels;
      celyishunTemp = weatherData.yishunTemperature;
      celyishunFeel = weatherData.yishunFeels;

      amkTemp = weatherData.amkTemperature;
      amkFeel = weatherData.amkFeels;
      amkHumid = weatherData.amkHumidity;
      bedokTemp = weatherData.bedokTemperature;
      bedokFeel = weatherData.bedokFeels;
      bedokHumid = weatherData.bedokHumidity;
      yishunTemp = weatherData.yishunTemperature;
      yishunFeel = weatherData.yishunFeels;
      yishunHumid = weatherData.yishunHumidity;
    });
  }

  double celciustoFahrenheit(double cel){
    return (cel * (9/5) + 32);
  }

  @override
  void initState() {
    super.initState();

    updateDisplayInfo(widget.weatherData);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Row(    //Headers
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 30.0, top: 30.0),
                child: Text(
                  'Area',
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              flex: 1,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Column(
                  children: <Widget>[
                      FlatButton(
                        child: Icon(
                          Icons.thermostat_sharp,
                          color: Colors.white,
                          size:  30.0,
                        ),
                          onPressed: (){
                          setState(() {
                            if(_isCelcius){
                              _isCelcius = false;
                              tempState = '\u2109';
                              amkTemp = celciustoFahrenheit(amkTemp);
                              amkFeel = celciustoFahrenheit(amkFeel);
                              bedokTemp = celciustoFahrenheit(bedokTemp);
                              bedokFeel = celciustoFahrenheit(bedokFeel);
                              yishunTemp = celciustoFahrenheit(yishunTemp);
                              yishunFeel = celciustoFahrenheit(yishunFeel);
                            }
                            else{
                              _isCelcius = true;
                              tempState = '\u2103';
                              amkTemp = celamkTemp;
                              amkFeel = celamkFeel;
                              bedokTemp = celbedokTemp;
                              bedokFeel = celbedokFeel;
                              yishunTemp = celyishunTemp;
                              yishunFeel = celyishunFeel;
                            }
                            });
                          }
                        ),

                    Padding(
                      padding: const EdgeInsets.only(right: 100.0),
                      child: Text(
                        'Temperature',
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100.0),
                      child: Text('Humidity (%)',
                          style: TextStyle(fontSize: 20.0, color: Colors.white)),
                    ),
                  ],
                ),
              ),
              flex: 3,
            ),
          ],
        ),
        ListTile(   //Location: Ang Mo Kio
          leading: SizedBox(width: 100.0, child: Text('Ang Mo Kio')),
          title: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text('$amkTemp $tempState'),
              ),
          subtitle: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text('$amkHumid %'),
          ),
          trailing: Text('Feels like: $amkFeel $tempState'), 
        ),
        ListTile(   //Location: Bedok
          leading: SizedBox(width: 100.0, child: Text('Bedok')),
          title: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text('$bedokTemp $tempState'),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text('$bedokHumid %'),
          ),
          trailing: Text('Feels like: $bedokFeel $tempState'),
        ),
        ListTile(   //Location: Yishun
          leading: SizedBox(width: 100.0, child: Text('Yishun')),
          title: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text('$yishunTemp $tempState'),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Text('$yishunHumid %'),
          ),
          trailing: Text('Feels like: $yishunFeel $tempState'),
        ),
      ],
    );
  }
}