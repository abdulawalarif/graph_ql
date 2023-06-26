// To parse this JSON data, do
//
//     final continentModel = continentModelFromJson(jsonString);

import 'dart:convert';

ContinentModel continentModelFromJson(String str) => ContinentModel.fromJson(json.decode(str));

String continentModelToJson(ContinentModel data) => json.encode(data.toJson());

class ContinentModel {
  Data data;

  ContinentModel({
    required this.data,
  });

  factory ContinentModel.fromJson(Map<String, dynamic> json) => ContinentModel(
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
  };
}

class Data {
  List<Continent> continents;

  Data({
    required this.continents,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    continents: List<Continent>.from(json["continents"].map((x) => Continent.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "continents": List<dynamic>.from(continents.map((x) => x.toJson())),
  };
}

class Continent {
  String name;

  Continent({
    required this.name,
  });

  factory Continent.fromJson(Map<String, dynamic> json) => Continent(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
