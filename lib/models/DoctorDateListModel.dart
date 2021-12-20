class DoctorDateListModel {
  DoctorDateListModel({
    this.dataList,
  });

  List<DataList> dataList;

  factory DoctorDateListModel.fromJson(Map<String, dynamic> json) => DoctorDateListModel(
    dataList: List<DataList>.from(json["data_list"].map((x) => DataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data_list": List<dynamic>.from(dataList.map((x) => x.toJson())),
  };
}

class DataList {
  DataList({
    this.id,
    this.date,
    this.doctor,
  });

  int id;
  DateTime date;
  int doctor;

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
    id: json["id"],
    date: DateTime.parse(json["date"]),
    doctor: json["doctor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "doctor": doctor,
  };
}