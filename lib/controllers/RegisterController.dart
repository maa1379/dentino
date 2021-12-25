import 'dart:async';
import 'package:dentino/bloc/getProfileBloc.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/GetProfileModel.dart';
import 'package:dentino/screen/HomeScreen.dart';
import 'package:dentino/screen/PinCodeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'ProfileController.dart';

class RegisterController extends GetxController {
  final RoundedLoadingButtonController btnController1 =
      RoundedLoadingButtonController();
  TextEditingController mobileController = TextEditingController();

  register({String mobile}) async {
    RequestHelper.register(mobile: mobile).then(
      (value) {
        if (!value.isDone) {
          Get.snackbar("", "ارسال کد با موفقیت انجام شد",
              icon: Icon(Icons.error, color: Colors.green),
              snackPosition: SnackPosition.TOP,
              colorText: Colors.black,
              borderWidth: 0.5,
              borderColor: Colors.green,
              borderRadius: 15);

          Get.to(PinCodeScreen(mobileController.text));
        } else {
          Get.snackbar("", "ارسال کد با خطا مواجه شد",
              icon: Icon(Icons.error, color: Colors.red),
              snackPosition: SnackPosition.TOP,
              colorText: Colors.black,
              borderWidth: 0.5,
              borderColor: Colors.red,
              borderRadius: 15);
        }
      },
    );
  }
}

class VerifyController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  final RoundedLoadingButtonController btnController2 =
      RoundedLoadingButtonController();

  @override
  void onInit() {
    textEditingController = TextEditingController(text: "");
    startTimer();
    super.onInit();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  verifyCode({String code, mobile}) async {
    RequestHelper.verify(code: code, mobile: mobile).then(
      (value) {
        if (value.statusCode == 201) {
          PrefHelper.setToken(value.data['access']);
          PrefHelper.setMobile(mobile);
          if (value.data['registerd'] == "True") {
            getProfile();
            Get.off(HomeScreen());
          } else {
            ProfileController().showRegisterFormModal();
          }
        } else {
          btnController2.reset();
          Get.snackbar("", "ورود با خطا مواجه شد",
              icon: Icon(Icons.error, color: Colors.red),
              snackPosition: SnackPosition.TOP,
              colorText: Colors.black,
              borderWidth: 0.5,
              borderColor: Colors.red,
              borderRadius: 15);
        }
      },
    );
  }

  getProfile() async {
    RequestHelper.getProfile(token: await PrefHelper.getToken()).then((value) {
      if (value.isDone) {
        getProfileBlocInstance.getProfile(GetProfileModel.fromJson(value.data));
      } else if (value.statusCode == 410) {
        print("not ok");
      } else {
        ViewHelper.showErrorDialog(
            Get.context, "عدم اتصال با سرور دوباره تلاش کنید");
      }
    });
  }

  Timer timer;
  RxInt start = 59.obs;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start.value == 0) {
          timer.cancel();
        } else {
          start--;
        }
      },
    );
    update();
  }
}
