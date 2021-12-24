import 'package:dentino/bloc/getProfileBloc.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'RegisterController.dart';


class ProfileController extends GetxController{


  TextEditingController nameController = TextEditingController();
  TextEditingController familyController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController bDayController = TextEditingController(text: " ");


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
        VerifyController().getProfile();
      }else{
        print("faild");
        ViewHelper.showErrorDialog(Get.context, "پروفایل شما با موفقیت ثبت نشد");
      }
    });
  }





}