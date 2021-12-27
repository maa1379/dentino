

class ReserveListModel {
  ReserveListModel({
    this.id,
    this.name,
    this.family,
    this.phoneNumber,
    this.nationalCode,
    this.user,
    this.day,
    this.time,
    this.created,
    this.drCl,
    this.drClName,
    this.doctorName,
    this.doctorId,
  });

  int id;
  String name;
  String family;
  String phoneNumber;
  String nationalCode;
  int user;
  String day;
  String time;
  DateTime created;
  int drCl;
  String drClName;
  String doctorName;
  int doctorId;

  factory ReserveListModel.fromJson(Map<String, dynamic> json) => ReserveListModel(
    id: json["id"],
    name: json["name"],
    family: json["family"],
    phoneNumber: json["phone_number"],
    nationalCode: json["national_code"],
    user: json["user"],
    day: json["day"],
    time: json["time"],
    created: DateTime.parse(json["created"]),
    drCl: json["dr_cl"],
    drClName: json["dr_cl_name"],
    doctorName: json["doctor_name"],
    doctorId: json["doctor_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "family": family,
    "phone_number": phoneNumber,
    "national_code": nationalCode,
    "user": user,
    "day": day,
    "time": time,
    "created": created.toIso8601String(),
    "dr_cl": drCl,
    "dr_cl_name": drClName,
    "doctor_name": doctorName,
    "doctor_id": doctorId,
  };
}
