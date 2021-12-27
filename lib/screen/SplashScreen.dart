import 'package:dentino/bloc/getProfileBloc.dart';
import 'package:dentino/controllers/MainController.dart';
import 'package:dentino/helpers/NavHelper.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/GetProfileModel.dart';
import 'package:dentino/screen/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'IntroScreen.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Size size;

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
        } else {
          Get.off(LoginScreen());
        }
      });
    }
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  getDate() async {
    await Get.put(SliderController()).getSlider();
    startTimer();
  }

  getProfile() async {
    RequestHelper.getProfile(token: await PrefHelper.getToken())
        .then((value) async {
      if (value.isDone) {
        Retoken();
        getProfileBlocInstance.getProfile(GetProfileModel.fromJson(value.data));
        getDate();
      } else {
        Get.off(IntroScreen());
        getDate();
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
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff0FE9E9),
                Color(0xffFFFFFF),
              ]),
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.height * .15,
            ),
            Padding(
              padding: EdgeInsets.all(size.width * .15),
              child: Lottie.asset("assets/anim/dental.json"),
            ),
            Spacer(),
            Lottie.asset("assets/anim/lineLoading.json"),
          ],
        ),
      ),
    );
  }

  void startTimer() async {
    if (await PrefHelper.getToken() != null) {
      NavHelper.pushR(context, HomeScreen());
    } else {
      NavHelper.pushR(context, IntroScreen());
      // Get.off(IntroScreen());
    }
  }
}
