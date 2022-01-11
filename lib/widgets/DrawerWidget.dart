import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/bloc/getProfileBloc.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/DrawerModel.dart';
import 'package:dentino/screen/ComplimentCreateScreen.dart';
import 'package:dentino/screen/InvateFriendScreen.dart';
import 'package:dentino/screen/LoginScreen.dart';
import 'package:dentino/screen/ProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'AboutUsWidget.dart';
import 'ContactUsWidget.dart';
import 'MyCourseWidget.dart';
import 'MyTurnsForDrawer.dart';

class DrawerWidget extends StatelessWidget {
  Size size;

  List<DrawerModel> DrawerList = [
    DrawerModel(
      id: 1,
      title: "پروفایل",
      icon: Icons.account_circle_outlined,
      func: ProfileScreen(),
    ),
    DrawerModel(
      id: 1,
      title: "نوبت های من",
      icon: Icons.info_outline,
      func: MyTurnsForDrawer(),
    ),
    DrawerModel(
      id: 1,
      title: "درباره دنتینو",
      icon: Icons.local_hospital_outlined,
      func: AboutUsWidget(),
    ),
    DrawerModel(
      id: 1,
      title: "تماس با دنتینو",
      icon: Icons.add_moderator,
      func: ContactUsWidget(),
    ),
    DrawerModel(
      id: 1,
      title: "دعوت از دوستان",
      icon: Icons.local_offer_outlined,
      func: InvateFriendPage(),
    ),
    DrawerModel(
      id: 1,
      title: "ثبت شکایت",
      icon: Icons.article_outlined,
      func: ComplimentCreateScreen(),
    ),
    DrawerModel(
      id: 8,
      title: "خروج",
      icon: Icons.exit_to_app_outlined,
      // func: exit(0),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: size.height * .8,
        width: size.width * .9,
        margin: EdgeInsets.only(right: size.width * .02),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          children: [
            SizedBox(
              height: size.height * .02,
            ),
            CircleAvatar(
              radius: size.width * .18,
              backgroundColor: ColorsHelper.mainColor,
              backgroundImage: AssetImage("assets/images/cat1.png"),
            ),
            SizedBox(
              height: size.height * .02,
            ),
            AutoSizeText(
              "منو",
              maxFontSize: 24,
              minFontSize: 12,
              maxLines: 1,
              style: TextStyle(
                color: ColorsHelper.mainColor,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: size.height * .05,
            ),
            _buildMenuItem(),
          ],
        ),
      ),
    );
  }

  _buildMenuItem() {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        alignment: Alignment.topCenter,
        height: size.height * .5,
        width: size.width,
        child: ListView.builder(
          itemCount: DrawerList.length,
          itemBuilder: (BuildContext context, int index) {
            var item = DrawerList[index];
            return GestureDetector(
              onTap: () {
                if (item.id == 8) {
                  PrefHelper.removeToken();
                  Get.off(LoginScreen());
                } else {
                  Get.to(item.func);
                }
              },
              child: Container(
                margin: EdgeInsets.only(top: 5),
                height: size.height * .05,
                width: size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * .05),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                item.icon,
                                color: ColorsHelper.mainColor,
                                size: size.width * .06,
                              ),
                              SizedBox(
                                width: size.width * .03,
                              ),
                              AutoSizeText(
                                item.title,
                                maxLines: 1,
                                maxFontSize: 28,
                                minFontSize: 12,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_outlined,
                            size: size.width * .035,
                            color: ColorsHelper.mainColor,
                          ),
                        ],
                      ),
                      Divider(
                        height: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
