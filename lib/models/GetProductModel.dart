class GetProductModel {
  GetProductModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.category,
  });

  int id;
  String name;
  String price;
  String image;
  int category;

  factory GetProductModel.fromJson(Map<String, dynamic> json) => GetProductModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "image": image,
    "category": category,
  };
}