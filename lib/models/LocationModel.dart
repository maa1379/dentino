


class LocationModel {
  LocationModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
