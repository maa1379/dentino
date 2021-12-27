import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/bloc/getProfileBloc.dart';
import 'package:dentino/controllers/ProfileController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/widgetHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProfileScreen extends StatefulWidget {





  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileController profileController = Get.put(ProfileController());


  @override
  void initState() {
    profileController.nameController.text = getProfileBlocInstance.profile.name;
    profileController.familyController.text = getProfileBlocInstance.profile.family;
    profileController.codeController.text =
        getProfileBlocInstance.profile.nationalCode.toString();
    super.initState();
  }


  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  final _formKey = GlobalKey<FormState>();

  void _doSomething(RoundedLoadingButtonController controller) async {
    if (_formKey.currentState.validate()) {
      profileController.updateProfile(
          family: profileController.familyController.text,
          name: profileController.nameController.text,
          national_code: profileController.codeController.text);
    }
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      dismissOnTap: false,
    );
    _formKey.currentState.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "پروفایل من",
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
    return Container(
      height: Get.height,
      width: Get.width,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // _buildAvatar(),
            SizedBox(
              height: Get.height * .15,
            ),
            _buildNameField(),
            _buildLNameField(),
            _buildNationalCodeField(),
            // _buildBrDayField(),
            Spacer(),
            _submitBtn(),
            SizedBox(
              height: Get.height * .04,
            ),
          ],
        ),
      ),
    );
  }

  _buildNameField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .09,
      color: Colors.transparent,
      fontSize: 12,
      controller: profileController.nameController,
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
      controller: profileController.familyController,
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
      controller: profileController.codeController,
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
        resetDuration: Duration(seconds: 10),
        animateOnTap: true,
        onPressed: () => _doSomething(_btnController1),
      ),
    );
  }
}
