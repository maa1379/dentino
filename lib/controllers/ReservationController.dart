import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/bloc/timeBloc.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/helpers/widgetHelper.dart';
import 'package:dentino/models/DataFilterListModel.dart';
import 'package:dentino/models/DoctorDateListModel.dart';
import 'package:dentino/models/DoctorListModel.dart';
import 'package:dentino/models/DoctorTimeListModel.dart';
import 'package:dentino/models/LocationModel.dart';
import 'package:dentino/models/ProvinceModel.dart';
import 'package:dentino/models/exertiseListModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:snapping_sheet/snapping_sheet.dart';
import 'DoctorController.dart';

class ExertiseController extends GetxController {
  @override
  void onInit() {
    exertiseList();
    super.onInit();
  }

  RxBool loading = false.obs;

  List<ExertiseListModel> exertiseListData = [];

  exertiseList() async {
    RequestHelper.exertiseGet().then(
      (value) {
        if (value.isDone == true) {
          exertiseListData.clear();
          print(value.data);
          for (var list in value.data) {
            exertiseListData.add(ExertiseListModel.fromJson(list));
          }
          loading.value = true;
        } else {
          loading.value = false;
        }
      },
    );
  }
}

class DoctorController extends GetxController {
  @override
  void onInit() {
    doctorFilter();
    dataFilterList();
    super.onInit();
  }

  final dropDownValue1 = "انتخاب کنید".obs;
  final dropDownValue2 = "انتخاب کنید".obs;
  final dropDownValue6 = "انتخاب کنید".obs;

  void setSelected1(String value) {
    dropDownValue1.value = value;
  }

  void setSelected2(String value) {
    dropDownValue2.value = value;
  }

  void setSelected6(String value) {
    dropDownValue6.value = value;
  }

  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController lNameController = TextEditingController();
  TextEditingController nationalCodeController = TextEditingController();
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  SnappingSheetController snappingSheetController = SnappingSheetController();
  final RoundedLoadingButtonController btnController2 =
      RoundedLoadingButtonController();

  RxBool loading1 = false.obs;
  RxBool loading2 = false.obs;
  RxBool loadingDate = false.obs;
  RxList<DoctorListModel> doctorListData = <DoctorListModel>[].obs;
  RxList<LocationModel> locationList = <LocationModel>[].obs;
  RxList<DataList> doctorDateListData = <DataList>[].obs;
  RxList<DoctorTimeListModel> doctorTimeListData = <DoctorTimeListModel>[].obs;
  RxList<ClinicFilterModel> clinicFilterList = <ClinicFilterModel>[].obs;
  RxList<InsuranceFilterModel> insuranceFilterList =
      <InsuranceFilterModel>[].obs;

  doctorFilter() async {
    RequestHelper.doctorFilter(
            expertise_id: Get.arguments["expertise_id2"].toString(),
            clinic: (dropDownValue2.value == "انتخاب کنید")
                ? ""
                : dropDownValue2.value.toString(),
            insurance: (dropDownValue1.value == "انتخاب کنید")
                ? ""
                : dropDownValue1.value.toString(),
            zone: Get.arguments["zone_id"],
            clinic_type: (dropDownValue6.value == "انتخاب کنید")
                ? ""
                : dropDownValue6.value.toString(),
            city: Get.arguments["city_id_dropdown"])
        .then(
      (value) {
        if (value.isDone == true || value.statusCode == 201) {
          for (var list in value.data) {
            doctorListData.add(DoctorListModel.fromJson(list));
          }
          loading1.value = true;
        } else {
          loading1.value = false;
        }
      },
    );
  }

  dataFilterList() async {
    RequestHelper.dataFilterList().then(
      (value) {
        if (value.isDone == true) {
          for (var list in value.data['clinic']) {
            clinicFilterList.add(ClinicFilterModel.fromJson(list));
          }
          for (var list in value.data['insurance']) {
            insuranceFilterList.add(InsuranceFilterModel.fromJson(list));
          }
          loading2.value = true;
        } else {
          loading2.value = false;
        }
      },
    );
  }

