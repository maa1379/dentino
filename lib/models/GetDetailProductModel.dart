







class GetDetailProductModel {
  GetDetailProductModel({
    this.name,
    this.price,
    this.image,
    this.image2,
    this.image3,
    this.image4,
    this.description,
    this.created,
    this.phoneNumber,
    this.address,
    this.category,
    this.id,
    this.discountPercent,
  });

  String name;
  String price;
  String image;
  String image2;
  dynamic image3;
  String image4;
  String description;
  DateTime created;
  String phoneNumber;
  String address;
  int category;
  int id;
  int discountPercent;

  factory GetDetailProductModel.fromJson(Map<String, dynamic> json) => GetDetailProductModel(
    name: json["name"],
    price: json["price"],
    image: json["image"],
    image2: json["image2"],
    image3: json["image3"],
    image4: json["image4"],
    description: json["description"],
    created: DateTime.parse(json["created"]),
    phoneNumber: json["phone_number"],
    address: json["address"],
    category: json["category"],
    id: json["id"],
    discountPercent: json["discount_percent"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "price": price,
    "image": image,
    "image2": image2,
    "image3": image3,
    "image4": image4,
    "description": description,
    "created": created.toIso8601String(),
    "phone_number": phoneNumber,
    "address": address,
    "category": category,
    "id": id,
    "discount_percent": discountPercent,
  };
}
