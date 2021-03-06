import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/ShopController.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class OrderListScreen extends StatelessWidget {
  OrderListController orderListController = Get.put(OrderListController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      child: Column(
        children: [
          _buildOrderList(),
        ],
      ),
    );
  }

  _buildOrderList() {
    return Expanded(
      child: AnimationLimiter(
        child: ListView.builder(
            itemCount: orderListController.order_list.length,
            itemBuilder: itemBuilder),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = orderListController.order_list[index];
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Container(
            height: Get.height * .28,
            width: Get.width,
            padding: EdgeInsets.all(Get.width * .03),
            margin: EdgeInsets.symmetric(
                horizontal: Get.width * .05, vertical: Get.height * .02),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 5),
                ]),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AutoSizeText(
                          "?????????? ??????: ${item.create.toString()}",
                          maxFontSize: 24,
                          minFontSize: 6,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        AutoSizeText(
                          "????????: ${item.address.toString()}",
                          maxFontSize: 24,
                          minFontSize: 6,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        AutoSizeText(
                          "???? ????????: ${item.code.toString()}",
                          maxFontSize: 24,
                          minFontSize: 6,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 14,
                          ),
                        ),
                        AutoSizeText(
                          "???????? ??????????: ${item.price.toString()}  ??????????",
                          maxFontSize: 24,
                          minFontSize: 6,
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        if (item.paid == false) {
                          ViewHelper.showSuccessDialog(
                              Get.context, "?????????? ???????????? ???? ?????????? ????????????");
                          OrderCreateController()
                              .ToBank2Api(order_id: item.id.toString());
                        } else {
                          ViewHelper.showSuccessDialog(Get.context,
                              "?????????? ?????? ???? ?????? ?????????? ???????? ?? ?????????? ??????");
                        }
                      },
                      child: Container(
                        height: Get.height * .05,
                        width: Get.width,
                        margin:
                            EdgeInsets.symmetric(horizontal: Get.width * .1),
                        decoration: BoxDecoration(
                          color: (item.paid == true)
                              ? Colors.green
                              : Colors.orange,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5,
                              spreadRadius: 2,
                            )
                          ],
                        ),
                        child: Center(
                          child: AutoSizeText(
                            (item.paid == true && item.isSend == false)
                                ? "?????????? ?????????? ?????????? ??????????"
                                : (item.paid == false && item.isSend == false)
                                    ? "????????????"
                                    : (item.isSend == true)
                                        ? "?????????? ??????"
                                        : (item.isSend == false)
                                            ? "?????????? ?????????? ????????"
                                            : "????????????",
                            maxFontSize: 24,
                            minFontSize: 6,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
