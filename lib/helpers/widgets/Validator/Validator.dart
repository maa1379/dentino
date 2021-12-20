import 'dart:async';

mixin Validators {

  var mobileValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (mobile, sink) {
        if (mobile.length == 11 && mobile.contains("09")) {
          sink.add(mobile);
        } else{
          sink.addError("شماره موبایل را به درستی وارد کنید!");
        }

      });

  var lNameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (lName, sink) {
        if (!lName.isEmpty) {
          sink.add(lName);
        } else {
          sink.addError("نام خانوادگی خود راوارد کنید!");
        }
      });

  var fNameValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (fName, sink) {
        if (!fName.isEmpty) {
          sink.add(fName);
        } else {
          sink.addError("نام خود راوارد کنید!");
        }
      });
}
