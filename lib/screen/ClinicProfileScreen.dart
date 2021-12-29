import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dentino/controllers/ClinicController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

class ClinicProfileScreen extends StatefulWidget {
  @override
  _ClinicProfileScreenState createState() => _ClinicProfileScreenState();
}

class _ClinicProfileScreenState extends State<ClinicProfileScreen> {
  final clinicController = Get.put(ProfileClinicController());
  int _current = 0;
  CarouselController buttonCarouselController = CarouselController();

  _launchURL(url) async {
    await launch(url);
  }



  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(clinicController.loading == true){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 5,
            backgroundColor: Colors.white,
            title: AutoSizeText(
              "پروفایل کلینیک",
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
      }else{
        return Align(
          alignment: Alignment.center,
          child: Container(
            height: Get.height * .08,
            width: Get.width * .15,
            child: CircularProgressIndicator(),
          ),
        );
      }

    });
  }

  _buildBody() {
    return Container(
      height: Get.height,
      width: Get.width,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildTopSlider(),
            SizedBox(
              height: Get.height * .03,
            ),
            _buildTitle(),
            SizedBox(
              height: Get.height * .03,
            ),
            _buildDescription(),
            SizedBox(
              height: Get.height * .03,
            ),
            _buildAddress(),
            SizedBox(
              height: Get.height * .03,
            ),
            _buildCompany(),
            SizedBox(
              height: Get.height * .03,
            ),
            _buildInsurance(),
            SizedBox(
              height: Get.height * .03,
            ),
            _buildNetWork(),
            SizedBox(
              height: Get.height * .05,
            ),
          ],
        ),
      ),
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
              items: clinicController.images.map((i) {
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
                          fit: BoxFit.cover,
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
                autoPlay: true,
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
            count: clinicController.images.length,
            effect: ExpandingDotsEffect(
                activeDotColor: ColorsHelper.mainColor,
                dotWidth: Get.width * .016,
                dotHeight: Get.height * .008),
          ),
        ],
      ),
    );
  }

  _buildTitle() {
    return Container(
      height: Get.height * .12,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, spreadRadius: 2, blurRadius: 5),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: Get.height * .08,
            width: Get.width * .22,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(clinicController.clinicProfile.logo),
                // fit: BoxFit.cover
              ),
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, spreadRadius: 2, blurRadius: 5),
              ],
            ),
          ),
          AutoSizeText(
            "${clinicController.clinicProfile.name}",
            maxFontSize: 24,
            minFontSize: 6,
            maxLines: 1,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  _buildDescription() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(right: Get.width * .08),
            child: AutoSizeText(
              "درباره کلینیک:",
              maxFontSize: 24,
              minFontSize: 6,
              textDirection: TextDirection.rtl,
              maxLines: null,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: ColorsHelper.mainColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(
          height: Get.height * .02,
        ),
        ConstrainedBox(
          //  fit: FlexFit.loose,
          constraints: BoxConstraints(
            maxHeight: Get.height,
            minWidth: Get.width,
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
                BoxShadow(
                    color: Colors.black26, spreadRadius: 2, blurRadius: 5),
              ],
            ),
            child: AutoSizeText(
              clinicController.clinicProfile.clinicDescription
                  .replaceAll("</p>", "")
                  .replaceAll("<p>", ""),
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
        ),
      ],
    );
  }

  _buildAddress() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(right: Get.width * .08),
            child: AutoSizeText(
              "آدرس کلینیک:",
              maxFontSize: 24,
              minFontSize: 6,
              textDirection: TextDirection.rtl,
              maxLines: null,
              textAlign: TextAlign.justify,
              style: TextStyle(
                color: ColorsHelper.mainColor,
                fontSize: 16,
              ),
            ),
          ),
        ),
        SizedBox(
          height: Get.height * .02,
        ),
        ConstrainedBox(
          //  fit: FlexFit.loose,
          constraints: BoxConstraints(
            maxHeight: Get.height,
            minHeight: Get.height * .1,
            maxWidth: Get.width,
          ),
          child: Container(
            height: Get.height * .15,
            width: Get.width,
            margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
            padding: EdgeInsets.symmetric(
                horizontal: Get.width * .05, vertical: Get.height * .02),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26, spreadRadius: 2, blurRadius: 5),
              ],
            ),
            child: Center(
              child: AutoSizeText(
                "${clinicController.clinicProfile.address}",
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: null,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }


  _buildCompany() {
    return
      Directionality(
        textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: Get.width * .08),
              child: AutoSizeText(
                "سازمان های طرف قرارداد:",
                maxFontSize: 24,
                minFontSize: 6,
                textDirection: TextDirection.rtl,
                maxLines: null,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: ColorsHelper.mainColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * .02,
          ),
          ConstrainedBox(
            //  fit: FlexFit.loose,
            constraints: BoxConstraints(
              maxHeight: Get.height,
              minHeight: Get.height * .1,
              maxWidth: Get.width,
            ),
            child: Container(
              height: Get.height * .15,
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .05, vertical: Get.height * .02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, spreadRadius: 2, blurRadius: 5),
                ],
              ),
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: clinicController.CompanyList.length,
                  itemBuilder: (BuildContext context , int index) {
                    return AutoSizeText(
                      "${clinicController.CompanyList[index].title}",
                      maxFontSize: 24,
                      minFontSize: 6,
                      maxLines: null,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    );
                  }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildInsurance() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(right: Get.width * .08),
              child: AutoSizeText(
                "شرکت های بیمه:",
                maxFontSize: 24,
                minFontSize: 6,
                textDirection: TextDirection.rtl,
                maxLines: null,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: ColorsHelper.mainColor,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * .02,
          ),
          ConstrainedBox(
            //  fit: FlexFit.loose,
            constraints: BoxConstraints(
              maxHeight: Get.height,
              minHeight: Get.height * .1,
              maxWidth: Get.width,
            ),
            child: Container(
              height: Get.height * .15,
              width: Get.width,
              margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
              padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .05, vertical: Get.height * .02),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black26, spreadRadius: 2, blurRadius: 5),
                ],
              ),
              child: Center(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                    itemCount: clinicController.InsuranceList.length,
                    itemBuilder: (BuildContext context , int index) {
                      return AutoSizeText(
                        "${clinicController.InsuranceList[index].name}",
                        maxFontSize: 24,
                        minFontSize: 6,
                        maxLines: null,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                        ),
                      );
                    }
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildNetWork() {
    return Container(
      height: Get.height * .15,
      width: Get.width,
      margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            flex: 1,
            child: Container(
              height: Get.height * .15,

              width: Get.width * .3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 5),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/1024px-Telegram_logo.svg.png",width: Get.width * .12,),
              AutoSizeText(
                "تلگرام ما",
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: null,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
                ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: Get.width * .02,
          ),
          Flexible(
            flex: 1,
            child: GestureDetector(
              onTap: (){
                _launchURL(clinicController.clinicProfile.instagram);
              },
              child: Container(
                height: Get.height * .15,
                width: Get.width * .3,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12, spreadRadius: 2, blurRadius: 5),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("assets/images/Instagram_logo_2016.svg.png",width: Get.width * .12,),
                    AutoSizeText(
                      "اینستاگرام ما",
                      maxFontSize: 24,
                      minFontSize: 6,
                      maxLines: null,
                      textDirection: TextDirection.rtl,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            width: Get.width * .02,
          ),
          Flexible(
            flex: 1,
            child: Container(
              height: Get.height * .15,
              width: Get.width * .3,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black12, spreadRadius: 2, blurRadius: 5),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/images/unnamed (1).png",width: Get.width * .14,),
              AutoSizeText(
                "واتس اپ ما",
                maxFontSize: 24,
                minFontSize: 6,
                maxLines: null,
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                ),
                ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
