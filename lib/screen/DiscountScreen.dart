import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/MainController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/widgetHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DiscountScreen extends StatefulWidget {
  @override
  State<DiscountScreen> createState() => _DiscountScreenState();
}

class _DiscountScreenState extends State<DiscountScreen> {
  DiscountController discountController = Get.put(DiscountController());

  TextEditingController searchTextEditingController = TextEditingController();

  RxList _filtered = [].obs;

  _searchFunction() {
    _filtered = [].obs;
    for (int i = 0; i < discountController.DiscountList.length; ++i) {
      var item = discountController.DiscountList[i];
      if (item.clinicName
          .toLowerCase()
          .contains(searchTextEditingController.text.toLowerCase())) {
        _filtered.add(item);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "تخفیفات",
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
                      _searchTextField(),
                      _buildTabBar(),
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
            horizontal: Get.width * .03, vertical: Get.height * .02),
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
              item.clinicName,
              maxFontSize: 24,
              minFontSize: 6,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Get.width * .15),
              child: AutoSizeText(
                item.expertiseName,
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: Get.width * .05),
              child: AutoSizeText(
                item.percent.toString() + " %",
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildTabBar() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: Get.height * .06,
        width: Get.width,
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: Get.width * .08),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              flex: 1,
              child: AutoSizeText(
                "نام مرکز",
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: AutoSizeText(
                "نوع خدمت",
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: AutoSizeText(
                "میزان تخفیف",
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchTextField() {
    return WidgetHelper.textField(
      icon: Padding(
        padding: EdgeInsets.symmetric(vertical: Get.height * .015),
        child: Image.asset(
          "assets/images/search.png",
          color: Colors.black45,
        ),
      ),
      text: "جستجو",
      hintText: "جستجو ...",
      width: Get.width * .9,
      height: Get.height * .06,
      // color: Color(0xfff5f5f5),
      size: Get.size,
      fontSize: 16,
      controller: searchTextEditingController,
      onChange: (text) {
        _searchFunction();
      },
      maxLine: 1,
      keyBoardType: TextInputType.text,
      obscureText: false,
      maxLength: 100,
    );
  }
}
