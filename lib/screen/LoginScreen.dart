import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/RegisterController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/widgetHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Size size;

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();
  final registerController = Get.put(RegisterController());
  bool isChecked = false;
  final _formKey = GlobalKey<FormState>();

  final RoundedLoadingButtonController _btnController2 =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: MediaQuery.of(context).viewInsets,
                  child: Column(
                    children: [
                      RotatedBox(
                          quarterTurns: 10,
                          child: Image.asset(
                            "assets/images/wave(1).png",
                          )),
                      AutoSizeText(
                        "ورود / ثبت نام",
                        maxLines: 1,
                        maxFontSize: 24,
                        minFontSize: 10,
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      Lottie.asset("assets/anim/login.json", height: size.height * .4),
                      _buildBody(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildBody() {
    return Container(
      height: Get.height * .38,
      width: Get.width,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // SizedBox(height: size.height * .08,),
            AutoSizeText(
              "شماره تلفن خود را وارد کنید",
              maxLines: 1,
              maxFontSize: 22,
              minFontSize: 10,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black38, fontSize: 16),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            _buildPhoneField(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AutoSizeText(
                  "مطالعه کنید",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 6,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: ColorsHelper.mainColor, fontSize: 12),
                ),
                AutoSizeText(
                  "ثبت نام شما به منظور قبول قوانین و مقررات است",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 6,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black38, fontSize: 12),
                ),
                Checkbox(
                  activeColor: ColorsHelper.mainColor,
                  value: this.isChecked,
                  onChanged: (bool value) {
                    setState(() {
                      this.isChecked = value;
                    });
                  },
                ),
              ],
            ),
            _submitBtn(),
            SizedBox(
              height: size.height * .04,
            ),
          ],
        ),
      ),
    );
  }

  _buildPhoneField() {
    return WidgetHelper.textField(
      width: size.width,
      height: size.height * .1,
      color: Colors.transparent,
      fontSize: 12,
      hintText: "09371519103",
      enabled: true,
      controller: registerController.mobileController,
      // errorText: "شماره موبایل خود را وارد کنید!",
      size: size,
      maxLine: 1,
      function: (value) {
        if (value == "") {
          return "!شماره موبایل خود را وارد کنید";
        }else if(value == 11){
          return "!شماره موبایل را درست وارد کنید";
        }
      },
      onChange: (value) {
        setState(() {
          WidgetHelper.onChange(value, registerController.mobileController);
        });
        if(value.length == 11){
          FocusScope.of(context).unfocus();
          if (_formKey.currentState.validate()) {
            registerController.register(mobile: registerController.mobileController.text);
            registerController.btnController1.reset();
          } else {
            registerController.btnController1.error();
            Get.snackbar("", "ارسال کد با خطا مواجه شد",
                icon: Icon(Icons.error, color: Colors.red),
                snackPosition: SnackPosition.TOP,
                colorText: Colors.black,
                borderWidth: 0.5,
                backgroundColor: Colors.red.shade50,
                borderColor: Colors.red,
                borderRadius: 15);
          }
          _formKey.currentState.save();
          EasyLoading.show(
            indicator: CircularProgressIndicator(),
            dismissOnTap: true,
          );
        }
      },
      maxLength: 11,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.number,
      margin: EdgeInsets.symmetric(horizontal: size.width * .15),
    );
  }

  _submitBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .05),
      child: RoundedLoadingButton(
        height: size.height * .055,
        width: size.width,
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
        controller: registerController.btnController1,
        animateOnTap: true,
        resetAfterDuration: true,
        resetDuration: Duration(seconds: 2),
        onPressed: () {
          if (_formKey.currentState.validate()) {
            registerController.register(mobile: registerController.mobileController.text);
            registerController.btnController1.reset();
          } else {
            registerController.btnController1.error();
            Get.snackbar("", "ارسال کد با خطا مواجه شد",
                icon: Icon(Icons.error, color: Colors.red),
                snackPosition: SnackPosition.TOP,
                colorText: Colors.black,
                borderWidth: 0.5,
                backgroundColor: Colors.red.shade50,
                borderColor: Colors.red,
                borderRadius: 15);
          }
          _formKey.currentState.save();
        },
      ),
    );
  }
}
