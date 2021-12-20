import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/models/PrescriptionsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrescriptionsController extends GetxController{

  RxList<PrescriptionsModel> prescriptionsList = <PrescriptionsModel> [].obs;

  getPrescriptionsList()async{
    RequestHelper.getPrescriptions().then((value){
      if(value.isDone){
        for(var i in value.data){
          prescriptionsList.add(PrescriptionsModel.fromJson(i));
        }
      }else{
        print("faild");
      }
    });
  }

  @override
  void onInit() {
    getPrescriptionsList();
    super.onInit();
  }

}