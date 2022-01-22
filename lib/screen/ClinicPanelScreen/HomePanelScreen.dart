import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/LoginClinicPanelController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/plugin/neumorphic-package-by-serge-software/neumorphic-card.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomePanelScreen extends StatelessWidget {
  itemNumberController numberController = Get.put(itemNumberController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsHelper.colorBlack,
          leading: Container(),
          centerTitle: true,
          title: AutoSizeText(
            "میز کار",
            maxLines: 1,
            maxFontSize: 28,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        body: Obx(() {
          if (numberController.loading.value == false) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Container(
              height: Get.height,
              width: Get.width,
              color: ColorsHelper.colorBlack,
              child: Column(
                children: [
                  _buildTopTab(),
                  _buildMenu(),
                ],
              ),
            );
          }
        }),
      ),
    );
  }

  _buildTopTab() {
    return NeumorphicContainer(
        alignment: Alignment.center,
        width: Get.width,
        margin: EdgeInsets.all(Get.width * .05),
        padding: EdgeInsets.all(Get.width * .05),
        height: Get.height * .45,
        decoration: MyNeumorphicDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ColorsHelper.colorBlack,
        ),
        curveType: CurveType.emboss,
        bevel: 15,
        child: Column(
          children: [
            Row(
              children: [
                _tabsItemBuilder(
                    name: "تعداد نوبت ها",
                    number: numberController.item.reservtionNumber.toString()),
                _tabsItemBuilder(
                    name: "تعداد پزشکان",
                    number: numberController.item.doctorNumber.toString()),
              ],
            ),
            Row(
              children: [
                _tabsItemBuilder(
                    name: "تعداد شرکت ها",
                    number: numberController.item.companiesNumber.toString()),
                _tabsItemBuilder(
                    name: "تعداد تخفیفات",
                    number:
                        numberController.item.clinicDiscountNumber.toString()),
              ],
            ),
          ],
        ));
  }

  _tabsItemBuilder({String name, String number}) {
    return NeumorphicContainer(
      alignment: Alignment.center,
      width: Get.width * .3,
      margin: EdgeInsets.symmetric(
          horizontal: Get.width * .05, vertical: Get.height * .025),
      padding: EdgeInsets.symmetric(
          horizontal: Get.width * .05, vertical: Get.height * .035),
      height: Get.height * .15,
      decoration: MyNeumorphicDecoration(
        borderRadius: BorderRadius.circular(30),
        color: ColorsHelper.colorBlack,
      ),
      curveType: CurveType.emboss,
      bevel: 15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            name,
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorsHelper.colorOrange, fontSize: 16),
          ),
          AutoSizeText(
            number,
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorsHelper.colorOrange1, fontSize: 18),
          ),
        ],
      ),
    );
  }

  _buildMenu() {
    return Expanded(
      child: NeumorphicContainer(
        alignment: Alignment.center,
        margin: EdgeInsets.all(Get.width * .05),
        padding: EdgeInsets.only(
            top: Get.height * .035,
            left: Get.width * .05,
            right: Get.width * .05),
        decoration: MyNeumorphicDecoration(
          borderRadius: BorderRadius.circular(30),
          color: ColorsHelper.colorBlack,
        ),
        curveType: CurveType.emboss,
        bevel: 20,
        child: GridView.builder(
            itemCount: 6,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 10,
            ),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: _menuItemBuilder),
      ),
    );
  }

  Widget _menuItemBuilder(BuildContext context, int index) {
    return NeumorphicContainer(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(
          horizontal: Get.width * .02, vertical: Get.height * .01),
      // padding: EdgeInsets.all(Get.width * .05),
      decoration: MyNeumorphicDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorsHelper.colorBlack,
      ),
      curveType: CurveType.emboss,
      bevel: 15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.web,
            color: ColorsHelper.colorOrange.withOpacity(0.8),
            size: Get.width * .1,
          ),
          SizedBox(
            height: Get.height * .01,
          ),
          AutoSizeText(
            "پزشکان",
            maxLines: 2,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: ColorsHelper.colorOrange1, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
