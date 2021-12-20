import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dentino/controllers/MainController.dart';
import 'package:dentino/controllers/ShopController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/models/GetCartListModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  DetailProductController detailProductController =
      Get.put(DetailProductController());
  CarouselController buttonCarouselController = CarouselController();
  int _current = 0;
  int quantity = 1;
  final sliderController = Get.put(SliderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "جزئیات محصول",
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
        if (!detailProductController.loading.value) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: Get.height * .08,
              width: Get.width * .15,
              child: CircularProgressIndicator(),
            ),
          );
        } else {
          return Container(
            height: Get.height,
            width: Get.width,
            margin: EdgeInsets.only(top: Get.height * .015),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildTopSlider(),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  _buildName(),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  _buildDescription(),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  _buildPrice(),
                  SizedBox(
                    height: Get.height * .02,
                  ),
                  _buildFooter(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  _buildTopSlider() {
    return Container(
      height: Get.height * .28,
      width: Get.width,
      margin: EdgeInsets.only(
        top: Get.height * .02,
      ),
      child: Column(
        children: [
          Container(
            height: Get.height * .25,
            width: Get.width,
            child: CarouselSlider(
              items: detailProductController.imageList.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 8,
                                spreadRadius: 2,
                                color: Colors.black38)
                          ]),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          i,
                          fit: BoxFit.fill,
                          width: double.maxFinite,
                        ),
                      ),
                    );
                  },
                );
              }).toList(),
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                enlargeCenterPage: true,
                reverse: false,
                enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                height: Get.width,
                onPageChanged: (page, reason) {
                  setState(() {
                    _current = page;
                  });
                },
                aspectRatio: 2.0,
                initialPage: _current,
              ),
            ),
          ),
          SizedBox(
            height: Get.height * .02,
          ),
          AnimatedSmoothIndicator(
            activeIndex: _current,
            onDotClicked: (value) {
              setState(() {
                _current = value;
              });
            },
            count: detailProductController.imageList.length,
            effect: ExpandingDotsEffect(
                activeDotColor: ColorsHelper.mainColor,
                dotWidth: Get.width * .016,
                dotHeight: Get.height * .008),
          ),
        ],
      ),
    );
  }

  _buildName() {
    return Container(
      height: Get.height * .1,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 5),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            detailProductController.getDetailProductItem.name,
            maxFontSize: 24,
            minFontSize: 6,
            maxLines: null,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: ColorsHelper.mainColor,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  _buildDescription() {
    return ConstrainedBox(
      //  fit: FlexFit.loose,
      constraints: BoxConstraints(
        maxHeight: Get.height,
        minHeight: Get.height * .15,
        maxWidth: Get.width,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
        padding: EdgeInsets.all(Get.width * .05),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 5),
          ],
        ),
        child: AutoSizeText(
          detailProductController.getDetailProductItem.description,
          maxFontSize: 24,
          minFontSize: 6,
          textDirection: TextDirection.rtl,
          maxLines: null,
          textAlign: TextAlign.justify,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 12,
          ),
        ),
      ),
    );
  }

  _buildPrice() {
    return Container(
      height: Get.height * .08,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
      padding: EdgeInsets.all(Get.width * .05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 5),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            detailProductController.getDetailProductItem.price,
            maxFontSize: 24,
            minFontSize: 6,
            textDirection: TextDirection.rtl,
            maxLines: null,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
          AutoSizeText(
            "قیمت:",
            maxFontSize: 24,
            minFontSize: 6,
            textDirection: TextDirection.rtl,
            maxLines: null,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  _buildFooter() {
    return Container(
      height: Get.height * .08,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 5),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildAddToCartBtn(),
          _Conter(),
        ],
      ),
    );
  }

  Widget _Conter() {
    return Container(
      height: Get.height * .05,
      width: Get.width * .3,
      child: Column(
        children: [
          Container(
            height: Get.height * .05,
            width: Get.width * .25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity++;
                      });
                    },
                    child: Icon(Icons.add_circle,
                        color: Colors.grey, size: Get.width * .08)),
                AutoSizeText(
                  quantity.toString(),
                  maxFontSize: 28,
                  minFontSize: 6,
                  maxLines: 1,
                  style: TextStyle(
                      fontSize: 16,
                      color: ColorsHelper.mainColor,
                      fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        quantity--;
                      });
                    },
                    child: Icon(Icons.remove_circle,
                        color: Colors.grey, size: Get.width * .08)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildAddToCartBtn() {
    return GestureDetector(
      onTap: () {
        if (quantity == 0) {
          ViewHelper.showErrorDialog(context, "لطفا تعداد محصول را وارد کنید");
        } else {
          EasyLoading.show(indicator: CircularProgressIndicator(),dismissOnTap: false);
          detailProductController.AddToCartProduct(
              quantity: quantity.toString());
          Get.find<BasketController>().CartList.clear();
          Get.find<BasketController>().GetCartList();

        }
      },
      child: Container(
        height: Get.height * .05,
        width: Get.width * .4,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 5),
          ],
        ),
        child: Center(
          child: AutoSizeText(
            "افزودن به سبد خرید",
            maxFontSize: 28,
            minFontSize: 6,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
