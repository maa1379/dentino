

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
    this.parvanehTebabat,
    this.verified,
    this.insurance,
    this.clinic,
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
  String parvanehTebabat;
  bool verified;
  List<Insurance> insurance;
  List<Clinic> clinic;
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
    parvanehTebabat: json["parvaneh_tebabat"],
    verified: json["verified"],
    insurance: List<Insurance>.from(json["insurance"].map((x) => Insurance.fromJson(x))),
    clinic: List<Clinic>.from(json["clinic"].map((x) => Clinic.fromJson(x))),
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
    "parvaneh_tebabat": parvanehTebabat,
    "verified": verified,
    "insurance": List<dynamic>.from(insurance.map((x) => x.toJson())),
    "clinic": List<dynamic>.from(clinic.map((x) => x.toJson())),
    "expertise": List<dynamic>.from(expertise.map((x) => x.toJson())),
  };
}

class Clinic {
  Clinic({
    this.id,
    this.name,
    this.logo,
    this.address,
    this.instagram,
    this.whatsUp,
    this.telegram,
    this.phoneNumber,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.type,
    this.verified,
    this.contracted,
    this.parvanehClinic,
    this.parvanehMasole,
    this.notification,
    this.location,
    this.company,
  });

  int id;
  String name;
  String logo;
  String address;
  String instagram;
  String whatsUp;
  String telegram;
  String phoneNumber;
  String description;
  String image1;
  String image2;
  String image3;
  String type;
  bool verified;
  bool contracted;
  String parvanehClinic;
  String parvanehMasole;
  String notification;
  int location;
  List<int> company;

  factory Clinic.fromJson(Map<String, dynamic> json) => Clinic(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    address: json["address"],
    instagram: json["instagram"],
    whatsUp: json["whats_up"],
    telegram: json["telegram"],
    phoneNumber: json["phone_number"],
    description: json["description"],
    image1: json["image1"],
    image2: json["image2"],
    image3: json["image3"],
    type: json["type"],
    verified: json["verified"],
    contracted: json["contracted"],
    parvanehClinic: json["parvaneh_clinic"],
    parvanehMasole: json["parvaneh_masole"],
    notification: json["notification"],
    location: json["location"],
    company: List<int>.from(json["company"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "address": address,
    "instagram": instagram,
    "whats_up": whatsUp,
    "telegram": telegram,
    "phone_number": phoneNumber,
    "description": description,
    "image1": image1,
    "image2": image2,
    "image3": image3,
    "type": type,
    "verified": verified,
    "contracted": contracted,
    "parvaneh_clinic": parvanehClinic,
    "parvaneh_masole": parvanehMasole,
    "notification": notification,
    "location": location,
    "company": List<dynamic>.from(company.map((x) => x)),
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
