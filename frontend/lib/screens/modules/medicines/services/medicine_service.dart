import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MedicineModel {
  int? id;
  String? name;
  String? description;

  MedicineModel({
    this.id,
    this.name,
    this.description,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) => MedicineModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}

class MedicineService {
  Future<List<MedicineModel>> getMedicines() async {
    try {
      var url = Uri.parse("http://10.0.2.2:3000/medicines");
      var response = await http.get(url);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body) as List<dynamic>;
        var medicines = data.map((item) => MedicineModel.fromJson(item)).toList();

        return medicines;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}