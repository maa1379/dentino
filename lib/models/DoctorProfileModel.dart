

class DoctorProfileModel {
  DoctorProfileModel({
    this.id,
    this.name,
    this.family,
    this.nationalCode,
    this.phoneNumber,
    this.idPhoto,
    this.profile,
    this.medicalCode,
    this.fullName,
    this.bio,
    this.age,
    this.star,
    this.clinic,
    this.insurance,
    this.expertise,
  });

  int id;
  String name;
  String family;
  String nationalCode;
  String phoneNumber;
  String idPhoto;
  String profile;
  String medicalCode;
  String fullName;
  String bio;
  int age;
  int star;
  Clinic clinic;
  List<Insurance> insurance;
  List<Expertise> expertise;

  factory DoctorProfileModel.fromJson(Map<String, dynamic> json) => DoctorProfileModel(
    id: json["id"],
    name: json["name"],
    family: json["family"],
    nationalCode: json["national_code"],
    phoneNumber: json["phone_number"],
    idPhoto: json["ID_photo"],
    profile: json["profile"],
    medicalCode: json["medical_code"],
    fullName: json["full_name"],
    bio: json["bio"],
    age: json["age"],
    star: json["star"],
    clinic: Clinic.fromJson(json["clinic"]),
    insurance: List<Insurance>.from(json["insurance"].map((x) => Insurance.fromJson(x))),
    expertise: List<Expertise>.from(json["expertise"].map((x) => Expertise.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "family": family,
    "national_code": nationalCode,
    "phone_number": phoneNumber,
    "ID_photo": idPhoto,
    "profile": profile,
    "medical_code": medicalCode,
    "full_name": fullName,
    "bio": bio,
    "age": age,
    "star": star,
    "clinic": clinic.toJson(),
    "insurance": List<dynamic>.from(insurance.map((x) => x.toJson())),
    "expertise": List<dynamic>.from(expertise.map((x) => x.toJson())),
  };
}

class Clinic {
  Clinic({
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
    this.location,
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
  int location;

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    address: json["address"],
    lat: json["lat"].toDouble(),
    long: json["long"].toDouble(),
    instagram: json["instagram"],
    phoneNumber: json["phone_number"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    location: json["location"],
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
    "location": location,
  };
}

class Expertise {
  Expertise({
    this.id,
    this.title,
    this.image,
  });

  int id;
  String title;
  String image;

  factory Expertise.fromJson(Map<String, dynamic> json) => Expertise(
    id: json["id"],
    title: json["title"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
  };
}

class Insurance {
  Insurance({
    this.id,
    this.name,
    this.image,
  });

  int id;
  String name;
  String image;

  factory Insurance.fromJson(Map<String, dynamic> json) => Insurance(
    id: json["id"],
    name: json["name"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
  };
}
