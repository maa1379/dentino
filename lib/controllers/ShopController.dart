import 'dart:async';
import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/helpers/widgetHelper.dart';
import 'package:dentino/models/GetCartListModel.dart';
import 'package:dentino/models/GetCategoryShop.dart';
import 'package:dentino/models/GetDetailProductModel.dart';
import 'package:dentino/models/GetProductModel.dart';
import 'package:dentino/models/OrderIDModel.dart';
import 'package:dentino/models/OrderListModel.dart';
import 'package:dentino/screen/IntroScreen.dart';
import 'package:dentino/screen/OrderListScreen.dart';
import 'package:dentino/screen/ProfileScreen.dart';
import 'package:dentino/widgets/OrderListWidget.dart';
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
        Get.find<BasketController>().CartList.clear();
        Get.find<BasketController>().GetCartList();
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
  TextEditingController nameController = TextEditingController();
  TextEditingController familyController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  TextEditingController emailController = TextEditingController();

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
                child: (CartList.length == 0) ? Container() : _submitBtn(),
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
                  height: Get.height * .65,
                  width: Get.width,
                  padding: EdgeInsets.symmetric(
                      horizontal: Get.width * .04, vertical: Get.height * .02),
                  child: Column(
                    children: [
                      _buildNameField(),
                      _buildLNameField(),
                      _buildPostCodeField(),
                      _buildEmailField(),
                      _messageTextField(),
                    ],
                  ),
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
            OrderCreateController().OrderCreateData(
                address: addressTextController.text,
                code: codeController.text,
                email: emailController.text,
                family: familyController.text,
                name: nameController.text);
          }),
    );
  }

  _buildLNameField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .09,
      color: Colors.transparent,
      controller: familyController,
      fontSize: 12,
      hintText: "نام خانوادگی خود را وارد کنید",
      enabled: true,
      text: "نام خانوادگی",
      function: (value) {
        if (value == "") {
          return "نام خانوادگی خود را وارد کنید";
        }
      },
      size: Get.size,
      maxLine: 1,
      maxLength: 120,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.text,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
    );
  }

  _buildNameField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .09,
      color: Colors.transparent,
      fontSize: 12,
      controller: nameController,
      hintText: "نام خود را وارد کنید",
      enabled: true,
      text: "نام",
      onChange: (value) {
        // WidgetHelper.onChange(value, mobileController);
      },
      // controller: mobileController,
      // errorText: "شماره موبایل خود را وارد کنید!",
      function: (value) {
        if (value == "") {
          return "نام خود را وارد کنید";
        }
      },
      size: Get.size,
      maxLine: 1,
      maxLength: 120,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.text,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
    );
  }

  _buildPostCodeField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .09,
      color: Colors.transparent,
      fontSize: 16,
      controller: codeController,
      hintText: "کد پستی خود را وارد کنید",
      enabled: true,
      text: "کد پستی",
      function: (value) {
        if (value == "") {
          return "کد پستی خود را وارد کنید";
        }
      },
      size: Get.size,
      maxLine: 1,
      maxLength: 15,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.number,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
    );
  }

  _buildEmailField() {
    return WidgetHelper.profileTextField(
      width: Get.width,
      height: Get.height * .09,
      color: Colors.transparent,
      fontSize: 12,
      controller: emailController,
      hintText: "ایمیل خود را وارد کنید",
      enabled: true,
      text: "ایمیل",
      function: (value) {
        if (value == "") {
          return "ایمیل خود را وارد کنید";
        }
      },
      size: Get.size,
      maxLine: 1,
      maxLength: 15,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.emailAddress,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .1),
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
          padding: EdgeInsets.symmetric(horizontal: Get.width * .1),
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            maxLines: null,
            textDirection: TextDirection.rtl,
            controller: addressTextController,
            maxLength: 500,
            minLines: 1,
            decoration: InputDecoration(
              labelText: "آدرس",
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(color: ColorsHelper.mainColor, width: 3)),
              disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(color: ColorsHelper.mainColor, width: 3)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.red, width: 3)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.red, width: 3)),
              enabled: true,
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide:
                      BorderSide(color: ColorsHelper.mainColor, width: 3)),
              // labelText: text,
              hintText: "آدرس خود را وارد کنید",
              contentPadding:
                  EdgeInsets.only(top: Get.width * .01, right: Get.width * .05),
              counter: Offstage(),
              filled: true,
              hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              fillColor: Colors.transparent,
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
    // initUniLinks();
  }

  OrderCreateData(
      {String address,
      String name,
      String family,
      String code,
      String email}) async {
    RequestHelper.orderCreate(
            token: await PrefHelper.getToken(),
            address: address,
            name: name,
            family: family,
            email: email,
            code: code)
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
      if (value.isDone) {
        _launchURL(value.data);
      }
    });
  }

  ToBank2Api({String order_id}) async {
    RequestHelper.ToBank(token: await PrefHelper.getToken(), order_id: order_id)
        .then((value) {
      if (value.isDone) {
        _launchURL(value.data);
      }
    });
  }
}

class checkOut extends GetxController {
  StreamSubscription _sub;

  Future<void> initUniLinks() async {
    _sub = uriLinkStream.listen((Uri uri) {
      print(jsonDecode(uri.queryParameters['status'].toString()));
      final myMap = jsonDecode(uri.queryParameters['status'].toString());
      if (myMap == 100 || myMap == "100") {
        Get.find<BasketController>().GetCartList();
        Get.find<OrderListController>().OrderListData();
        Get.to(OrderListWidget());
        ViewHelper.showSuccessDialog(
            Get.context, "پرداخت موفق بود، سفارش شما با موفقیت پرداخت شد");
      } else {
        Get.to(OrderListWidget());
        print("no ok");
        ViewHelper.showErrorDialog(Get.context, "پرداخت موفق نبود");
      }
    }, onError: (err) {
      print(err);
    });
  }

  @override
  void onInit() {
    initUniLinks();
    super.onInit();
  }

}

class OrderListController extends GetxController {
  RxBool loading = false.obs;
  RxList<OrderListModel> order_list = <OrderListModel>[].obs;

  OrderListData() async {
    RequestHelper.orderList(token: await PrefHelper.getToken()).then(
      (value) {
        if (value.isDone) {
          for (var i in value.data) {
            order_list.add(OrderListModel.fromJson(i));
          }
          loading.value = true;
        } else {
          loading.value = false;
          ViewHelper.showErrorDialog(Get.context, "ارتباط برقرار نشد");
        }
      },
    );
  }

  @override
  void onInit() {
    OrderListData();
  }
}
