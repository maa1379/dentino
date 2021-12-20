import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AlertHelpers {




  static UpdateProfileDialog({
    BuildContext context,
    Size size,
    Function func,
    Function func2,
  }) {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 50.0,
          content: Container(
            height: size.height * .27,
            width: size.width,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Lottie.asset("assets/anim/edit_profile.json",
                      repeat: false,
                      width: size.width * .3),
                ),
                SizedBox(height: size.height * .01,),
                AutoSizeText(
                  "پروفایل خود را تکمیل کنید!!!",
                  maxLines: 1,
                  maxFontSize: 22,
                  minFontSize: 10,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
                SizedBox(height: size.height * .015,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: (){
                          func();
                        },
                        child: Container(
                          height: size.height * .05,
                          width: size.width * .25,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],),
                          child: Center(
                            child: AutoSizeText(
                              "تکیمل پروفایل",
                              maxLines: 1,
                              maxFontSize: 22,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: GestureDetector(
                        onTap: (){
                          func2();
                        },
                        child: Container(
                          height: size.height * .05,
                          width: size.width * .25,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 5,
                                spreadRadius: 2,
                              ),
                            ],),
                          child: Center(
                            child: AutoSizeText(
                              "بعدا",
                              maxLines: 1,
                              maxFontSize: 22,
                              minFontSize: 10,
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  static noDesignAlertDialog(
      {BuildContext context,
        Size size,
        Function camFunc,
        Function galleryFunc}) {
    showDialog(
      context: context,
      builder: (_) => Directionality(
        textDirection: TextDirection.rtl,
        child: AlertDialog(
          contentPadding: EdgeInsets.zero,
          backgroundColor: Colors.transparent,
          elevation: 50.0,
          content: Container(
            height: size.height * .2,
            width: double.maxFinite,
            padding: EdgeInsets.all(10.0),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0)),
            child: Stack(
              children: [
                Container(
                  width: double.maxFinite,
                  height: size.height * .2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(size.width * .02),
                        child: Align(
                          alignment: Alignment.topRight,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Icon(
                                Icons.close,
                                color: Colors.black,
                              )),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height * .01),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: AutoSizeText(
                            "انتحاب کنید",
                            maxFontSize: 22,
                            minFontSize: 8,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.black54,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: size.height * .06,
                          width: size.width,
                          margin:
                          EdgeInsets.symmetric(horizontal: size.width * .1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  AutoSizeText(
                                    "گالری",
                                    maxFontSize: 22,
                                    minFontSize: 8,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      galleryFunc();
                                    },
                                    iconSize: size.width * .08,
                                    icon: Icon(
                                      Icons.photo_library_outlined,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  AutoSizeText(
                                    "دوربین",
                                    maxFontSize: 22,
                                    minFontSize: 8,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: Colors.black54,
                                      fontSize: 16,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      camFunc();
                                    },
                                    iconSize: size.width * .08,
                                    icon: Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
