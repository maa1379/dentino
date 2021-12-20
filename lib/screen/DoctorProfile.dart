import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/DoctorController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DoctorProfile extends StatelessWidget {
  DoctorProfileController doctorProfileController =
      Get.put(DoctorProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "پروفایل پزشک",
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
      body: SafeArea(
        child: _buildBody(),
      ),
    );
  }

  _buildBody() {
    return Obx(
      () {
        if (!doctorProfileController.loading.value) {
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
            margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  _buildTop(),
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  _buildBodyDoctor(),
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  _buildClinicName(),
                  SizedBox(
                    height: Get.height * .03,
                  ),
                  _buildExpertiseName(),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  _buildTop() {
    return Container(
      height: Get.height * .2,
      width: Get.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 1,
            child: CircleAvatar(
              backgroundColor: ColorsHelper.mainColor,
              maxRadius: Get.width * .15,
              backgroundImage: NetworkImage(
                  doctorProfileController.doctorProfileModel.profile),
            ),
          ),
          Flexible(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: Get.height * .02,
                      left: 15,
                    ),
                    child: AutoSizeText(
                      "دکتر " +
                          doctorProfileController.doctorProfileModel.fullName,
                      maxFontSize: 24,
                      minFontSize: 6,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: Get.height * .015,
                        right: Get.height * .02,
                        left: 15),
                    child: AutoSizeText(
                      doctorProfileController.doctorProfileModel.clinic.name,
                      maxFontSize: 24,
                      minFontSize: 6,
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildBodyDoctor() {
    return ConstrainedBox(
      //  fit: FlexFit.loose,
      constraints: BoxConstraints(
        maxHeight: Get.height,
        minHeight: Get.height * .3,
        maxWidth: Get.width,
      ),
      child: Container(
        padding: EdgeInsets.all(Get.width * .025),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              spreadRadius: 2,
              blurRadius: 5,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AutoSizeText(
              ":بیوگرافی",
              maxFontSize: 24,
              minFontSize: 6,
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: Get.height * .01,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: Get.width * .02),
              child: AutoSizeText(
                doctorProfileController.doctorProfileModel.bio,
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: null,
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildClinicName() {
    return Container(
      height: Get.height * .12,
      width: Get.width,
      padding: EdgeInsets.all(Get.width * .025),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AutoSizeText(
            ":کلینیک ها",
            maxFontSize: 24,
            minFontSize: 6,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: Get.height * .015,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              AutoSizeText(
                doctorProfileController.doctorProfileModel.clinic.name,
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: 1,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _buildExpertiseName() {
    return Container(
      height: Get.height * .12,
      width: Get.width,
      padding: EdgeInsets.all(Get.width * .025),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          AutoSizeText(
            ":تخصص ها",
            maxFontSize: 24,
            minFontSize: 6,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: Get.height * .015,
          ),
          Expanded(
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount:
                    doctorProfileController.doctorProfileModel.expertise.length,
                itemBuilder: expertiseBuilder),
          ),
        ],
      ),
    );
  }

  Widget expertiseBuilder(BuildContext context, int index) {
    var item = doctorProfileController.doctorProfileModel.expertise[index];
    return Container(
      height: Get.height * .05,
      width: Get.width,
      padding: EdgeInsets.only(right: Get.width * .12),
      child: AutoSizeText(
        item.title,
        maxFontSize: 24,
        minFontSize: 6,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 16,
        ),
      ),
    );
  }
}
