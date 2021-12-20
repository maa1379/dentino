


class ContactUsModel {
  ContactUsModel({
    this.id,
    this.name,
    this.message,
  });

  int id;
  String name;
  String message;

  factory ContactUsModel.fromJson(Map<String, dynamic> json) => ContactUsModel(
    id: json["id"],
    name: json["name"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "message": message,
  };
}


class AboutUsModel {
  AboutUsModel({
    this.id,
    this.content,
  });

  int id;
  String content;

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
    id: json["id"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "content": content,
  };
}




class SliderModel {
  SliderModel({
    this.id,
    this.title,
    this.picture,
  });

  int id;
  String title;
  String picture;

  factory SliderModel.fromJson(Map<String, dynamic> json) => SliderModel(
    id: json["id"],
    title: json["title"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "picture": picture,
  };
}
