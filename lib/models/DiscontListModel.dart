class DiscountListModel {
  DiscountListModel({
    this.clinicName,
    this.percent,
    this.expertiseName,
  });

  String clinicName;
  int percent;
  String expertiseName;

  factory DiscountListModel.fromJson(Map<String, dynamic> json) => DiscountListModel(
    clinicName: json["clinic_name"],
    percent: json["percent"],
    expertiseName: json["expertise_name"],
  );

  Map<String, dynamic> toJson() => {
    "clinic_name": clinicName,
    "percent": percent,
    "expertise_name": expertiseName,
  };
}