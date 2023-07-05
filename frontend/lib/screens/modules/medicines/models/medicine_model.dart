import 'dart:convert';

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
