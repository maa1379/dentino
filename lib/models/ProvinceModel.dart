class ProvinceModel {
  ProvinceModel({
    this.name,
    this.id,
  });

  String name;
  int id;

  factory ProvinceModel.fromJson(Map<String, dynamic> json) => ProvinceModel(
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
      };
}

class CityModel {
  CityModel({
    this.province,
    this.name,
    this.id,
  });

  int province;
  String name;
  int id;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        province: json["province"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "province": province,
        "name": name,
        "id": id,
      };
}

class ZoneModel {
  ZoneModel({
    this.city,
    this.name,
    this.id,
  });

  int city;
  String name;
  int id;

  factory ZoneModel.fromJson(Map<String, dynamic> json) => ZoneModel(
        city: json["city"],
        name: json["name"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "city": city,
        "name": name,
        "id": id,
      };
}
