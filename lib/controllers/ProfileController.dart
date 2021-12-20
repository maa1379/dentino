import 'package:dentino/bloc/getProfileBloc.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class ProfileController extends GetxController{





  updateProfile(
      {String name,
      String family,
      String national_code,
      String birthday})async{
    RequestHelper.updateProfile(national_code:national_code ,birthday: birthday,name: name,family: family,token: await PrefHelper.getToken()).then((value){
      print(value.data);
      if(value.isDone){
        print("ok");
        ViewHelper.showSuccessDialog(Get.context, "پروفایل شما با موفقیت ثبت شد");
      }else{
        print("faild");
        ViewHelper.showErrorDialog(Get.context, "پروفایل شما با موفقیت ثبت نشد");
      }
    });
  }





}