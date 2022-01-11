import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/DataFilterListModel.dart';
import 'package:dentino/models/exertiseListModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PrizeController extends GetxController {
  final RoundedLoadingButtonController btnController2 =
      RoundedLoadingButtonController();

  final dropDownValue3 = "انتخاب کنید".obs;
  final dropDownValue4 = "انتخاب کنید".obs;

  void setSelected3(String value) {
    dropDownValue3.value = value;
  }

  void setSelected4(String value) {
    dropDownValue4.value = value;
  }

  PrizeApi() async {
    RequestHelper.Prize(
            token: await PrefHelper.getToken(),
            clinic: (dropDownValue3.value == "انتخاب کنید")
                ? ""
                : dropDownValue3.value.toString(),
            expertise: (dropDownValue4.value == "انتخاب کنید")
                ? ""
                : dropDownValue4.value.toString())
        .then((value) {
      if (value.isDone) {
        ViewHelper.showSuccessDialog(
            Get.context, "کارت شما با موفقیت صادر گردید به کلینیک مراجعه کنید");
      } else {
        ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
      }
    });
  }

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
        } else {
          print("no ok");
        }
      },
    );
  }

  RxList<ClinicFilterModel> clinicFilterList = <ClinicFilterModel>[].obs;

  dataFilterList() async {
    RequestHelper.dataFilterList().then(
      (value) {
        if (value.isDone == true) {
          for (var list in value.data['clinic']) {
            clinicFilterList.add(ClinicFilterModel.fromJson(list));
          }
        } else {
          print("no ok");
        }
      },
    );
  }

  PrizeModal() {
    return showCupertinoModalBottomSheet(
      context: Get.context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: false,
      isDismissible: true,
      builder: (context) => Container(
        height: Get.height * .6,
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
                  "سبد خرید شما",
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
                height: Get.height * .6,
                width: Get.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .04, vertical: Get.height * .05),
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * .05,
                    ),
                    _buildClinicDropDown(),
                    _buildExpertiseDropDown(),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.height * .02),
                child: _submitBtn(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submitBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
      child: RoundedLoadingButton(
          height: Get.height * .055,
          width: Get.width,
          successColor: Color(0xff077F7F),
          color: Colors.blue,
          child: AutoSizeText(
            "ثبت",
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          controller: btnController2,
          animateOnTap: true,
          resetAfterDuration: true,
          resetDuration: Duration(seconds: 3),
          onPressed: () {}),
    );
  }

  _buildClinicDropDown() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * .02,
        ),
        AutoSizeText(
          "کلینیک مورد نظر را انتخاب کنید",
          maxFontSize: 24,
          minFontSize: 6,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * .1, vertical: Get.height * .02),
          child: Container(
            height: Get.height * .05,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Obx(
              () => DropdownButton(
                hint: Center(
                  child: dropDownValue3.value == null
                      ? Text('انتخاب کنید')
                      : Center(
                          child: Text(
                            dropDownValue3.value,
                            style: TextStyle(color: ColorsHelper.mainColor),
                          ),
                        ),
                ),
                isExpanded: true,
                iconSize: 30.0,
                underline: Container(),
                style: TextStyle(color: Colors.blue),
                items: clinicFilterList.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val.name.toString(),
                      child: Center(child: Text(val.name)),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setSelected3(val);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildExpertiseDropDown() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * .02,
        ),
        AutoSizeText(
          "خدمت مورد نظر را انتخاب کنید",
          maxFontSize: 24,
          minFontSize: 6,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 14,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Get.width * .1, vertical: Get.height * .02),
          child: Container(
            height: Get.height * .05,
            width: Get.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Obx(
              () => DropdownButton(
                hint: Center(
                  child: dropDownValue4.value == null
                      ? Text('انتخاب کنید')
                      : Center(
                          child: Text(
                            dropDownValue4.value,
                            style: TextStyle(color: ColorsHelper.mainColor),
                          ),
                        ),
                ),
                isExpanded: true,
                iconSize: 30.0,
                underline: Container(),
                style: TextStyle(color: Colors.blue),
                items: exertiseListData.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val.title.toString(),
                      child: Center(child: Text(val.title)),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  setSelected3(val);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void onInit() {
    dataFilterList();
    exertiseList();
    super.onInit();
  }
}
