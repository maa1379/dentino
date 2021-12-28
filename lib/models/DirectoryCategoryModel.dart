


class DirectoryCategoryModel {
  DirectoryCategoryModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory DirectoryCategoryModel.fromJson(Map<String, dynamic> json) => DirectoryCategoryModel(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
