import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/bloc/getProfileBloc.dart';
import 'package:dentino/controllers/MainController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/NavHelper.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/GetProfileModel.dart';
import 'package:dentino/plugin/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:dentino/screen/HomeScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ClinicPanelScreen/LoginClinicScreen.dart';
import 'IntroScreen.dart';
import 'LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Size size;

  // Retoken() async {
  //   if (await PrefHelper.getToken() == null) {
  //     Get.off(LoginScreen());
  //   } else {
  //     RequestHelper.Token(
  //         password: "1234", username: await PrefHelper.getMobile())
  //         .then((value) async {
  //       if (value.statusCode == 200) {
  //         PrefHelper.removeToken();
  //         PrefHelper.setToken(value.data2['access']);
  //         getProfile();
  //       } else {
  //         Get.off(LoginScreen());
  //       }
  //     });
  //   }
  // }
  //
  //
  // getProfile() async {
  //   RequestHelper.getProfile(token: await PrefHelper.getToken())
  //       .then((value) async {
  //     if (value.isDone) {
  //       getProfileBlocInstance.getProfile(GetProfileModel.fromJson(value.data));
  //       // startTimer();
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
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("assets/anim/logo.gif"),
              fit: BoxFit.cover,
            )),
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: Get.height * .025),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Get.to(UserPanel());
                      },
                      child: NeumorphicContainer(
                        alignment: Alignment.center,
                        width: size.width * .3,
                        height: size.height * .06,
                        decoration: MyNeumorphicDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff181D31),
                        ),
                        curveType: CurveType.flat,
                        bevel: 8,
                        child: AutoSizeText(
                          "کاربر",
                          maxLines: 1,
                          maxFontSize: 22,
                          minFontSize: 10,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(LoginClinicScreen());
                      },
                      child: NeumorphicContainer(
                        alignment: Alignment.center,
                        width: size.width * .3,
                        height: size.height * .06,
                        decoration: MyNeumorphicDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xff181D31),
                        ),
                        curveType: CurveType.flat,
                        bevel: 8,
                        child: AutoSizeText(
                          "مرکز درمانی",
                          maxLines: 1,
                          maxFontSize: 22,
                          minFontSize: 10,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class UserPanel extends StatefulWidget {
//   @override
//   State<UserPanel> createState() => _UserPanelState();
// }
//
// class _UserPanelState extends State<UserPanel> {
//   Size size;
//
//   final slider = Get.put(SliderController());
//
//   Retoken() async {
//     if (await PrefHelper.getToken() == null) {
//       Get.off(LoginScreen());
//     } else {
//       RequestHelper.Token(
//               password: "1234", username: await PrefHelper.getMobile())
//           .then((value) async {
//         if (value.statusCode == 200) {
//           PrefHelper.removeToken();
//           PrefHelper.setToken(value.data2['access']);
//           // getProfile();
//         } else {
//           Get.off(LoginScreen());
//         }
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     Retoken();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: size.height,
//       width: size.width,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         image: DecorationImage(
//           image: AssetImage("assets/anim/logo.gif"),
//           fit: BoxFit.cover,
//         ),
//       ),
//     );
//   }
//
//   void startTimer() async {
//     Future.delayed(Duration(seconds: 5)).then(
//       (value) async {
//         if (await PrefHelper.getToken() != null) {
//           NavHelper.pushR(context, HomeScreen());
//         } else {
//           NavHelper.pushR(context, IntroScreen());
//           // Get.off(IntroScreen());
//         }
//       },
//     );
//   }
// }
