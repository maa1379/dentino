import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/ItemNumberPanel.dart';
import 'package:dentino/screen/ClinicPanelScreen/HomePanelScreen.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class LoginClinicPanelController extends GetxController {
  LoginClinic({String password, String username}) async {
    RequestHelper.clinicLogin(username: username, password: password)
        .then((value) {
      if (value.isDone) {
        PrefHelper.removeToken();
        PrefHelper.setToken(value.data["access"]);
        EasyLoading.dismiss();
        ViewHelper.showSuccessDialog(Get.context, "شما با موفقیت وارد شدید");
        Get.off(HomePanelScreen());
      } else {
        ViewHelper.showErrorDialog(
            Get.context, "خطلا در اتصال دوباره تلاش کنید");
      }
    });
  }
}

class itemNumberController extends GetxController {
  RxBool loading = false.obs;
  ItemNumberPanel item;

  itemNumber() async {
    RequestHelper.clinicItemNumber(token: await PrefHelper.getToken())
        .then((value) {
      if (value.isDone) {
        item = ItemNumberPanel.fromJson(value.data);
        loading.value = true;
      } else {
        loading.value = false;
        ViewHelper.showErrorDialog(Get.context, "خطلا در اتصال");
      }
    });
  }

  @override
  void onInit() {
    itemNumber();
    super.onInit();
  }
}
