

class PrescriptionsModel {
  PrescriptionsModel({
    this.id,
    this.title,
    this.description,
    this.image,
    this.created,
  });

  int id;
  String title;
  String description;
  String image;
  String created;

  factory PrescriptionsModel.fromJson(Map<String, dynamic> json) => PrescriptionsModel(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    created: json["created"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "created": created,
  };
}