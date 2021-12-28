import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/ReservationController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/screen/LocationScreen.dart';
import 'package:dentino/screen/ReserveScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServicesScreen extends StatelessWidget {
  Size size;
  final exertiseController = Get.put(ExertiseController());


  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          elevation: 5,
          backgroundColor: Colors.white,
          title: AutoSizeText(
            "لیست خدمات",
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
        body: _buildBody());
  }

  _buildGridView() {
    return Expanded(
      child: GridView.builder(
          physics: BouncingScrollPhysics(),
          itemCount: exertiseController.exertiseListData.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 2,
              crossAxisSpacing: 2,
              childAspectRatio: 0.9),
          itemBuilder: _buildServiceItem),
    );
  }

  Widget _buildServiceItem(BuildContext context, int index) {
    var item = exertiseController.exertiseListData[index];
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          // Get.to(()=>ReserveScreen(),arguments: {"expertise_id": item.id.toString()});
          Get.to(
            () => LocationScreen(
              expertise_id: item.id.toString(),
            ),
          );
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
                radius: size.width * .12,
                child: Image.network(
                  item.image,
                  width: size.width * .15,
                ),
              ),
            ),
            SizedBox(
              height: size.height * .01,
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

  _buildBody() {
    return Obx(() {
      if (!exertiseController.loading.value) {
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: Get.height * .08,
            width: Get.width * .15,
            child: CircularProgressIndicator(),
          ),
        );
      } else {
        return Column(
          children: [
            SizedBox(
              height: size.height * .02,
            ),
            _buildGridView(),
          ],
        );
      }
    });
  }
}
