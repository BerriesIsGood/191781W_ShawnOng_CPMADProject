import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void _contact() async {
    final url = 'mailto:shawnongjh@yahoo.com.sg';
    if(await canLaunch(url)) {
      await launch(url);
    }
    else {
      throw 'Could not launch $url';
    }
  }

  class AboutTab extends StatefulWidget {
  
    @override
    _AboutTabState createState() => _AboutTabState();
  }
  
  class _AboutTabState extends State<AboutTab> {
    @override
    Widget build(BuildContext context) {
      return Center(
         child: Column(   //About Tab
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 30.0),
                      child: Text('About Us',
                      style: TextStyle(
                        fontSize: 30.0, color: Colors.white, fontWeight: FontWeight.bold
                      ),
                      ),
                    ),
                    Image(
                      image: AssetImage("images/logo.png"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(50.0),
                      child: Text('Weatherin SG gives data on the current weather in different parts of Singapore and it is 99.9% accurate!',
                      style: TextStyle(
                        fontSize: 16.0
                      ),
                      ),
                    ),
                    Padding(    //Contact Button
                      padding: EdgeInsets.all(10.0),
                      child: RaisedButton(
                        onPressed: () => launch("tel://91792021"),
                        child: Text('Contact Me'),
                        ),
                    ),
                    Padding(    //Email Button
                      padding: EdgeInsets.all(10.0),
                      child: RaisedButton(
                        onPressed: (){_contact();},
                        child: Text('Email Me'),
                        ),
                    ),
                  ],
                ),
      );
    }
  }