  // doctorList() async {
  //   RequestHelper.exertisePost(id: Get.arguments['expertise_id'].toString())
  //       .then(
  //     (value) {
  //       if (value.isDone == true) {
  //         doctorListData.clear();
  //         print(value.data);
  //         for (var list in value.data['doctor_list']) {
  //           doctorListData.add(DoctorListModel.fromJson(list));
  //         }
  //
  //         loading.value = true;
  //       } else {
  //         loading.value = false;
  //       }
  //     },
  //   );
  // }

  doctorDateList({String id}) async {
    RequestHelper.doctorDateList(id: id).then(
      (value) {
        if (value.isDone == true) {
          doctorDateListData.clear();
          print(value.data);
          for (var list in value.data['data_list']) {
            doctorDateListData.add(DataList.fromJson(list));
          }
          EasyLoading.dismiss();
          loadingDate.value = true;
          showDateTimeModal();
        } else {
          loadingDate.value = false;
        }
      },
    );
  }

  reserveApi({String date_id, String doctor_id, String time}) async {
    RequestHelper.reserveApi(
            family: lNameController.text,
            name: nameController.text,
            phone_number: phoneController.text,
            national_code: nationalCodeController.text,
            date_id: date_id.toString(),
            doctor_id: doctor_id.toString(),
            token: await PrefHelper.getToken(),
            time: time.toString())
        .then(
      (value) {
        if (value.statusCode == 201) {
          loadingDate.value = true;
          Get.back();
          Get.back();
          Get.back();
          Get.snackbar("", "نوبت شما با موفقیت ثبت گردید",
              icon: Icon(Icons.check_circle_outline, color: Colors.green),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.black,
              borderWidth: 2,
              borderColor: Colors.green,
              borderRadius: 15);
          Get.find<reserveListController>().reserveListData.clear();
          Get.find<reserveListController>().reserveList();
          reserveListController().reserveList();
        } else {
          loadingDate.value = false;
          Get.back();
          Get.back();
          Get.back();
          Get.snackbar("", "نوبت شما با موفقیت ثبت نگردید",
              icon: Icon(Icons.error, color: Colors.red),
              snackPosition: SnackPosition.BOTTOM,
              colorText: Colors.black,
              borderWidth: 2,
              borderColor: Colors.red,
              borderRadius: 15);
        }
      },
    );
  }

  List<MyList> data = [];
  List<DoctorTimeListModel> data2 = [];

  doctorTimeList({String doctorId, String dateId}) async {
    RequestHelper.doctorTimeList(doctorId: doctorId, dateId: dateId).then(
      (value) {
        print(value.data['data']);
        print("****************");
        print(value.data['my_list']);
        if (value.isDone == true) {
          getTimeItemBlocInstance
              .getItem(DoctorTimeListModel.fromJson(value.data));
          doctorDateListData.clear();
          for (var list in value.data['my_list']) {
            data.add(MyList.fromJson(list));
          }
          print(getTimeItemBlocInstance.timeItem.data.doctor.toString());

          EasyLoading.dismiss();
          loadingDate.value = true;
          _showTimeModal();
        } else {
          loadingDate.value = false;
        }
      },
    );
  }

