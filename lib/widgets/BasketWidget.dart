import 'package:dentino/controllers/ShopController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasketWidget extends StatelessWidget {
  BasketController shop2Controller = Get.put(BasketController());

  @override
  Widget build(BuildContext context) {
    return _buildBasket();
  }

  _buildBasket() {
    return GestureDetector(
      onTap: () {
        shop2Controller.BasketModal();
      },
      child: Container(
        height: Get.height * .15,
        width: Get.width * .15,
        decoration: BoxDecoration(
            color: ColorsHelper.mainColor, shape: BoxShape.circle),
        child: Center(
          child: Image.asset(
            "assets/images/carts.png",
            width: Get.width * .1,
          ),
        ),
      ),
    );
  }
}
