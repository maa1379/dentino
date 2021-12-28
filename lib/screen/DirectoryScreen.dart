import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/DirectoryController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'DoctorDirectoryScreen.dart';

class DirectoryScreen extends StatelessWidget {
  DirectoryController directoryController = Get.put(DirectoryController());

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
        child: _buildCategoryList(),
      ),
    );
  }

  _buildCategoryList() {
    return ListView.builder(
        itemCount: directoryController.CategoryList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: itemBuilder);
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = directoryController.CategoryList[index];
    return Container(
      height: Get.height * .1,
      width: Get.width,
      margin: EdgeInsets.symmetric(
          horizontal: Get.width * .05, vertical: Get.height * .015),
      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AutoSizeText(
            item.name,
            maxFontSize: 24,
            minFontSize: 6,
            maxLines: 1,
            style: TextStyle(
              color: ColorsHelper.mainColor,
              fontSize: 18,
            ),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => DoctorDirectoryScreen(),
                  arguments: {"cat_id": item.id.toString()});
            },
            child: Icon(
              Icons.arrow_forward_ios,
              size: Get.width * .04,
            ),
          ),
        ],
      ),
    );
  }
}
