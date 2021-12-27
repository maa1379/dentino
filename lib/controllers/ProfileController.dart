import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/bloc/getProfileBloc.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/helpers/widgetHelper.dart';
import 'package:dentino/screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'RegisterController.dart';

class ProfileController extends GetxController {


  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  final _formKey = GlobalKey<FormState>();

  void _doSomething(RoundedLoadingButtonController controller) async {
    if (_formKey.currentState.validate()) {
      updateProfile(
          family: familyController.text,
          name: nameController.text,
          national_code: codeController.text);
      Get.off(HomeScreen());
    }
    _formKey.currentState.save();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController familyController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  updateProfile({String name, String family, String national_code}) async {
    RequestHelper.updateProfile(
            national_code: national_code,
            name: name,
            family: family,
            token: await PrefHelper.getToken())
        .then((value) {
      print(value.data);
      if (value.isDone) {
        print("ok");
        ViewHelper.showSuccessDialog(
            Get.context, "پروفایل شما با موفقیت ثبت شد");
        VerifyController().getProfile();
        EasyLoading.dismiss();
      } else {
        print("faild");
        ViewHelper.showErrorDialog(
            Get.context, "پروفایل شما با موفقیت ثبت نشد");
      }
    });
  }

  showRegisterFormModal() {
    return showCupertinoModalBottomSheet(
      context: Get.context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: false,
      isDismissible: true,
      builder: (context) => Container(
        width: Get.width,
        height: Get.height,
        child: Container(
          height: Get.height * .42,
          padding: MediaQuery.of(context).viewInsets,
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
                    "تکمیل اطلاعات",
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
                alignment: Alignment.center,
                child: Container(
                  height: Get.height * .5,
                  width: Get.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * .05, vertical: Get.height * .02),
                  child: _buildBody(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildBody() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // _buildAvatar(),
          SizedBox(
            height: Get.height * .04,
          ),
          _buildNameField(),
          _buildLNameField(),
          _buildNationalCodeField(),
          // _buildBrDayField(),
          Spacer(),
          _submitBtn(),
        ],
      ),
    );
  }

  _buildNameField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .09,
      color: Colors.transparent,
      fontSize: 12,
      controller: nameController,
      hintText: "نام خود را وارد کنید",
      enabled: true,
      text: "نام",
      onChange: (value) {
        // WidgetHelper.onChange(value, mobileController);
      },
      // controller: mobileController,
      // errorText: "شماره موبایل خود را وارد کنید!",
      function: (value) {
        if (value == "") {
          return "نام خود را وارد کنید";
        }
      },
      size: Get.size,
      maxLine: 1,
      maxLength: 120,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.text,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
    );
  }

  _buildLNameField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .09,
      color: Colors.transparent,
      controller: familyController,
      fontSize: 12,
      hintText: "نام خانوادگی خود را وارد کنید",
      enabled: true,
      text: "نام خانوادگی",
      function: (value) {
        if (value == "") {
          return "نام خانوادگی خود را وارد کنید";
        }
      },
      size: Get.size,
      maxLine: 1,
      maxLength: 120,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.text,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
    );
  }

  _buildNationalCodeField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .09,
      color: Colors.transparent,
      fontSize: 12,
      controller: codeController,
      hintText: "کد ملی خود را وارد کنید",
      enabled: true,
      text: "کد ملی",
      function: (value) {
        if (value == "") {
          return "کد ملی خود را وارد کنید";
        }
      },
      size: Get.size,
      maxLine: 1,
      maxLength: 15,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.number,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
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
          "ارسال اطلاعات",
          maxLines: 1,
          maxFontSize: 22,
          minFontSize: 10,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        controller: _btnController1,
        resetDuration: Duration(seconds: 3),
        animateOnTap: true,
        onPressed: () => _doSomething(_btnController1),
      ),
    );
  }
}
