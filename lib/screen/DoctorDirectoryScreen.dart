import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/DirectoryController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/widgetHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorDirectoryScreen extends StatefulWidget {
  @override
  State<DoctorDirectoryScreen> createState() => _DoctorDirectoryScreenState();
}

class _DoctorDirectoryScreenState extends State<DoctorDirectoryScreen> {
  DoctorDirectoryController doctorDirectoryController =
      Get.put(DoctorDirectoryController());

  TextEditingController searchTextEditingController = TextEditingController();
  RxList _filtered = [].obs;

  _searchFunction() {
    _filtered = [].obs;
    for (int i = 0; i < doctorDirectoryController.DirectoryList.length; ++i) {
      var item = doctorDirectoryController.DirectoryList[i];
      if (item.word
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
          "دایرکتوری پزشکان",
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
        child: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return Obx(
      () {
        if (!doctorDirectoryController.loading.value) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: Get.height * .08,
              width: Get.width * .15,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return (doctorDirectoryController.DirectoryList.length.isBlank)
              ? Stack(
                  children: [
                    Center(
                      child: AutoSizeText(
                        "هیچ نوبت ثبت نشده است",
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
                      // _buildDoctorList(),
                      _searchTextField(),
                      _buildDoctorDirectoryList(),
                    ],
                  ),
                );
        }
      },
    );
  }

  _buildDoctorDirectoryList() {
    return Expanded(
        child: ListView.builder(
            itemCount: searchTextEditingController.text.isEmpty
                ? doctorDirectoryController.DirectoryList.length
                : _filtered.length,
            itemBuilder: itemBuilder));
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = doctorDirectoryController.DirectoryList[index];
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: Get.width,
          minHeight: Get.height * .15,
          maxWidth: Get.width,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .05 , vertical: Get.height * .02),
          margin: EdgeInsets.symmetric(
              horizontal: Get.width * .05, vertical: Get.height * .02),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AutoSizeText(
                          "لغت: " + item.word,
                          maxFontSize: 24,
                          minFontSize: 6,
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(
                          height: Get.height * .005,
                        ),
                        AutoSizeText(
                          "معنی لغت: " + item.meaning,
                          maxFontSize: 24,
                          minFontSize: 6,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        item.logo,
                        width: Get.width * .2,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
