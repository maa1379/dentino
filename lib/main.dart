import 'package:dentino/screen/SplashScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  );
  runApp(
    Phoenix(
      child: MediaQuery(
        data: MediaQueryData(),
        child: GetMaterialApp(
          // defaultTransition: Transition.fade,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'iran',
          ),
          builder: EasyLoading.init(),
          // home: HomeScreen(),
          home: SplashScreen(),
        ),
      ),
    ),
  );
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.spinningCircle
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..userInteractions = false
    ..dismissOnTap = false
    ..indicatorSize = 100.0
    ..fontSize = 18.0
    ..progressColor = Colors.red
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.blue
    ..textColor = Colors.white
    // ..maskColor = Colors.blue
    ..maskType = EasyLoadingMaskType.black
    ..userInteractions = true
    ..dismissOnTap = true;
}
