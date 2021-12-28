import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/models/DirectoryCategoryModel.dart';
import 'package:dentino/models/DoctorDirectoryModel.dart';
import 'package:get/get.dart';

class DirectoryController extends GetxController {
  RxList<DirectoryCategoryModel> CategoryList = <DirectoryCategoryModel>[].obs;

  DirectoryCategoryData() async {
    RequestHelper.DirectoryCategory().then((value) {
      if (value.isDone) {
        for (var i in value.data) {
          CategoryList.add(DirectoryCategoryModel.fromJson(i));
        }
      } else {
        ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
      }
    });
  }

  @override
  void onInit() {
    DirectoryCategoryData();
    super.onInit();
  }

}


class DoctorDirectoryController extends GetxController {
  RxList<DoctorDirectoryModel> DirectoryList = <DoctorDirectoryModel>[].obs;
  RxBool loading = false.obs;

  DoctorDirectoryData() async {
    RequestHelper.DoctorDirectoryList(cat_id: Get.arguments["cat_id"]).then((value) {
      print(value.data);
      if (value.isDone) {
        for (var i in value.data) {
          DirectoryList.add(DoctorDirectoryModel.fromJson(i));
        }
        loading.value = true;
      } else {
        loading.value = false;
        ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
      }
    });
  }

  @override
  void onInit() {
    DoctorDirectoryData();
    super.onInit();
  }

}