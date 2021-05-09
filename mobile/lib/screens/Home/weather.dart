import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherIcon extends StatefulWidget {
  @override
  _WeatherIconState createState() => _WeatherIconState();
}

class _WeatherIconState extends State<WeatherIcon> {
  int temp = 0;
  String icon;
  bool loading = true, error = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      setState(() {
        loading = true;
        error = false;
      });
      // Position position = await Geolocator.getLastKnownPosition();
      // int lat = position.latitude as int, lon = position.longitude as int;

      // Fluttertoast.showToast(msg: '$lat - $lon');
      Uri uri = Uri.parse(
        'https://api.openweathermap.org/data/' +
            '2.5/weather?units=metric&q=iraq' +
            '&appid=62426ee366b127be38305345be9b0c92',
      );
      http.Response value = await http.get(uri);
      dynamic json = jsonDecode(value.body);
      String iconImg = json["weather"][0]["icon"];

      setState(() {
        loading = false;
        temp = json["main"]["temp"];
        icon = 'http://openweathermap.org/img/wn/$iconImg.png';
      });
    } catch (ex) {
      setState(() {
        loading = false;
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      width: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.grey.withOpacity(0.4),
      ),
      child: loading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            )
          : error
              ? IconButton(
                  icon: Icon(Icons.replay_outlined),
                  onPressed: () => fetchData(),
                )
              : InkWell(
                  onTap: () => fetchData(),
                  child: Column(
                    children: [
                      Image.network(icon, width: 60),
                      Text(
                        '$temp C',
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontWeight: FontWeight.bold,
                          // fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
