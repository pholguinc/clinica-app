import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(Uri.parse('http://10.0.2.2:3000/auth/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email" : email,
        "password": password
      })
      );

      if(response.statusCode != 201) return null;
      
    } catch (e) {
      // ignore: avoid_print
      print(e); 
    }
    return null;
     
  }
}
