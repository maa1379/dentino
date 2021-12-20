
class DoctorListModel {
  DoctorListModel({
    this.id,
    this.fullName,
    this.clinicName,
    this.profileUrl,
    this.expertise,
    this.insurance,
  });

  int id;
  String fullName;
  String clinicName;
  String profileUrl;
  List<Expertise> expertise;
  List<Insurance> insurance;

  factory DoctorListModel.fromJson(Map<String, dynamic> json) => DoctorListModel(
    id: json["id"],
    fullName: json["full_name"],
    clinicName: json["clinic_name"],
    profileUrl: json["profile_url"],
    expertise: List<Expertise>.from(json["expertise"].map((x) => Expertise.fromJson(x))),
    insurance: List<Insurance>.from(json["insurance"].map((x) => Insurance.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "clinic_name": clinicName,
    "profile_url": profileUrl,
    "expertise": List<dynamic>.from(expertise.map((x) => x.toJson())),
    "insurance": List<dynamic>.from(insurance.map((x) => x.toJson())),
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
