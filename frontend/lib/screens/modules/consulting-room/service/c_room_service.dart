import 'dart:convert';

import 'package:frontend/screens/modules/consulting-room/model/c_room_model.dart';
import 'package:http/http.dart' as http;

class CRoomService {
  static Future<bool> deleteData(String consultingroomId) async {
    final url = "http://10.0.2.2:3000/consulting-room/$consultingroomId";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);
    return response.statusCode == 200;
  }

  static Future<List<CRoomModel>> fetchData() async {
                  const url = "http://10.0.2.2:3000/consulting-room";
           final uri = Uri.parse(url);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      List<CRoomModel> croom = responseData.map((data) {
        return CRoomModel(
            id: data["id"].toString(),
            name: data["name"].toString(),
            description: data['description'].toString(),
            numConsult : data["numConsult"]
            );
      }).toList();

      return croom;
    } else {
      throw Exception('Failed to fetch data');
    }
  }

  static Future<CRoomModel> navigateToMedicineScreen(String consultingroomId) async {
    final url = "http://10.0.2.2:3000/connsulting-room/$consultingroomId";
    final uri = Uri.parse(url);
    final response = await http.delete(uri);

    dynamic responseData = jsonDecode(response.body);
    CRoomModel croom = CRoomModel(
      id: responseData["id"].toString(),
      name: responseData["name"].toString(),
      description: responseData["description"].toString(),
      numConsult : responseData["numConsult"]
    );

    return croom;
  }
}
