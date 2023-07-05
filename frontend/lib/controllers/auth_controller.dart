import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class AuthController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  Future loginUser() async {
    final Logger logger = Logger();

    const url = "http://10.0.2.2:3000/auth/login";

   try {
      var response = await http.post(
        Uri.parse(url),
        body: {
          "email": emailController.text,
          "password": passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        var loginArry = jsonDecode(response.body);
       logger.d(loginArry);

        // Handle the response data accordingly
      } else {
        logger.d(response.body);
      }
    } catch (e) {
      logger.d('Error occurred during login: $e');
      // Handle the error here or perform any necessary actions
    }
  }
}
