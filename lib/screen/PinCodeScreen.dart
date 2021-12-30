import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/ProfileController.dart';
import 'package:dentino/controllers/RegisterController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class PinCodeScreen extends StatelessWidget {
  String mobile;

  PinCodeScreen(this.mobile);

  final formKey = GlobalKey<FormState>();

  final verifyController = Get.put(VerifyController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
                child: Padding(
                  padding: MediaQuery.of(Get.context).viewInsets,
                  child: Column(
              children: [
                  _buildBody(),
              ],
            ),
                )),
          ),
        ],
      ),
    );
  }

  _buildBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            RotatedBox(
                quarterTurns: 10,
                child: Image.asset(
                  "assets/images/wave(1).png",
                )),
            AutoSizeText(
              "کد فعالسازی",
              maxLines: 1,
              maxFontSize: 24,
              minFontSize: 10,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            Lottie.asset("assets/anim/pinCode.json", height: Get.height * .4),
            AutoSizeText(
              "کد پیامک شده را وارد کنید",
              maxLines: 1,
              maxFontSize: 22,
              minFontSize: 10,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black38, fontSize: 16),
            ),
            SizedBox(
              height: Get.height * .03,
            ),
            _buildPinPut(),
            _buildTimer(),
            Spacer(),
            _submitBtn(),
            SizedBox(
              height: Get.height * .01,
            ),
          ],
        ),
      ),
    );
  }

  _buildPinPut() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .2),
        child: PinCodeTextField(
            appContext: Get.context,
            obscureText: true,
            enabled: true,
            pastedTextStyle: TextStyle(
              color: Colors.green.shade600,
              fontWeight: FontWeight.bold,
            ),
            length: 4,
            animationType: AnimationType.fade,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(5),
              fieldHeight: 60,
              fieldWidth: 50,
              activeFillColor: Colors.green,
              activeColor: Colors.green,
              disabledColor: Colors.green,
              errorBorderColor: Colors.red,
              inactiveColor: ColorsHelper.mainColor,
            ),
            cursorColor: Colors.black,
            animationDuration: Duration(milliseconds: 300),
            textStyle: TextStyle(fontSize: 20, height: 1.6),
            backgroundColor: Colors.white,
// errorAnimationController: errorController,
            controller: verifyController.textEditingController,
            keyboardType: TextInputType.number,
            onCompleted: (v) {
              print("Completed");
            },
            onChanged: (value) {
              print(value);
              if(value.length == 4){
                if (formKey.currentState.validate()) {
                  print(mobile);
                  verifyController.verifyCode(
                      code: verifyController.textEditingController.text,
                      mobile: mobile);
                  verifyController.btnController2.reset();
                } else {
                  verifyController.btnController2.error();
                  Get.snackbar("", "ورود با خطا مواجه شد",
                      icon: Icon(Icons.error, color: Colors.red),
                      snackPosition: SnackPosition.TOP,
                      colorText: Colors.black,
                      borderWidth: 0.5,
                      backgroundColor: Colors.red.shade50,
                      borderColor: Colors.red,
                      borderRadius: 15);
                }
                formKey.currentState.save();
                EasyLoading.show(
                  indicator: CircularProgressIndicator(),
                  dismissOnTap: true,
                );
              }
            },
            validator: (value) {
              if (value.isEmpty) {
                return "!کد ارسال شده را وارد کنید";
              }
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
//if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
//but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            }));
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
          controller: verifyController.btnController2,
          animateOnTap: true,
          resetAfterDuration: true,
          resetDuration: Duration(seconds: 2),
          onPressed: () {
            if (formKey.currentState.validate()) {
              print(mobile);
              verifyController.verifyCode(
                  code: verifyController.textEditingController.text,
                  mobile: mobile);
              verifyController.btnController2.reset();
            } else {
              verifyController.btnController2.error();
              Get.snackbar("", "ورود با خطا مواجه شد",
                  icon: Icon(Icons.error, color: Colors.red),
                  snackPosition: SnackPosition.TOP,
                  colorText: Colors.black,
                  borderWidth: 0.5,
                  backgroundColor: Colors.red.shade50,
                  borderColor: Colors.red,
                  borderRadius: 15);
            }
            formKey.currentState.save();
          }),
    );
  }

  _buildTimer() {
    return Obx(
      () => Container(
        height: Get.height * .1,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: Get.width * .25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: Get.height * .03,
            ),
            AutoSizeText(
              "00:${verifyController.start.value}",
              maxFontSize: 24,
              minFontSize: 12,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black38,
                fontSize: 18,
              ),
            ),
            (verifyController.start.value == 0)
                ? GestureDetector(
                    onTap: () {
// ViewHelper.showSuccessDialog(
//     Get.context, "کد جدید با موفقیت ارسال شد");
                    },
                    child: GestureDetector(
                      onTap: () {
                        RegisterController().register(mobile: mobile);
                      },
                      child: AutoSizeText(
                        "ارسال مجدد",
                        maxFontSize: 20,
                        minFontSize: 8,
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.purple,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                : Text(""),
          ],
        ),
      ),
    );
  }
}
