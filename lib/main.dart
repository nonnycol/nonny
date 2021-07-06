import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MaterialApp(
      title: "Weather App",
      home: Home(),
    ));

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  dynamic temp;
  dynamic description;
  dynamic location;
  dynamic humidity;
  dynamic windspeed;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse("https://api.openweathermap.org/data/2.5/weather?q=Akure,%20Nigeria&appid=165833934562377b7920d150912dc253"));
    dynamic results = jsonDecode(response.body);
    setState(() {
      temp = results['main']['temp'];
      description = results['weather'][0]['description'];
      location = results['weather'][0]['main'];
      humidity = results['main']['humidity'];
      windspeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    "Akure, Nigeria",
                    style: TextStyle(color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w800),
                  ),
                ),
                Text(
                  temp != null ? temp.toString() + "\0B00" : "Loading",
                  style: TextStyle(color: Colors.pink, fontSize: 16.0, fontWeight: FontWeight.w800),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    location != null ? location.toString() : "Loading",
                    style: TextStyle(color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: FaIcon(FontAwesomeIcons.thermometerHalf),
                    title: Text("Temperature"),
                    trailing: Text(temp != null ? temp.toString() + "\0B00" : "Loading"),
                  ),
                  ListTile(leading: FaIcon(FontAwesomeIcons.cloud), title: Text("Weather"), trailing: Text(description != null ? description.toString() : "Loading")),
                  ListTile(leading: FaIcon(FontAwesomeIcons.wind), title: Text("Humidity"), trailing: Text(humidity != null ? humidity.toString() : "Loading")),
                  ListTile(leading: FaIcon(FontAwesomeIcons.wind), title: Text("Wind Speed"), trailing: Text(windspeed != null ? windspeed.toString() : "Loading"))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
