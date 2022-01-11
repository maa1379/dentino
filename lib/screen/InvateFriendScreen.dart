import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/MainController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/widgetHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class InvateFriendPage extends StatefulWidget {
  @override
  _InvateFriendPageState createState() => _InvateFriendPageState();
}

class _InvateFriendPageState extends State<InvateFriendPage> {
  Size size;
  String code = "014-DJHS";

  ReferralCodeController referralCodeController =
      Get.put(ReferralCodeController());


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "دعوت از دوستان",
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
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: _buildBody()
        ),
      ),
    );
  }

  _buildBody() {
    return Obx(
          () {
        if (!referralCodeController.loading.value) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: Get.height * .08,
              width: Get.width * .15,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return _BuildBody1();
        }
      },
    );
  }


  void share(BuildContext context) {
    String text = "Share Code:$code";
    final RenderBox box = context.findRenderObject();
    Share.share(text,
        subject: "share code",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  _BuildBody1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: size.height * .1,
        ),
        AutoSizeText(
          ".برای کسب امتیاز بیشتر کد زیر را برای دوستان و آشنایانتان ارسال نمایید",
          minFontSize: 10,
          maxFontSize: 22,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: size.height * .1),
          height: size.height * .065,
          width: size.width * .8,
          decoration: BoxDecoration(
              color: ColorsHelper.mainColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  spreadRadius: 1,
                  color: Colors.black26,
                )
              ]),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Container(
                alignment: Alignment.center,
                height: size.height * .065,
                width: size.width * .4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.grey, width: .5),
                ),
                child: AutoSizeText(
                  referralCodeController.code.toString(),
                  minFontSize: 14,
                  maxFontSize: 26,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    color: ColorsHelper.mainColor,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => share(context),
                child: Container(
                  margin: EdgeInsets.only(left: size.width * .08),
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    "اشتراک گذاری",
                    minFontSize: 14,
                    maxFontSize: 26,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(
              bottom: size.height * .3, top: size.height * .05),
          height: size.height * .08,
          width: size.width * .8,
          child: AutoSizeText(
            "از دوستان خود بخواهید کد معرف را در منوی پروفایل، قسمت ثبت کد دعوت کننده وارد نمایند. در نظر داشته باشید که امتیاز معرف بعد از اولین خرید وی در باشگاه مشتریان نگاکلاب دریافت خواهید کرد",
            minFontSize: 10,
            textAlign: TextAlign.center,
            maxFontSize: 26,
            maxLines: 10,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
