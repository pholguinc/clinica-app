import 'dart:convert';

import 'package:frontend/screens/modules/services/model/service_model.dart';
import 'package:http/http.dart' as http;

class ServiceServ {
  static Future<bool> deleteData(String serviceId) async {
    final url = "http://10.0.2.2:3000/service/$serviceId";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<List<ServiceModel>> fetchData() async {
    const url = "http://10.0.2.2:3000/service";
    final uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      List<ServiceModel> services = responseData.map((data) {
        return ServiceModel(
            id: data["id"].toString(),
            name: data["name"].toString(),
            description: data['description'].toString());
      }).toList();

      return services;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  static Future<ServiceModel> navigateToServiceScreen(String serviceId) async{
    final url = "http://10.0.2.2:3000/medicines/$serviceId";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    dynamic responseData = jsonDecode(response.body);
    ServiceModel service = ServiceModel(
      id: responseData["id"].toString(),
      name: responseData["name"].toString(),
      description: responseData["description"].toString(),
    );

    return service;
  }
 
}
