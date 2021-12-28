


class DoctorDirectoryModel {
  DoctorDirectoryModel({
    this.id,
    this.word,
    this.meaning,
    this.logo,
    this.category,
  });

  int id;
  String word;
  String meaning;
  String logo;
  int category;

  factory DoctorDirectoryModel.fromJson(Map<String, dynamic> json) => DoctorDirectoryModel(
    id: json["id"],
    word: json["word"],
    meaning: json["meaning"],
    logo: json["logo"],
    category: json["category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "word": word,
    "meaning": meaning,
    "logo": logo,
    "category": category,
  };
}