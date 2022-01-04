import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/ShopController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/screen/ProductDetailScreen.dart';
import 'package:dentino/widgets/BasketWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatelessWidget {
  ProductController productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: BasketWidget(),
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "لیست محصولات",
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
      backgroundColor: Colors.white,
      body: _buildBody(),
    );
  }

  _buildBody() {
    return Obx(
      () {
        if (!productController.loading.value) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: Get.height * .08,
              width: Get.width * .15,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return (productController.productList.length == 0)
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
                      _buildProductList(),
                    ],
                  ),
                );
        }
      },
    );
  }

  _buildProductList() {
    return Expanded(
      child: AnimationLimiter(
        child: GridView.builder(
            itemCount: productController.productList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, mainAxisExtent: 220),
            padding: EdgeInsets.only(top: Get.height * .01),
            physics: BouncingScrollPhysics(),
            itemBuilder: itemBuilder),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = productController.productList[index];
    return AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: 2,
      duration: const Duration(milliseconds: 500),
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: Container(
            height: Get.height * .2,
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
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: Get.height * .08,
                        width: Get.width * .22,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(item.image),
                            // fit: BoxFit.cover
                          ),
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 2,
                                blurRadius: 5),
                          ],
                        ),
                      ),
                    ),
                    AutoSizeText(
                      item.name,
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
                      "قیمت: ${ViewHelper.moneyFormat(double.parse(item.price))}",
                      maxFontSize: 24,
                      minFontSize: 6,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    AutoSizeText(
                      "قیمت: ${ViewHelper.moneyFormat(double.parse(item.sell))}",
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
                        Get.to(() => ProductDetailScreen(),
                            arguments: {"productItem_id": item.id.toString()});
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
                            "جزئیات محصول",
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
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(right: Get.width * .023),
                    height: Get.height * .08,
                    width: Get.width * .08,
                    child: Center(
                      child: AutoSizeText(
                        "%" + item.discountPercent.toString(),
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
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
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
