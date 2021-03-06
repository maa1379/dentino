

class GetProductModel {
  GetProductModel({
    this.id,
    this.name,
    this.price,
    this.image,
    this.category,
    this.sell,
    this.discountPercent,
  });

  int id;
  String name;
  String price;
  String image;
  int category;
  String sell;
  int discountPercent;

  factory GetProductModel.fromJson(Map<String, dynamic> json) => GetProductModel(
    id: json["id"],
    name: json["name"],
    price: json["price"],
    image: json["image"],
    category: json["category"],
    sell: json["sell"],
    discountPercent: json["discount_percent"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "price": price,
    "image": image,
    "category": category,
    "sell": sell,
    "discount_percent": discountPercent,
  };
}
