// To parse this JSON data, do
//
//     final clinicListModel = clinicListModelFromJson(jsonString);

class ClinicListModel {
  ClinicListModel({
    this.id,
    this.name,
    this.logo,
    this.address,
    this.lat,
    this.long,
    this.instagram,
    this.phoneNumber,
    this.description,
    this.image1,
    this.image2,
    this.image3,
  });

  int id;
  String name;
  String logo;
  String address;
  double lat;
  double long;
  String instagram;
  String phoneNumber;
  String description;
  String image1;
  String image2;
  String image3;

  factory ClinicListModel.fromJson(Map<String, dynamic> json) => ClinicListModel(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    address: json["address"],
    lat: json["lat"],
    long: json["long"],
    instagram: json["instagram"],
    phoneNumber: json["phone_number"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "address": address,
    "lat": lat,
    "long": long,
    "instagram": instagram,
    "phone_number": phoneNumber,
    "description": description,
    "image1": image1,
    "image2": image2,
    "image3": image3,
  };
}
