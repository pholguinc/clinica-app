import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Map data;
  List doctorData = [];

  getDoctors() async {
    Uri uri = Uri.parse("http://10.0.2.2:3000/api/doctors");
    http.Response response = await http.get(uri);
    List<dynamic> responseData = json.decode(response.body);
    setState(() {
      doctorData = responseData;
    });
  }

  @override
  void initState() {
    super.initState();
    getDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: ListView.builder(
        itemCount: doctorData.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              children: <Widget>[Text('${doctorData[index]["name"]}')],
            ),
          );
        },
      ),
    );
  }
}
