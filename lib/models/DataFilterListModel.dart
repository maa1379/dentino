

class ClinicFilterModel {
  ClinicFilterModel({
    this.name,
    this.id,
  });

  String name;
  int id;

  factory ClinicFilterModel.fromJson(Map<String, dynamic> json) => ClinicFilterModel(
    name: json["name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
  };
}


class InsuranceFilterModel {
  InsuranceFilterModel({
    this.id,
    this.name,
    this.image,
  });

  int id;
  String name;
  String image;

  factory InsuranceFilterModel.fromJson(Map<String, dynamic> json) => InsuranceFilterModel(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