  showDateTimeModal() {
    return showCupertinoModalBottomSheet(
      context: Get.context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: false,
      isDismissible: true,
      builder: (context) => Container(
        height: Get.height * .8,
        margin: EdgeInsets.all(Get.width * .02),
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * .005),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * .02),
                child: AutoSizeText(
                  "نوبت شما چه روزی باشد؟",
                  maxFontSize: 24,
                  minFontSize: 6,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorsHelper.mainColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Get.height * .75,
                width: Get.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .05, vertical: Get.height * .02),
                child: AnimationLimiter(
                  child: GridView.builder(
                      itemCount: doctorDateListData.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.2,
                        crossAxisCount: 2,
                      ),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: buildDateTimeItem),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildDateTimeItem(BuildContext context, int index) {
    var item = doctorDateListData[index];
    return AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: 2,
      duration: const Duration(milliseconds: 500),
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: Container(
            height: Get.height * .2,
            width: Get.width * .3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 5, spreadRadius: 2),
                ]),
            margin: EdgeInsets.all(Get.width * .02),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green.shade100,
                child: InkWell(
                  onTap: () {
                    doctorTimeList(
                        doctorId: doctorDateListData[index].doctor.toString(),
                        dateId: item.id.toString());
                    EasyLoading.show(
                      indicator: CircularProgressIndicator(),
                      dismissOnTap: true,
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/calendar.png",
                          width: Get.width * .12,
                        ),
                        AutoSizeText(
                          item.date.toString().replaceAll("-", "/"),
                          maxFontSize: 24,
                          minFontSize: 6,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        // AutoSizeText(
                        //   "",
                        //   maxFontSize: 24,
                        //   minFontSize: 6,
                        //   maxLines: 1,
                        //   textAlign: TextAlign.center,
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 18,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showTimeModal() {
    return showCupertinoModalBottomSheet(
      context: Get.context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: false,
      isDismissible: true,
      builder: (context) => Container(
        height: Get.height * .8,
        margin: EdgeInsets.all(Get.width * .02),
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * .005),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * .02),
                child: AutoSizeText(
                  "نوبت شما چه ساعتی باشد؟",
                  maxFontSize: 24,
                  minFontSize: 6,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorsHelper.mainColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Get.height * .75,
                width: Get.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .05, vertical: Get.height * .02),
                child: AnimationLimiter(
                  child: GridView.builder(
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.5,
                        crossAxisCount: 2,
                      ),
                      physics: BouncingScrollPhysics(),
                      itemBuilder: _buildTimeItem),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeItem(BuildContext context, int index) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: 2,
      duration: const Duration(milliseconds: 500),
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: Container(
            height: Get.height * .2,
            width: Get.width * .3,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, blurRadius: 5, spreadRadius: 2),
                ]),
            margin: EdgeInsets.all(Get.width * .02),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Material(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green.shade100,
                child: InkWell(
                  onTap: () {
                    _buildPatientProfileModal(
                        time: data[index].name,
                        doctor_id: getTimeItemBlocInstance.timeItem.data.doctor
                            .toString(),
                        date_id: getTimeItemBlocInstance.timeItem.data.id
                            .toString());
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/clock.png",
                          width: Get.width * .12,
                        ),
                        AutoSizeText(
                          "ساعت:${data[index].name}",
                          maxFontSize: 24,
                          minFontSize: 6,
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildPatientProfileModal({String time, String date_id, String doctor_id}) {
    return showCupertinoModalBottomSheet(
      context: Get.context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: false,
      isDismissible: true,
      builder: (context) => Container(
        height: Get.height * .8,
        margin: EdgeInsets.all(Get.width * .02),
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * .005),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * .02),
                child: AutoSizeText(
                  "مشخصات بیمار را وارد کنید",
                  maxFontSize: 24,
                  minFontSize: 6,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorsHelper.mainColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: Get.height * .75,
                  width: Get.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * .05, vertical: Get.height * .02),
                  child: Column(
                    children: [
                      SizedBox(
                        height: Get.height * .1,
                      ),
                      _buildNameField(),
                      SizedBox(
                        height: Get.height * .02,
                      ),
                      _buildLNameField(),
                      SizedBox(
                        height: Get.height * .02,
                      ),
                      _buildMobileField(),
                      SizedBox(
                        height: Get.height * .02,
                      ),
                      _buildNationalCodeField(),
                      SizedBox(
                        height: Get.height * .1,
                      ),
                      submitBtn(
                          date_id: date_id, doctor_id: doctor_id, time: time),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  submitBtn({String time, String date_id, String doctor_id}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
      child: RoundedLoadingButton(
        height: Get.height * .055,
        width: Get.width,
        successColor: Color(0xff077F7F),
        color: Colors.blue,
        child: AutoSizeText(
          "ثبت نوبت",
          maxLines: 1,
          maxFontSize: 22,
          minFontSize: 10,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        controller: _btnController1,
        animateOnTap: true,
        onPressed: () {
          reserveApi(time: time, doctor_id: doctor_id, date_id: date_id);
        },
      ),
    );
  }

  _buildLNameField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .07,
      color: Colors.transparent,
      fontSize: 12,
      hintText: "نام خانوادگی خود را وارد کنید",
      enabled: true,
      text: "نام خانوادگی",
      onChange: (value) {
// WidgetHelper.onChange(value, mobileController);
      },
      controller: lNameController,
// errorText: "شماره موبایل خود را وارد کنید!",
      size: Get.size,
      maxLine: 1,
      maxLength: 120,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.text,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
    );
  }

  _buildNameField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .07,
      color: Colors.transparent,
      fontSize: 12,
      hintText: "نام خود را وارد کنید",
      enabled: true,
      text: "نام",
      onChange: (value) {
// WidgetHelper.onChange(value, mobileController);
      },
      controller: nameController,
// errorText: "شماره موبایل خود را وارد کنید!",
      size: Get.size,
      maxLine: 1,
      maxLength: 120,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.text,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
    );
  }

  _buildMobileField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .07,
      color: Colors.transparent,
      fontSize: 12,
      hintText: "شماره خود را وارد کنید",
      enabled: true,
      text: "شماره موبایل",
      onChange: (value) {
        WidgetHelper.onChange(value, phoneController);
      },
      controller: phoneController,
// errorText: "شماره موبایل خود را وارد کنید!",
      size: Get.size,
      maxLine: 1,
      maxLength: 120,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.number,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
    );
  }

  _buildNationalCodeField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .07,
      color: Colors.transparent,
      fontSize: 12,
      hintText: "کد ملی خود را وارد کنید",
      enabled: true,
      text: "کد ملی",
      onChange: (value) {
// WidgetHelper.onChange(value, mobileController);
      },
      controller: nationalCodeController,
// errorText: "شماره موبایل خود را وارد کنید!",
      size: Get.size,
      maxLine: 1,
      maxLength: 20,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.number,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
    );
  }
}

