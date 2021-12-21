import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/GetCartListModel.dart';
import 'package:dentino/models/GetCategoryShop.dart';
import 'package:dentino/models/GetDetailProductModel.dart';
import 'package:dentino/models/GetProductModel.dart';
import 'package:dentino/models/OrderIDModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';

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
  TextEditingController addressTextController = TextEditingController();
  final RoundedLoadingButtonController btnController2 =
      RoundedLoadingButtonController();

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
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.height * .02),
                child: _submitBtn(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submitBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
      child: RoundedLoadingButton(
          height: Get.height * .055,
          width: Get.width,
          successColor: Color(0xff077F7F),
          color: Colors.blue,
          child: AutoSizeText(
            "تکمیل خرید",
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          controller: btnController2,
          animateOnTap: true,
          resetAfterDuration: true,
          resetDuration: Duration(seconds: 3),
          onPressed: () {
            OrderModal();
          }),
    );
  }

  OrderModal() {
    return showCupertinoModalBottomSheet(
      context: Get.context,
      backgroundColor: Colors.transparent,
      elevation: 0,
      enableDrag: false,
      isDismissible: true,
      builder: (context) => Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Container(
          height: Get.height * .5,
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
                    "تکمیل سفارش",
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
                  height: Get.height * .4,
                  width: Get.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * .04, vertical: Get.height * .02),
                  child: _messageTextField(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(bottom: Get.height * .02),
                  child: _ToBankBtn(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _ToBankBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
      child: RoundedLoadingButton(
          height: Get.height * .055,
          width: Get.width,
          successColor: Color(0xff077F7F),
          color: Colors.blue,
          child: AutoSizeText(
            "پرداخت",
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          controller: btnController2,
          animateOnTap: true,
          resetAfterDuration: true,
          resetDuration: Duration(seconds: 3),
          onPressed: () {
            OrderCreateController()
                .OrderCreateData(address: addressTextController.text);
          }),
    );
  }

  Widget _messageTextField() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ConstrainedBox(
        constraints: BoxConstraints(
            maxHeight: Get.height * .25,
            maxWidth: Get.width,
            minHeight: Get.height * .15),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
          child: TextField(
            keyboardType: TextInputType.text,
            maxLines: null,
            textDirection: TextDirection.rtl,
            controller: addressTextController,
            maxLength: 500,
            minLines: 1,
            decoration: InputDecoration(
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white.withOpacity(.40)),
                borderRadius: BorderRadius.circular(30),
              ),
              labelText: "آدرس خود را وارد کنید",
              hintText: "آدرس",
              // contentPadding: EdgeInsets.all(size.width * .03),
              labelStyle: TextStyle(
                fontSize: 12,
                color: Colors.black.withOpacity(.40),
              ),
              counter: Offstage(),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(.40)),
                borderRadius: const BorderRadius.all(
                  const Radius.circular(30.0),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.grey.withOpacity(.40),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              filled: true,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.withOpacity(.40)),
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              hintStyle:
                  TextStyle(fontSize: 12, color: Colors.grey.withOpacity(.20)),
              fillColor: Colors.white,
            ),
          ),
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

class OrderCreateController extends GetxController {
  OrderIdModel orderIdModel;

  _launchURL(url) async {
    await launch(url);
  }

  OrderCreateData({String address}) async {
    RequestHelper.orderCreate(
            token: await PrefHelper.getToken(), address: address)
        .then((value) {
      if (value.isDone) {
        orderIdModel = OrderIdModel.fromJson(value.data);
        ViewHelper.showSuccessDialog(
            Get.context, "در حال انتقال به درگاه پرداخت");
        ToBankApi();
      } else {
        ViewHelper.showErrorDialog(Get.context, "انتقال با خطا مواجه شد");
      }
    });
  }

  ToBankApi() async {
    RequestHelper.ToBank(
            token: await PrefHelper.getToken(),
            order_id: orderIdModel.orderId.toString())
        .then((value) {
          if(value.isDone){
            _launchURL(value.data);
          }
    });
  }
}
