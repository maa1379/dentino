



class ClinicListModel {
  ClinicListModel({
    this.name,
    this.logo,
    this.address,
    this.instagram,
    this.phoneNumber,
    this.clinicDescription,
    this.image1,
    this.image2,
    this.image3,
    this.location,
    this.type,
    this.insurances,
    this.zoneName,
    this.companies,
    this.id,
  });

  String name;
  String logo;
  String address;
  String instagram;
  String phoneNumber;
  String clinicDescription;
  String image1;
  String image2;
  String image3;
  int location;
  String type;
  List<Insurance> insurances;
  String zoneName;
  List<Company> companies;
  int id;

  factory ClinicListModel.fromJson(Map<String, dynamic> json) => ClinicListModel(
    name: json["name"],
    logo: json["logo"],
    address: json["address"],
    instagram: json["instagram"],
    phoneNumber: json["phone_number"],
    clinicDescription: json["clinic_description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    location: json["location"],
    type: json["type"],
    insurances: List<Insurance>.from(json["insurances"].map((x) => Insurance.fromJson(x))),
    zoneName: json["zone_name"],
    companies: List<Company>.from(json["companies"].map((x) => Company.fromJson(x))),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "logo": logo,
    "address": address,
    "instagram": instagram,
    "phone_number": phoneNumber,
    "clinic_description": clinicDescription,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "location": location,
    "type": type,
    "insurances": List<dynamic>.from(insurances.map((x) => x.toJson())),
    "zone_name": zoneName,
    "companies": List<dynamic>.from(companies.map((x) => x.toJson())),
    "id": id,
  };
}

class Company {
  Company({
    this.title,
    this.id,
  });

  String title;
  int id;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
    title: json["title"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "id": id,
  };
}

class Insurance {
  Insurance({
    this.name,
    this.image,
    this.id,
  });

  String name;
  String image;
  int id;

  factory Insurance.fromJson(Map<String, dynamic> json) => Insurance(
    name: json["name"],
    image: json["image"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "image": image,
    "id": id,
  };
}
