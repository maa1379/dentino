import 'dart:async';

import 'package:dentino/models/GetProfileModel.dart';


class GetProfileBloc {
  final streamController = StreamController.broadcast();

  Stream get getStream => streamController.stream;

  GetProfileModel profile;

  void getProfile(GetProfileModel item) {
    profile = item;
    streamController.sink.add(this.profile);
  }
}


final GetProfileBloc getProfileBlocInstance = new GetProfileBloc();