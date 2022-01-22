



class DoctorTimeListModel {
  DoctorTimeListModel({
    this.data,
    this.myList,
  });

  Data data;
  List<MyList> myList;

  factory DoctorTimeListModel.fromJson(Map<String, dynamic> json) => DoctorTimeListModel(
    data: Data.fromJson(json["data"]),
    myList: List<MyList>.from(json["my_list"].map((x) => MyList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": data.toJson(),
    "my_list": List<dynamic>.from(myList.map((x) => x.toJson())),
  };
}

class Data {
  Data({
    this.id,
    this.day,
    this.date,
    this.startTime,
    this.finishTime,
    this.startTime2,
    this.finishTime2,
    this.doctor,
  });

  int id;
  String day;
  DateTime date;
  DateTime startTime;
  DateTime finishTime;
  DateTime startTime2;
  DateTime finishTime2;
  int doctor;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    day: json["day"],
    date: DateTime.parse(json["date"]),
    startTime: DateTime.parse(json["start_time"]),
    finishTime: DateTime.parse(json["finish_time"]),
    startTime2: DateTime.parse(json["start_time2"]),
    finishTime2: DateTime.parse(json["finish_time2"]),
    doctor: json["doctor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "day": day,
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "start_time": startTime.toIso8601String(),
    "finish_time": finishTime.toIso8601String(),
    "start_time2": startTime2.toIso8601String(),
    "finish_time2": finishTime2.toIso8601String(),
    "doctor": doctor,
  };
}

class MyList {
  MyList({
    this.name,
  });

  String name;

  factory MyList.fromJson(Map<String, dynamic> json) => MyList(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
