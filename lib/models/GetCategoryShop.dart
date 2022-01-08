class GetCategoryShop {
  GetCategoryShop({
    this.title,
    this.id,
  });

  String title;
  int id;

  factory GetCategoryShop.fromJson(Map<String, dynamic> json) => GetCategoryShop(
    title: json["title"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
  };
}


class GetSubCategoryShop {
  GetSubCategoryShop({
    this.title,
    this.id,
  });

  String title;
  int id;

  factory GetSubCategoryShop.fromJson(Map<String, dynamic> json) => GetSubCategoryShop(
    title: json["title"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
  };
}