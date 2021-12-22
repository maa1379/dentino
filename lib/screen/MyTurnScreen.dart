import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/DoctorController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'DoctorProfile.dart';


class MyTurnScreen extends StatelessWidget {
  Size size;

  reserveListController ReserveListController = Get.put(reserveListController());

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: _buildBody()
    );
  }


  _buildBody() {
    return Obx(
          () {
        if (!ReserveListController.loading.value) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: Get.height * .08,
              width: Get.width * .15,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return (ReserveListController.reserveListData.length == 0)
              ? Stack(
            children: [
              Center(
                child: AutoSizeText(
                  "هیچ محصولی ثبت نشده است",
                  maxFontSize: 24,
                  minFontSize: 6,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          )
              : Container(
            height: Get.height,
            width: Get.width,
            margin: EdgeInsets.only(top: Get.height * .015),
            child: Column(
              children: [
                _buildDoctorList(),
              ],
            ),
          );
        }
      },
    );
  }


  _buildDoctorList() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: _buildDoctorListItem,
        itemCount: ReserveListController.reserveListData.length,
        physics: BouncingScrollPhysics(),
      ),
    );
  }

  Widget _buildDoctorListItem(BuildContext context, int index) {
    var item = ReserveListController.reserveListData[index];
    return Container(
      height: size.height * .15,
      width: size.width,
      padding: EdgeInsets.all(size.width * .02),
      margin: EdgeInsets.symmetric(
          horizontal: size.width * .05, vertical: size.height * .015),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              SizedBox(height: size.height * .01),
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: size.height * .04,
                  width: size.width * .22,
                  decoration: BoxDecoration(
                    color: Colors.red,
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
                      "تعلیق نوبت",
                      maxFontSize: 24,
                      minFontSize: 6,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: size.height * .025,
              ),
              GestureDetector(
                onTap: () {
                  Get.to(()=> DoctorProfile(),arguments: {"doctorProfile_id":item.doctorId.toString()});
                },
                child: Container(
                  height: size.height * .04,
                  width: size.width * .22,
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
                      "پروفایل پزشک",
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              AutoSizeText(
                "نام پزشک: " + item.doctorName,
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
                "کلینیک: " + item.drClName,
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                ),
              ),
              AutoSizeText(
                "نام بیمار: " + item.name + " " +item.family,
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

