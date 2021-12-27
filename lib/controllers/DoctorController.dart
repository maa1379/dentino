import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/DoctorProfileModel.dart';
import 'package:dentino/models/ReserveListModel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class DoctorProfileController extends GetxController {
  RxBool loading = false.obs;
  DoctorProfileModel doctorProfileModel;

  DoctorProfile() async {
    RequestHelper.doctorProfile(doctor_id: Get.arguments['doctorProfile_id'])
        .then((value) {
      if (value.isDone) {
        doctorProfileModel = DoctorProfileModel.fromJson(value.data);
        loading.value = true;
      } else {
        loading.value = false;
        ViewHelper.showErrorDialog(
            Get.context, "دریافت اطلاعات با مشکل مواجه شد");
      }
    });
  }

  @override
  void onInit() {
    DoctorProfile();
    super.onInit();
  }
}

class reserveListController extends GetxController {
  RxList<ReserveListModel> reserveListData = <ReserveListModel>[].obs;

  RxBool loading = false.obs;
  RxBool isDelete = false.obs;

  reserveList() async {
    RequestHelper.reserveList(token: await PrefHelper.getToken()).then((value) {
      if (value.isDone) {
        for (var i in value.data) {
          reserveListData.add(ReserveListModel.fromJson(i));
          loading.value = true;
        }
      } else {
        loading.value = false;
        ViewHelper.showErrorDialog(
            Get.context, "دریافت اطلاعات با مشکل مواجه شد");
      }
    });
  }

  deleteReserve({String reserve_id}) async {
    RequestHelper.deleteReserveItem(reserve_id: reserve_id).then(
      (value) {
        if (value.isDone) {
          ViewHelper.showSuccessDialog(
              Get.context, "نوبت شما با موفقیت حذف شد");
          reserveListData.clear();
          reserveList();
          isDelete.value = true;
          EasyLoading.dismiss();
        } else if (value.statusCode == 202) {
          isDelete.value = false;
          ViewHelper.showErrorDialog(
              Get.context, "نوبت شما امکان حذف شدن ندارد");
          EasyLoading.dismiss();
        } else {
          isDelete.value = false;
          ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
          EasyLoading.dismiss();
        }
      },
    );
  }

  @override
  void onInit() {
    reserveList();
    super.onInit();
  }
}


