import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/ShopController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/widgets/BasketWidget.dart';
import 'ProductListScreen.dart';


class ShopSubCategoryScreen extends StatelessWidget {

  ShopSubCategoryController shopSubCategoryController = Get.put(ShopSubCategoryController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BasketWidget(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "فروشگاه",
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
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          _buildGridView(),
        ],
      ),
    );
  }


  _buildGridView() {
    return Expanded(
      child: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: shopSubCategoryController.SubcategoryList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 0.9),
          itemBuilder: _buildServiceItem),
    );
  }

  Widget _buildServiceItem(BuildContext context, int index) {
    var item = shopSubCategoryController.SubcategoryList[index];
    // var image = url + item.image;
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: (){
          Get.to(()=>ProductListScreen(),arguments: {"category_id": item.id.toString()});
          // Get.to(ReserveScreen(),arguments: {});
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ]),
              child: CircleAvatar(
                  backgroundColor: ColorsHelper.mainColor,
                  radius: Get.width * .12,
                  child: Icon(Icons.shop)
              ),
            ),
            SizedBox(
              height: Get.height * .01,
            ),
            AutoSizeText(
              item.title,
              maxFontSize: 24,
              minFontSize: 6,
              maxLines: 1,
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }




}

