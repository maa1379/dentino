import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/widgetHelper.dart';
import 'package:dentino/plugin/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginClinicScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        color: ColorsHelper.colorBlack,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: AutoSizeText(
                  "پنل مدیرریت",
                  maxLines: 1,
                  maxFontSize: 28,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
              ),
              SizedBox(
                height: Get.height * .1,
              ),
              _mobileTextField(),
              SizedBox(
                height: Get.height * .02,
              ),
              _passwordTextField(),
              SizedBox(
                height: Get.height * .05,
              ),
              _endBtn(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mobileTextField() {
    return WidgetHelper.TextField1(
      text: "موبایل",
      width: Get.width,
      height: Get.height * .09,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .08),
      size: Get.size,
      enabled: true,
      fontSize: 16,
      // controller: mobileTextEditingController,
      maxLine: 1,
      keyBoardType: TextInputType.number,
      obscureText: false,
      maxLength: 11,
      // formKey: _formKey,
      function: (value) {
        if (value.isEmpty) {
          return "لطفا شماره موبایل خود را وارد کنید!";
        }
      },
    );
  }

  Widget _passwordTextField() {
    return WidgetHelper.TextField1(
      text: "رمز عبور",
      width: Get.width,
      height: Get.height * .09,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .08),
      size: Get.size,
      enabled: true,
      fontSize: 16,
      // controller: mobileTextEditingController,
      maxLine: 1,
      keyBoardType: TextInputType.number,
      obscureText: false,
      maxLength: 11,
      // formKey: _formKey,
      function: (value) {
        if (value.isEmpty) {
          return "لطفا رمز عبور خود را وارد کنید!";
        }
      },
    );
  }

  Widget _endBtn() {
    return NeumorphicContainer(
      alignment: Alignment.center,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .08),
      height: Get.height * .06,
      decoration: MyNeumorphicDecoration(
        borderRadius: BorderRadius.circular(30),
        color: ColorsHelper.colorBlack,
      ),
      curveType: CurveType.flat,
      bevel: 15,
      child: AutoSizeText(
        "ورود",
        maxLines: 1,
        maxFontSize: 22,
        minFontSize: 10,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
    );
  }
}
