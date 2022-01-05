import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/MainController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscountScreen extends StatelessWidget {
  DiscountController discountController = Get.put(DiscountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "باشگاه مشتریان",
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
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Obx(
      () {
        if (!discountController.loading.value) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: Get.height * .08,
              width: Get.width * .15,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return (discountController.DiscountList.length == 0)
              ? Stack(
                  children: [
                    Center(
                      child: AutoSizeText(
                        "هیچ تخفیفی ثبت نشده است",
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
                      _buildOfferList(),
                    ],
                  ),
                );
        }
      },
    );
  }

  _buildOfferList() {
    return Expanded(
        child: ListView.builder(
            itemCount: discountController.DiscountList.length,
            itemBuilder: itemBuilder));
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = discountController.DiscountList[index];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: Get.height * .08,
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
        margin: EdgeInsets.symmetric(
            horizontal: Get.width * .05, vertical: Get.height * .02),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 5),
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              "کلینیک: " + item.clinicName,
              maxFontSize: 24,
              minFontSize: 6,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            AutoSizeText(
              "بخش: " + item.expertiseName,
              maxFontSize: 24,
              minFontSize: 6,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            AutoSizeText(
              "میزان تخفیف: " + item.percent.toString() + " %",
              maxFontSize: 24,
              minFontSize: 6,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
