class GetProfileModel {
  GetProfileModel({
    this.user,
    this.birthday,
    this.name,
    this.family,
    this.nationalCode,
    this.isDone,
  });

  int user;
  String birthday;
  String name;
  String family;
  int nationalCode;
  bool isDone;

  factory GetProfileModel.fromJson(Map<String, dynamic> json) => GetProfileModel(
    user: json["user"],
    birthday: json["birthday"],
    name: json["name"],
    family: json["family"],
    nationalCode: json["national_code"],
    isDone: json["is_done"],
  );

  Map<String, dynamic> toJson() => {
    "user": user,
    "birthday": birthday,
    "name": name,
    "family": family,
    "national_code": nationalCode,
    "is_done": isDone,
  };
}