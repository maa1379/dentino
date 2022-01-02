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

  // final slider = Get.put(SliderController());
  //
  // Retoken() async {
  //   if (await PrefHelper.getToken() == null) {
  //     Get.off(LoginScreen());
  //   } else {
  //     RequestHelper.Token(
  //             password: "1234", username: await PrefHelper.getMobile())
  //         .then((value) async {
  //       if (value.statusCode == 200) {
  //         PrefHelper.removeToken();
  //         PrefHelper.setToken(value.data2['access']);
  //         if (slider.loaded.value == true) {
  //           startTimer();
  //         }
  //       } else {
  //         Get.off(LoginScreen());
  //       }
  //     });
  //   }
  // }

  StreamSubscription _sub;

  Future<void> initUniLinks() async {
    _sub = uriLinkStream.listen((Uri uri) {
      print(_sub);

      final myMap = jsonDecode(uri.queryParameters['status']);
      print(myMap.runtimeType);
      if (myMap == "100") {
        print("ok");
        Get.to(ProfileScreen());
        ViewHelper.showSuccessDialog(Get.context, "پرداخت موفق بود");
      } else {
        Get.to(IntroScreen());
        print("no ok");
        ViewHelper.showSuccessDialog(Get.context, "پرداخت موفق نبود");
      }

    }, onError: (err) {
      print(err);
    });
  }

  @override
  void initState() {
    initUniLinks();
    // getProfile();
    super.initState();
  }

  // getProfile() async {
  //   RequestHelper.getProfile(token: await PrefHelper.getToken())
  //       .then((value) async {
  //     if (value.isDone) {
  //       getProfileBlocInstance.getProfile(GetProfileModel.fromJson(value.data));
  //       Retoken();
  //     } else {
  //       Get.off(IntroScreen());
  //       print("not ok");
  //     }
  //   });
  // }

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

  // void startTimer() async {
  //   if (await PrefHelper.getToken() != null) {
  //     NavHelper.pushR(context, HomeScreen());
  //   } else {
  //     NavHelper.pushR(context, IntroScreen());
  //     // Get.off(IntroScreen());
  //   }
  // }
}
