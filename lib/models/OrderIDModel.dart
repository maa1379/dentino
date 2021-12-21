class OrderIdModel {
  OrderIdModel({
    this.orderId,
  });

  int orderId;

  factory OrderIdModel.fromJson(Map<String, dynamic> json) => OrderIdModel(
    orderId: json["order_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
  };
}
