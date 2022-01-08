import 'dart:async';
import 'dart:convert';

import 'package:dentino/bloc/getProfileBloc.dart';
import 'package:dentino/controllers/MainController.dart';
import 'package:dentino/helpers/NavHelper.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/GetProfileModel.dart';
import 'package:dentino/screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:uni_links/uni_links.dart';

import 'IntroScreen.dart';
import 'LoginScreen.dart';
import 'ProfileScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Size size;

  final slider = Get.put(SliderController());

  Retoken() async {
    if (await PrefHelper.getToken() == null) {
      Get.off(LoginScreen());
    } else {
      RequestHelper.Token(
              password: "1234", username: await PrefHelper.getMobile())
          .then((value) async {
        if (value.statusCode == 200) {
          PrefHelper.removeToken();
          PrefHelper.setToken(value.data2['access']);
          getProfile();
        } else {
          Get.off(LoginScreen());
        }
      });
    }
  }



  @override
  void initState() {
    startTimer();
    super.initState();
  }

  getProfile() async {
    RequestHelper.getProfile(token: await PrefHelper.getToken())
        .then((value) async {
      if (value.isDone) {
        getProfileBlocInstance.getProfile(GetProfileModel.fromJson(value.data));
      } else {
        Get.off(IntroScreen());
        print("not ok");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white
        ),
        child: Image.asset("assets/anim/GetUserProjectVideo (2) (2).gif",fit: BoxFit.cover,repeat: ImageRepeat.noRepeat,),
      ),
    );
  }

  void startTimer() async {
    Future.delayed(Duration(seconds: 10)).then((value)async{
      Retoken();
      if (await PrefHelper.getToken() != null) {
      NavHelper.pushR(context, HomeScreen());
      } else {
      NavHelper.pushR(context, IntroScreen());
      // Get.off(IntroScreen());
      }
    });
  }
}
