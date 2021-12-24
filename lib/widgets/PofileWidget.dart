import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/bloc/getProfileBloc.dart';
import 'package:dentino/controllers/ProfileController.dart';
import 'package:dentino/helpers/AlertHelper.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/widgetHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ProfileWidget extends StatefulWidget {
  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {





  @override
  void initState() {
    profileController.nameController.text = getProfileBlocInstance.profile.name;
    profileController.familyController.text = getProfileBlocInstance.profile.family;
    profileController.codeController.text = getProfileBlocInstance.profile.nationalCode.toString();
    super.initState();
  }


  // PickedFile _imageFile;



  // final ImagePicker _picker = ImagePicker();

  final _formKey = GlobalKey<FormState>();

  Size size;

  final profileController = Get.put(ProfileController());

  // void takePhoto(ImageSource source) async {
  //   final pickedFile = await _picker.getImage(source: source);
  //   // setState(() {
  //   //   _imageFile = pickedFile;
  //   // });
  // }

  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  bool isChecked = false;

  void _doSomething(RoundedLoadingButtonController controller) async {
    if(_formKey.currentState.validate()){
      profileController.updateProfile(
          name: profileController.nameController.text,
          family: profileController.familyController.text,
          birthday: "1379-12-04",
          national_code: profileController.codeController.text);
    }else{
      print("field");
    }

    controller.reset();
  }


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return SafeArea(
      child: Container(
        height: size.height,
        width: size.width,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: size.height * .18,
              ),
              // _buildAvatar(),
              SizedBox(
                height: size.height * .04,
              ),
              _buildNameField(),
              _buildLNameField(),
              _buildNationalCodeField(),
              // _buildBrDayField(),
              SizedBox(
                height: size.height * .18,
              ),
              _submitBtn(),
            ],
          ),
        ),
      ),
    );
  }

  // _buildAvatar() {
  //   return GestureDetector(
  //       onTap: () {
  //         AlertHelpers.noDesignAlertDialog(
  //             size: size,
  //             context: Get.context,
  //             camFunc: () {
  //               takePhoto(ImageSource.camera);
  //             },
  //             galleryFunc: () {
  //               takePhoto(ImageSource.gallery);
  //             });
  //       },
  //       child: CircleAvatar(
  //         radius: size.width * .18,
  //         child: _imageFile == null
  //             ? Text(
  //                 "+",
  //                 style: TextStyle(
  //                   fontSize: 40,
  //                   color: Colors.white,
  //                 ),
  //               )
  //             : null,
  //         backgroundColor: ColorsHelper.mainColor,
  //         backgroundImage:
  //             _imageFile == null ? null : FileImage(File(_imageFile.path)),
  //       ));
  // }

  _buildNameField() {
    return WidgetHelper.profileTextField(
      width: size.width,
      height: size.height * .09,
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
      size: size,
      maxLine: 1,
      maxLength: 120,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.text,
      margin: EdgeInsets.symmetric(horizontal: size.width * .1),
    );
  }

  _buildLNameField() {
    return WidgetHelper.profileTextField(
      width: size.width,
      height: size.height * .09,
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
      size: size,
      maxLine: 1,
      maxLength: 120,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.text,
      margin: EdgeInsets.symmetric(horizontal: size.width * .1),
    );
  }

  _buildNationalCodeField() {
    return WidgetHelper.profileTextField(
      width: size.width,
      height: size.height * .09,
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
      size: size,
      maxLine: 1,
      maxLength: 15,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.number,
      margin: EdgeInsets.symmetric(horizontal: size.width * .1),
    );
  }

  _buildBrDayField() {
    return WidgetHelper.profileTextField(
      width: size.width,
      height: size.height * .09,
      color: Colors.transparent,
      controller: profileController.bDayController,
      fontSize: 12,
      hintText: "تاریخ تولد خود را وارد کنید",
      enabled: true,
      text: "تاریخ تولد",
      function: (value) {
        if (value == "") {
          return "تاریخ تولد خود را وارد کنید";
        }
      },
      size: size,
      maxLine: 1,
      maxLength: 20,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.number,
      margin: EdgeInsets.symmetric(horizontal: size.width * .1),
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
