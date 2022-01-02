import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/screen/OrderListScreen.dart';
import 'package:flutter/material.dart';



class OrderListWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "لیست سفارشات",
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
      body: OrderListScreen(),
    );
  }
}
