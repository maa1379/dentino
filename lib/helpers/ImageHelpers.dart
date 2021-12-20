import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ImageHelpers {
  static LottieBuilder creditSuccess = Lottie.asset(
    'assets/json/credit-success.json',
  );
  static LottieBuilder creditFail = Lottie.asset(
    'assets/json/credit-fail.json',
  );

  static LottieBuilder update = Lottie.asset(
    'assets/json/update.json',
  );

  static LottieBuilder android =
      Lottie.asset('assets/json/android.json', fit: BoxFit.cover);
  static LottieBuilder download = Lottie.asset(
    'assets/json/download.json',
  );
}
