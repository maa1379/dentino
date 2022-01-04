

class OrderListModel {
  OrderListModel({
    this.id,
    this.price,
    this.paid,
    this.create,
    this.address,
    this.code,
    this.name,
    this.family,
    this.email,
    this.authority,
    this.isSend,
    this.user,
  });

  int id;
  String price;
  bool paid;
  DateTime create;
  String address;
  String code;
  String name;
  String family;
  String email;
  String authority;
  bool isSend;
  int user;

  factory OrderListModel.fromJson(Map<String, dynamic> json) => OrderListModel(
    id: json["id"],
    price: json["price"],
    paid: json["paid"],
    create: DateTime.parse(json["create"]),
    address: json["address"],
    code: json["code"],
    name: json["name"],
    family: json["family"],
    email: json["email"],
    authority: json["authority"],
    isSend: json["is_send"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "price": price,
    "paid": paid,
    "create": create.toIso8601String(),
    "address": address,
    "code": code,
    "name": name,
    "family": family,
    "email": email,
    "authority": authority,
    "is_send": isSend,
    "user": user,
  };
}



