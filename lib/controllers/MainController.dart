import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/ContactUsModel.dart';
import 'package:dentino/models/DiscontListModel.dart';
import 'package:dentino/models/DoctorProfileModel.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class ContactUSController extends GetxController {
  ContactUsModel contactUsModel;

  getContactUs() async {
    RequestHelper.contactUs().then(
      (value) {
        if (value.isDone) {
          contactUsModel = ContactUsModel.fromJson(value.data);
        } else {
          print("faild");
        }
        update();
      },
    );
  }

  @override
  void onReady() {
    getContactUs();
    super.onReady();
  }
}

class AboutUSController extends GetxController {
  AboutUsModel aboutUsModel;

  getAboutUs() async {
    RequestHelper.aboutUs().then(
      (value) {
        if (value.isDone) {
          aboutUsModel = AboutUsModel.fromJson(value.data);
          print(aboutUsModel);
        } else {
          print("faild");
        }

        update();
      },
    );
  }

  @override
  void onReady() {
    getAboutUs();
    super.onReady();
  }
}

class SliderController extends GetxController {
  RxList<SliderModel> sliderList = <SliderModel>[].obs;

  RxBool loaded = false.obs;

  getSlider() async {
    RequestHelper.slider().then(
      (value) {
        if (value.isDone) {
          sliderList.clear();
          for (var i in value.data) {
            sliderList.add(SliderModel.fromJson(i));
          }
          loaded.value = true;
        } else {
          loaded.value = false;
          ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
        }
        update();
      },
    );
  }

  @override
  void onInit() {
    getSlider();
    super.onInit();
  }
}

// class InsuranceController extends GetxController {
//   RxList<SliderModel> sliderList = <SliderModel>[].obs;
//
//
//   getSlider() async {
//     RequestHelper.insurance().then(
//           (value) {
//         print(value.data);
//         for (var i in value.data) {
//           sliderList.add(SliderModel.fromJson(i));
//         }
//       },
//     );
//   }
//
//   @override
//   void onReady() {
//     getSlider();
//     super.onReady();
//   }
//
// }

class ComplimentCreate extends GetxController {
  final dropDownValueClinic = "انتخاب کنید".obs;
  final dropDownValueDoctor = "انتخاب کنید".obs;

  RxBool loading = false.obs;

  RxList<DoctorProfileModel> doctorList = <DoctorProfileModel>[].obs;

  void setSelected1(String value) {
    dropDownValueClinic.value = value;
  }

  void setSelected2(String value) {
    dropDownValueDoctor.value = value;
  }

  compliment({String text}) async {
    RequestHelper.complimentCreate(
            text: text,
            token: await PrefHelper.getToken(),
            clinic_id: this.dropDownValueClinic.value.toString(),
            doctor_id: this.dropDownValueDoctor.value.toString())
        .then((value) {
      if (value.isDone) {
        ViewHelper.showSuccessDialog(Get.context, "پیام شما با موفقیت ثبت شد");
      } else {
        ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
      }
    });
  }

  DoctorList() async {
    RequestHelper.clinicDoctorList(
            clinic_id: dropDownValueClinic.value.toString())
        .then((value) {
      if (value.isDone == true) {
        for (var i in value.data) {
          doctorList.add(DoctorProfileModel.fromJson(i));
        }
        loading.value = true;
        EasyLoading.dismiss();
      } else {
        loading.value = false;
        ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
      }
    });
  }
}

class DiscountController extends GetxController {
  RxList<DiscountListModel> DiscountList = <DiscountListModel>[].obs;
  RxBool loading = false.obs;

  DiscountListApi() async {
    RequestHelper.DiscountListApi().then(
      (value) {
        if (value.isDone) {
          for (var i in value.data) {
            DiscountList.add(DiscountListModel.fromJson(i));
          }
          loading.value = true;
        } else {
          loading.value = false;
          ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
        }
      },
    );
  }

  @override
  void onInit() {
    DiscountListApi();
    super.onInit();
  }
}
