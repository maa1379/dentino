import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/ClinicController.dart';
import 'package:dentino/controllers/MainController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ComplimentCreateScreen extends StatelessWidget {
  ComplimentCreate complimentCreate = Get.put(ComplimentCreate());
  ClinicController clinicController = Get.put(ClinicController());

  TextEditingController answerTextEditingController = TextEditingController();

  final RoundedLoadingButtonController btnController2 =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "ثبت شکایت",
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
        width: Get.width,
        child: Obx(() {
          return SingleChildScrollView(
            child: Container(
              height: Get.height * .9,
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: Get.height * .1,
                  ),
                  _buildClinicListDropDown(),
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  (complimentCreate.loading.value == true)
                      ? _buildDoctorListDropDown()
                      : Container(),
                  SizedBox(
                    height: Get.height * .06,
                  ),
                  _messageTextField(),
                  Spacer(),
                  _submitBtn(),
                  SizedBox(
                    height: Get.height * .05,
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _messageTextField() {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: Get.height * .4,
          maxWidth: Get.width,
          minHeight: Get.height * .2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          textDirection: TextDirection.rtl,
          controller: answerTextEditingController,
          maxLength: 500,
          minLines: 1,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(.40)),
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: "متن شکایت خود را بنویسید",
            hintText: "متن شکایت",
            // contentPadding: EdgeInsets.all(Get.width * .03),
            labelStyle: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(.40),
            ),
            counter: Offstage(),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(.40)),
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(.40),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(.40)),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            hintStyle:
                TextStyle(fontSize: 12, color: Colors.grey.withOpacity(.20)),
            fillColor: Colors.white,
          ),
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
            "ورود",
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          controller: btnController2,
          animateOnTap: true,
          resetAfterDuration: true,
          resetDuration: Duration(seconds: 2),
          onPressed: () {
            complimentCreate.compliment(text: answerTextEditingController.text);
          }),
    );
  }

  _buildClinicListDropDown() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * .02,
        ),
        AutoSizeText(
          ":مرکز درمانی خود را انتخاب کنید",
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
                  child: complimentCreate.dropDownValueClinic.value == null
                      ? Text('انتخاب کنید')
                      : Center(
                          child: Text(
                            complimentCreate.dropDownValueClinic.value,
                            style: TextStyle(color: ColorsHelper.mainColor),
                          ),
                        ),
                ),
                isExpanded: true,
                iconSize: 30.0,
                underline: Container(),
                style: TextStyle(color: Colors.blue),
                items: clinicController.clinicList.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val.id.toString(),
                      child: Center(child: Text(val.name)),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  complimentCreate.setSelected1(val);
                  complimentCreate.DoctorList();
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

  _buildDoctorListDropDown() {
    return Column(
      children: [
        SizedBox(
          height: Get.height * .02,
        ),
        AutoSizeText(
          "پزشک خود را انتخاب کنید",
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
                  child: complimentCreate.dropDownValueDoctor.value == null
                      ? Text('انتخاب کنید')
                      : Center(
                          child: Text(
                            complimentCreate.dropDownValueDoctor.value,
                            style: TextStyle(color: ColorsHelper.mainColor),
                          ),
                        ),
                ),
                isExpanded: true,
                iconSize: 30.0,
                underline: Container(),
                style: TextStyle(color: Colors.blue),
                items: complimentCreate.doctorList.map(
                  (val) {
                    return DropdownMenuItem<String>(
                      value: val.id.toString(),
                      child: Center(
                        child: Text(val.name + " " + val.family),
                      ),
                    );
                  },
                ).toList(),
                onChanged: (val) {
                  complimentCreate.setSelected2(val);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
