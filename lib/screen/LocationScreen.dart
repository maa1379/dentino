import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/ReservationController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/screen/ReserveScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LocationScreen extends StatelessWidget {
  String expertise_id;

  LocationScreen({this.expertise_id});

  CityController cityController = Get.put(CityController());

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.white,
          title: AutoSizeText(
            "موقعیت",
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
        body: Container(
          height: Get.height,
          width: Get.height,
          child: Obx(() {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * .05,
                ),
                _buildProvinceDropDown(),
                cityController.loadingCity.value == true
                    ? _buildCityDropDown()
                    : Container(),
                cityController.loadingZone.value == true
                    ? _buildZoneDropDown()
                    : Container(),
                Spacer(),
                submitBtn(),
                SizedBox(
                  height: Get.height * .05,
                ),
              ],
            );
          }),
        ));
  }

  _buildProvinceDropDown() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * .02,
        ),
        AutoSizeText(
          "استان خود را انتخاب کنید",
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
                  child: cityController.dropDownValue3.value == null
                      ? Text('انتخاب کنید')
                      : Center(
                          child: Text(
                            cityController.dropDownValue3.value,
                            style: TextStyle(color: ColorsHelper.mainColor),
                          ),
                        ),
                ),
                isExpanded: true,
                iconSize: 30.0,
                underline: Container(),
                style: TextStyle(color: Colors.blue),
                items: cityController.ProvinceDataList.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val.name.toString(),
                      child: Center(child: Text(val.name)),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  cityController.setSelected3(val);
                  cityController.City(province_id: val.toString());
                  EasyLoading.show(
                      indicator: CircularProgressIndicator(),
                      dismissOnTap: false);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildCityDropDown() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * .02,
        ),
        AutoSizeText(
          "شهر خود را انتخاب کنید",
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
                  child: cityController.dropDownValue4.value == null
                      ? Text('')
                      : Center(
                          child: Text(
                            cityController.dropDownValue4.value,
                            style: TextStyle(color: ColorsHelper.mainColor),
                          ),
                        ),
                ),
                isExpanded: true,
                iconSize: 30.0,
                underline: Container(),
                style: TextStyle(color: Colors.blue),
                items: cityController.CityDataList.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val.name.toString(),
                      child: Center(child: Text(val.name)),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  cityController.setSelected4(val);
                  cityController.Zone(city_id: val);
                  EasyLoading.show(
                      indicator: CircularProgressIndicator(),
                      dismissOnTap: false);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  _buildZoneDropDown() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * .02,
        ),
        AutoSizeText(
          "منطقه خود را انتخاب کنید",
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
                  child: cityController.dropDownValue5.value == null
                      ? Text('انتخاب کنید')
                      : Center(
                          child: Text(
                            cityController.dropDownValue5.value,
                            style: TextStyle(color: ColorsHelper.mainColor),
                          ),
                        ),
                ),
                isExpanded: true,
                iconSize: 30.0,
                underline: Container(),
                style: TextStyle(color: Colors.blue),
                items: cityController.zoneDataList.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val.name.toString(),
                      child: Center(child: Text(val.name)),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  cityController.setSelected5(val);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  submitBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
      child: RoundedLoadingButton(
        height: Get.height * .055,
        width: Get.width,
        successColor: Color(0xff077F7F),
        color: Colors.blue,
        child: AutoSizeText(
          "ادامه",
          maxLines: 1,
          maxFontSize: 22,
          minFontSize: 10,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        controller: _btnController1,
        animateOnTap: true,
        onPressed: () {
          Get.to(
            () => ReserveScreen(),
            arguments: {
              "expertise_id2": expertise_id,
              "city_id_dropdown": (cityController.dropDownValue4.value == "انتخاب کنید")
                  ? ""
                  : cityController.dropDownValue4.value.toString(),
              "zone_id": (cityController.dropDownValue5.value == "انتخاب کنید")
                  ? ""
                  : cityController.dropDownValue5.value.toString(),
            },
          );
          _btnController1.reset();
        },
      ),
    );
  }
}
