import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/DoctorProfileModel.dart';
import 'package:dentino/models/ReserveListModel.dart';
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

  reserveList() async {
    RequestHelper.reserveList(token: await PrefHelper.getToken()).then((value) {
      if (value.isDone) {
        for (var i in value.data) {
          reserveListData.add(ReserveListModel.fromJson(i));
        }
      } else {
        ViewHelper.showErrorDialog(
            Get.context, "دریافت اطلاعات با مشکل مواجه شد");
      }
    });
  }

  @override
  void onInit() {
    reserveList();
    super.onInit();
  }
}
