

import 'dart:async';

import 'package:dentino/models/DoctorTimeListModel.dart';

class GetTimeItemBloc {
  final streamController = StreamController.broadcast();

  Stream get getStream => streamController.stream;

  DoctorTimeListModel timeItem;

  void getItem(DoctorTimeListModel item) {
    timeItem = item;
    streamController.sink.add(this.timeItem);
  }
}


final GetTimeItemBloc getTimeItemBlocInstance = new GetTimeItemBloc();