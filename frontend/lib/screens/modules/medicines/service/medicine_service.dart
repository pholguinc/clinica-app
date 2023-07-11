
import 'dart:convert';
import 'package:frontend/screens/modules/medicines/model/medicine_model.dart';
import 'package:http/http.dart' 
as http;
class MedicineService {
  static Future<bool> deleteData(String medicineId) async {
    final url = "http://10.0.2.2:3000/medicines/$medicineId";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<List<MedicineModel>> fetchData() async {
    const url = "http://10.0.2.2:3000/medicines";
    final uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      List<MedicineModel> medicines = responseData.map((data) {
        return MedicineModel(
            id: data["id"].toString(),
            name: data["name"].toString(),
            description: data['description'].toString());
      }).toList();

      return medicines;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  static Future<MedicineModel> navigateToMedicineScreen(String medicineId) async{
    final url = "http://10.0.2.2:3000/medicines/$medicineId";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    dynamic responseData = jsonDecode(response.body);
    MedicineModel medicine = MedicineModel(
      id: responseData["id"].toString(),
      name: responseData["name"].toString(),
      description: responseData["description"].toString(),
    );

    return medicine;
  }
  
 
}
