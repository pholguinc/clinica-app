
import 'dart:convert';
import 'package:frontend/screens/modules/doctors/model/doctor_model.dart';
import 'package:http/http.dart' as http;

class DoctorService {
  

  static Future<List<DoctorModel>> fetchData() async {
    const url = "http://10.0.2.2:3000/users/role-doctor";
    final uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      List<DoctorModel> doctors = responseData.map((data) {
        return DoctorModel(
            id: data["id"].toString(),
            name: data["name"].toString(),
            lastnamePater: data['lastname_pater'].toString(),
            lastnameMater: data['lastname_mater'].toString(),
            numDoc: data['num_doc'].toString(),
            phone: data['phone'].toString(),
            address: data['address'].toString(),
            email: data["email"].toString(), 
            password:data["password"].toString(), 
            role: data["role"].toString(),
            
            );
      }).toList();

      return doctors;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  
  
 
}
