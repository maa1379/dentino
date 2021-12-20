import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/ReservationController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:snapping_sheet/snapping_sheet.dart';

import 'DoctorProfile.dart';

class ReserveScreen extends StatelessWidget {
  Size size;
  String url = "https://dentino.app";
  final doctorController = Get.put(DoctorController());

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "لیست پزشکان",
          maxFontSize: 24,
          minFontSize: 6,
          maxLines: 1,
          style: TextStyle(
            color: ColorsHelper.mainColor,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Obx(
      () {
        if (!doctorController.loading.value) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: Get.height * .08,
              width: Get.width * .15,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return (doctorController.doctorListData.length == 0)
              ? Stack(
                  children: [
                    Center(
                      child: AutoSizeText(
                        "هیچ پزشکی برای این خدمت ثبت نشده است",
                        maxFontSize: 24,
                        minFontSize: 6,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    _buildFilterSheet(),
                  ],
                )
              : Container(
                  height: size.height,
                  width: size.width,
                  margin: EdgeInsets.only(top: size.height * .015),
                  child: Stack(
                    children: [
                      _buildDoctorList(),
                      _buildFilterSheet(),
                    ],
                  ),
                );
        }
      },
    );
  }

  _buildDoctorList() {
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * .1),
      child: ListView.builder(
        itemBuilder: _buildDoctorListItem,
        itemCount: doctorController.doctorListData.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  _buildFilterSheet() {
    return SnappingSheet(
      lockOverflowDrag: true,
      snappingPositions: [
        SnappingPosition.factor(
          positionFactor: 0.0,
          snappingCurve: Curves.easeOutExpo,
          snappingDuration: Duration(seconds: 1),
          grabbingContentOffset: GrabbingContentOffset.top,
        ),
// SnappingPosition.factor(
//   snappingCurve: Curves.elasticOut,
//   snappingDuration: Duration(milliseconds: 1750),
//   positionFactor: 0.5,
// ),
        SnappingPosition.factor(
          grabbingContentOffset: GrabbingContentOffset.bottom,
          snappingCurve: Curves.easeOutExpo,
          snappingDuration: Duration(seconds: 1),
          positionFactor: 0.9,
        ),
      ],
      grabbingHeight: size.height * .08,
      sheetAbove: null,
      grabbing: _buildGrabbingWidget(),
      controller: doctorController.snappingSheetController,
      sheetBelow: SnappingSheetContent(
        draggable: true,
        child: _buildFilterScreen(),
      ),
    );
  }

  _buildGrabbingWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [
          BoxShadow(blurRadius: 25, color: Colors.black.withOpacity(0.2)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            width: size.width * .25,
            height: size.height * .008,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          AutoSizeText(
            "فیلتر",
            maxFontSize: 24,
            minFontSize: 6,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.teal,
              fontSize: 18,
            ),
          ),
          Container(
            color: Colors.grey[200],
            height: 2,
            margin: EdgeInsets.all(15).copyWith(top: 0, bottom: 0),
          ),
        ],
      ),
    );
  }

  Widget _buildDoctorListItem(BuildContext context, int index) {
    var item = doctorController.doctorListData[index];
    return Container(
      height: size.height * .15,
      width: size.width,
      padding: EdgeInsets.all(size.width * .02),
      margin: EdgeInsets.symmetric(
          horizontal: size.width * .05, vertical: size.height * .015),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 2,
            child: Column(
              children: [
                SizedBox(height: size.height * .01),
                GestureDetector(
                  onTap: () {
                    // DateDoctorModal(context);
                    doctorController.doctorDateList(id: item.id.toString());
                    EasyLoading.show(
                      indicator: CircularProgressIndicator(),
                      dismissOnTap: true,
                    );
                    // _showDateTimeModal();,arguments: {"doctorId":item.fullName}
                  },
                  child: Container(
                    height: size.height * .04,
                    width: size.width * .22,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 2,
                            blurRadius: 5),
                      ],
                    ),
                    child: Center(
                      child: AutoSizeText(
                        "رزرو نوبت",
                        maxFontSize: 24,
                        minFontSize: 6,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * .025,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => DoctorProfile(),
                        arguments: {"doctorProfile_id": item.id.toString()});
                  },
                  child: Container(
                    height: size.height * .04,
                    width: size.width * .22,
                    decoration: BoxDecoration(
                      color: ColorsHelper.mainColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 2,
                            blurRadius: 5),
                      ],
                    ),
                    child: Center(
                      child: AutoSizeText(
                        "پروفایل پزشک",
                        maxFontSize: 24,
                        minFontSize: 6,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 3,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: size.height * .02,
                        right: size.height * .02,
                        left: 15),
                    child: AutoSizeText(
                      item.fullName,
                      maxFontSize: 24,
                      minFontSize: 6,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: size.height * .015,
                        right: size.height * .02,
                        left: 15),
                    child: AutoSizeText(
                      "متخصص جراحی فک",
                      maxFontSize: 24,
                      minFontSize: 6,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: size.height * .015,
                        right: size.height * .02,
                        left: 15),
                    child: AutoSizeText(
                      "کلینیک ${item.clinicName}",
                      maxFontSize: 24,
                      minFontSize: 6,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 2,
            child: Padding(
              padding: EdgeInsets.only(right: size.width * .02),
              child: Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  radius: size.width * .1,
                  backgroundImage: NetworkImage(url + item.profileUrl),
                  backgroundColor: ColorsHelper.mainColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildFilterScreen() {
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .05,
          ),
          _buildClinicDropDown(),
          _buildInsuranceListDropDown(),
          SizedBox(
            height: size.height * .05,
          ),
          Spacer(),
          _submitFilterBtn(),
          SizedBox(
            height: size.height * .05,
          ),
        ],
      ),
    );
  }

  _buildClinicDropDown() {
    return Column(
      children: [
        SizedBox(
          height: size.height * .02,
        ),
        AutoSizeText(
          ":کلینیک خود را انتخاب کنید",
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
              horizontal: size.width * .1, vertical: size.height * .02),
          child: Container(
              height: size.height * .05,
              width: size.width,
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
                    child: doctorController.dropDownValue2.value == null
                        ? Text('Dropdown')
                        : Center(
                            child: Text(
                              doctorController.dropDownValue2.value,
                              style: TextStyle(color: ColorsHelper.mainColor),
                            ),
                          ),
                  ),
                  isExpanded: true,
                  iconSize: 30.0,
                  underline: Container(),
                  style: TextStyle(color: Colors.blue),
                  items: doctorController.clinicFilterList.map(
                    (val) {
                      return DropdownMenuItem<String>(
                        value: val.id.toString(),
                        child: Center(child: Text(val.name)),
                      );
                    },
                  ).toList(),
                  onChanged: (val) {
                    doctorController.setSelected2(val);
                  },
                ),
              )),
        ),
      ],
    );
  }

  _submitFilterBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .05),
      child: RoundedLoadingButton(
        height: size.height * .055,
        width: size.width,
        successColor: Color(0xff077F7F),
        color: Colors.blue,
        child: AutoSizeText(
          "فیلتر کن",
          maxLines: 1,
          maxFontSize: 22,
          minFontSize: 10,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        controller: doctorController.btnController2,
        animateOnTap: true,
        onPressed: () {
          doctorController.doctorFilter();
          doctorController.doctorListData.clear();
          doctorController.btnController2.reset();
          doctorController.snappingSheetController
              .setSnappingSheetPosition(Get.height * .04);
        },
      ),
    );
  }

  _buildInsuranceListDropDown() {
    return Column(
      children: [
        SizedBox(
          height: size.height * .02,
        ),
        AutoSizeText(
          ":بیمه خود را انتخاب کنید",
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
              horizontal: size.width * .1, vertical: size.height * .02),
          child: Container(
            height: size.height * .05,
            width: size.width,
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
                  child: doctorController.dropDownValue1.value == null
                      ? Text('Dropdown')
                      : Center(
                          child: Text(
                            doctorController.dropDownValue1.value,
                            style: TextStyle(color: ColorsHelper.mainColor),
                          ),
                        ),
                ),
                isExpanded: true,
                iconSize: 30.0,
                underline: Container(),
                style: TextStyle(color: Colors.blue),
                items: doctorController.insuranceFilterList.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val.id.toString(),
                      child: Center(child: Text(val.name)),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  doctorController.setSelected1(val);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
