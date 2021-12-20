


class ExertiseListModel {
  ExertiseListModel({
    this.title,
    this.id,
    this.image,
  });

  String title;
  int id;
  String image;

  factory ExertiseListModel.fromJson(Map<String, dynamic> json) => ExertiseListModel(
    title: json["title"],
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
    "image": image,
  };
}