class CityController extends GetxController {
  @override
  void onInit() {
    Province();
    super.onInit();
  }

  final dropDownValue3 = "انتخاب کنید".obs;
  final dropDownValue4 = "انتخاب کنید".obs;
  final dropDownValue5 = "انتخاب کنید".obs;

  RxList<ProvinceModel> ProvinceDataList = <ProvinceModel>[].obs;
  RxList<CityModel> CityDataList = <CityModel>[].obs;
  RxList<ZoneModel> zoneDataList = <ZoneModel>[].obs;

  void setSelected3(String value) {
    dropDownValue3.value = value;
  }

  void setSelected4(String value) {
    dropDownValue4.value = value;
  }

  void setSelected5(String value) {
    dropDownValue5.value = value;
  }

  RxBool loadingCity = false.obs;
  RxBool loadingZone = false.obs;

  Province() async {
    RequestHelper.provinceList().then(
      (value) {
        if (value.isDone == true) {
          ProvinceDataList.clear();
          for (var list in value.data["province"]) {
            ProvinceDataList.add(ProvinceModel.fromJson(list));
          }
          // loading.value = true;
        } else {
          // loading.value = false;
        }
      },
    );
  }

  City({String province_id}) async {
    RequestHelper.CityList(province_id: province_id).then(
      (value) {
        if (value.isDone == true) {
          CityDataList.clear();
          for (var list in value.data["city"]) {
            CityDataList.add(CityModel.fromJson(list));
          }
          loadingCity.value = true;
          EasyLoading.dismiss();
        } else {
          loadingCity.value = false;
        }
      },
    );
  }

  Zone({String city_id}) async {
    RequestHelper.ZoneList(city_id: city_id).then(
      (value) {
        if (value.isDone == true) {
          zoneDataList.clear();
          for (var list in value.data) {
            zoneDataList.add(ZoneModel.fromJson(list));
          }
          loadingZone.value = true;
          EasyLoading.dismiss();
        } else {
          loadingZone.value = false;
        }
      },
    );
  }
}
