

class GetCartListMdoel {
  GetCartListMdoel({
    this.items,
    this.totalPrice,
  });

  List<ItemList> items;
  int totalPrice;

  factory GetCartListMdoel.fromJson(Map<String, dynamic> json) => GetCartListMdoel(
    items: List<ItemList>.from(json["items"].map((x) => ItemList.fromJson(x))),
    totalPrice: json["total_price"],
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "total_price": totalPrice,
  };
}

class ItemList {
  ItemList({
    this.rowId,
    this.productName,
    this.productImage,
    this.productId,
    this.productPrice,
    this.userId,
    this.productQuantity,
  });

  String rowId;
  String productName;
  String productImage;
  String productId;
  String productPrice;
  String userId;
  String productQuantity;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
    rowId: json["row_id"],
    productName: json["product__name"],
    productImage: json["product_image"],
    productId: json["product_id"],
    productPrice: json["product_price"],
    userId: json["user_id"],
    productQuantity: json["product_quantity"],
  );

  Map<String, dynamic> toJson() => {
    "row_id": rowId,
    "product__name": productName,
    "product_image": productImage,
    "product_id": productId,
    "product_price": productPrice,
    "user_id": userId,
    "product_quantity": productQuantity,
  };
}
