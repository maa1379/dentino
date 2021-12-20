class DoctorTimeListModel {
  DoctorTimeListModel({
    this.id,
    this.date,
    this.startTime,
    this.finishTime,
    this.isReserved,
    this.doctor,
  });

  int id;
  DateTime date;
  DateTime startTime;
  DateTime finishTime;
  bool isReserved;
  int doctor;

  factory DoctorTimeListModel.fromJson(Map<String, dynamic> json) => DoctorTimeListModel(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    startTime: DateTime.parse(json["start_time"]),
    finishTime: DateTime.parse(json["finish_time"]),
    isReserved: json["is_reserved"],
    doctor: json["doctor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "start_time": startTime.toIso8601String(),
    "finish_time": finishTime.toIso8601String(),
    "is_reserved": isReserved,
    "doctor": doctor,
  };
}