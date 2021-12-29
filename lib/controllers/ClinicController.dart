import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/models/ClinicListModel.dart';
import 'package:dentino/models/DataFilterListModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClinicController extends GetxController {
  RxList<ClinicListModel> clinicList = <ClinicListModel>[].obs;

  getClinicList() async {
    RequestHelper.getClinicList().then((value) {
      if (value.isDone) {
        print(value.data);
        for (var i in value.data) {
          clinicList.add(ClinicListModel.fromJson(i));
        }
      } else {
        print("faild");
      }
    });
  }

  @override
  void onInit() {
    getClinicList();
    super.onInit();
  }
}

class ProfileClinicController extends GetxController {
  ClinicListModel clinicProfile;
  RxList images = [].obs;
  RxBool loading = false.obs;
  RxList<Insurance> InsuranceList = <Insurance>[].obs;
  RxList<Company> CompanyList = <Company>[].obs;

  getClinicProfile() async {
    RequestHelper.clinicProfile(
            id: Get.arguments['clinicProfile_id'].toString())
        .then((value) {
      if (value.isDone) {
        for (var i in value.data['insurances']) {
          InsuranceList.add(Insurance.fromJson(i));
        }

        for (var i in value.data['companies']) {
          CompanyList.add(Company.fromJson(i));
        }
        print(value.data);
        clinicProfile = ClinicListModel.fromJson(value.data);
        images.add(clinicProfile.image1);
        images.add(clinicProfile.image2);
        images.add(clinicProfile.image3);
        loading.value = true;
      } else {
        loading.value = false;
        print("faild");
      }
      update();
    });
  }

  @override
  void onInit() {
    getClinicProfile();
    super.onInit();
  }
}
