import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/GetCartListModel.dart';
import 'package:dentino/models/GetCategoryShop.dart';
import 'package:dentino/models/GetDetailProductModel.dart';
import 'package:dentino/models/GetProductModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ShopController extends GetxController {
  RxList<GetCategoryShop> categoryList = <GetCategoryShop>[].obs;

  GetCategory() async {
    RequestHelper.GetCategoryShop().then((value) {
      if (value.isDone) {
        for (var i in value.data) {
          categoryList.add(GetCategoryShop.fromJson(i));
          print("category");
          EasyLoading.dismiss();
        }
      } else {
        print("not ok");
      }
    });
  }

  @override
  void onInit() {
    GetCategory();
    super.onInit();
  }
}

class ProductController extends GetxController {
  RxList<GetProductModel> productList = <GetProductModel>[].obs;

  RxBool loading = false.obs;

  GetProductList() async {
    RequestHelper.getProductList(id: Get.arguments["category_id"])
        .then((value) {
      if (value.isDone) {
        for (var i in value.data) {
          productList.add(GetProductModel.fromJson(i));
          print("category");
          loading.value = true;
        }
      } else {
        loading.value = false;
        print("not ok");
      }
    });
  }

  @override
  void onInit() {
    GetProductList();
    super.onInit();
  }
}

class DetailProductController extends GetxController {
  GetDetailProductModel getDetailProductItem;
  RxBool loading = false.obs;
  RxList imageList = [].obs;

  DetailProduct() async {
    RequestHelper.getDetailProduct(product_id: Get.arguments['productItem_id'])
        .then((value) {
      if (value.isDone) {
        getDetailProductItem = GetDetailProductModel.fromJson(value.data);
        imageList.add(getDetailProductItem.image);
        imageList.add(getDetailProductItem.image2);
        imageList.add(getDetailProductItem.image3);
        imageList.add(getDetailProductItem.image4);
        loading.value = true;
      } else {
        loading.value = false;
        print("not ok");
      }
    });
  }

  AddToCartProduct({String quantity}) async {
    RequestHelper.AddToCart(
            quantity: quantity,
            product_id: Get.arguments['productItem_id'],
            token: await PrefHelper.getToken())
        .then((value) {
      if (value.isDone) {
        EasyLoading.dismiss();
        ViewHelper.showSuccessDialog(
            Get.context, "محصول با موفقیت به سبد خرید اضافه شد");
      } else {
        ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
      }
      ;
    });
  }

  @override
  void onInit() {
    DetailProduct();
    super.onInit();
  }
}

class BasketController extends GetxController {
  RxList<ItemList> CartList = <ItemList>[].obs;
  RxBool isRemove = false.obs;

  GetCartList() async {
    RequestHelper.GetCartList(token: await PrefHelper.getToken()).then(
      (value) {
        if (value.isDone || value.statusCode == 200) {
          for (var i in value.data['items']) {
            CartList.add(ItemList.fromJson(i));
          }
        } else {
          ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
        }
      },
    );
  }

  ClearITemCart({String row_id}) async {
    RequestHelper.ClearITemCart(
            token: await PrefHelper.getToken(), row_id: row_id)
        .then((value) {
      if (value.isDone) {
        isRemove.value = true;
        EasyLoading.dismiss();
        ViewHelper.showSuccessDialog(Get.context, "محصول حذف شد");
      } else {
        isRemove.value = false;
        ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
      }
    });
  }

  BasketModal() {
    return showCupertinoModalBottomSheet(
      context: Get.context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: false,
      isDismissible: true,
      builder: (context) => Container(
        height: Get.height * .8,
        margin: EdgeInsets.all(Get.width * .02),
        width: Get.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(25)),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * .005),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close),
                  color: Colors.black,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: Get.height * .02),
                child: AutoSizeText(
                  "سبد خرید شما",
                  maxFontSize: 24,
                  minFontSize: 6,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorsHelper.mainColor,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: Get.height * .75,
                width: Get.width,
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .04, vertical: Get.height * .02),
                child: Obx(() {
                  if (CartList.length == 0) {
                    return Center(child: Text("سبد خرید شما خالی می باشد"));
                  } else {
                    return AnimationLimiter(
                      child: ListView.builder(
                          itemCount: CartList.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: buildCartListItem),
                    );
                  }
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCartListItem(BuildContext context, int index) {
    var item = CartList[index];
    String url = "https://dentino.app";
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  EasyLoading.show(
                      indicator: CircularProgressIndicator(),
                      dismissOnTap: false);
                  ClearITemCart(row_id: item.rowId);
                  if (isRemove == true) {
                    CartList.removeAt(index);
                  }
                },
                icon: Icon(Icons.close)),
            Container(
              height: Get.height * .12,
              width: Get.width * .7,
              // margin: EdgeInsets.all(Get.width * .01),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, spreadRadius: 2, blurRadius: 5),
                ],
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: Container(
                        padding: EdgeInsets.all(Get.width * .02),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(url + item.productImage))),
                  ),
                  SizedBox(
                    width: Get.width * .02,
                  ),
                  Flexible(
                    flex: 2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AutoSizeText(
                          "نام کالا: " + item.productName,
                          maxFontSize: 24,
                          minFontSize: 10,
                          maxLines: 2,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        AutoSizeText(
                          "قیمت: " + item.productPrice + " ریال",
                          maxFontSize: 24,
                          minFontSize: 6,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        AutoSizeText(
                          "تعداد: " + item.productQuantity,
                          maxFontSize: 24,
                          minFontSize: 6,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void onInit() {
    GetCartList();
    super.onInit();
  }
}