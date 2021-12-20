import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/ClinicController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/screen/ClinicProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ClinicListScreen extends StatelessWidget {
  final clinicController = Get.put(ClinicController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "لیست کلینیک",
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
      body: Container(
        height: Get.height,
        width: Get.width,
        child: _buildClinicList(),
      ),
    );
  }

  _buildClinicList() {
    return AnimationLimiter(
      child: GridView.builder(
          itemCount: clinicController.clinicList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          padding: EdgeInsets.only(top: Get.height * .01),
          physics: BouncingScrollPhysics(),
          itemBuilder: itemBuilder),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = clinicController.clinicList[index];
    return AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: 2,
      duration: const Duration(milliseconds: 500),
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: Container(
            height: Get.height * .15,
            width: Get.width,
            padding: EdgeInsets.all(Get.width * .02),
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * .05, vertical: Get.height * .015),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 5,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: Get.height * .08,
                  width: Get.width * .22,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(item.logo),
                      // fit: BoxFit.cover
                    ),
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black26,
                          spreadRadius: 2,
                          blurRadius: 5),
                    ],
                  ),
                ),
                AutoSizeText(
                  "نام کلینیک: ${item.name}",
                  maxFontSize: 24,
                  minFontSize: 6,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                  ),
                ),
                AutoSizeText(
                  "شماره تماس: ${item.phoneNumber}",
                  maxFontSize: 24,
                  minFontSize: 6,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(()=>ClinicProfileScreen(),arguments: {"clinicProfile_id": item.id});
                  },
                  child: Container(
                    height: Get.height * .04,
                    width: Get.width * .4,
                    decoration: BoxDecoration(
                      color: ColorsHelper.mainColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            spreadRadius: 2,
                            blurRadius: 5),
                      ],
                    ),
                    child: Center(
                      child: AutoSizeText(
                        "پروفایل کلینیک",
                        maxFontSize: 24,
                        minFontSize: 6,
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
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
