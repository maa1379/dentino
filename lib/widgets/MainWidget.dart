import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dentino/controllers/MainController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/models/CategoryModel.dart';
import 'package:dentino/screen/ClinicListScreen.dart';
import 'package:dentino/screen/CommonCourseScreen.dart';
import 'package:dentino/screen/CostEstimationScreen.dart';
import 'package:dentino/screen/InsuranceCompaniesScreen.dart';
import 'package:dentino/screen/OrganizationScreen.dart';
import 'package:dentino/screen/PrescriptionsScreen.dart';
import 'package:dentino/screen/ServicesScreen.dart';
import 'package:dentino/screen/ShopScreen.dart';
import 'package:dentino/screen/WalletScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:url_launcher/url_launcher.dart';

class MainWidget extends StatefulWidget {
  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  Size size;

  _launchURL(url) async {
    await launch(url);
  }

  CarouselController buttonCarouselController = CarouselController();
  int _current = 0;
  final sliderController = Get.put(SliderController());


  List<CategoryModel> catItem = [
    CategoryModel(
        id: 1,
        image: "assets/images/reserved.png",
        title: "رزرو نوبت",
        func: ServicesScreen(),
    ),
    CategoryModel(
      id: 2,
      image: "assets/images/wallet.png",
      title: "کیف پول",
      func: WalletScreen(),
    ),
    CategoryModel(
      id: 3,
      image: "assets/images/dental-clinic.png",
      title: "کلینیک ها",
      func: ClinicListScreen(),
    ),
    CategoryModel(
        // func: ReserveScreen(),
        id: 4,
        image: "assets/images/nsokhe.png",
        func: CommonCourseScreen(),
        title: "آموزش های عمومی"),
    CategoryModel(
      id: 5,
      image: "assets/images/phyrmacy.png",
      title: "دنتینو شاپ",
      func: Shopscreen(),
    ),
    CategoryModel(
      id: 6,
      image: "assets/images/amozesh1.png",
      title: "نسخه های رایج",
      func: PrescriptionsScreen(),
    ),
    CategoryModel(
        id: 7, image: "assets/images/amozesh2.png", title: "دوره های آموزشی"),
    CategoryModel(
      id: 8,
      image: "assets/images/sazman.png",
      title: "سازمان های طرف قرارداد",
      func: OrganizationScreen(),
    ),
    CategoryModel(
      id: 9,
      image: "assets/images/bime.png",
      title: "شرکت های بیمه",
      func: InsuranceCompaniesScreen(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: size.height * .01,
              ),
              _buildTopSlider(),
              SizedBox(
                height: size.height * .05,
              ),
              Container(
                height: size.height * .8,
                width: size.width,
                margin: EdgeInsets.symmetric(horizontal: size.width * .05),
                padding: EdgeInsets.all(size.width * .03),
                decoration: BoxDecoration(
                    color: ColorsHelper.mainColor.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black38,
                        spreadRadius: 2,
                        blurRadius: 8,
                      ),
                    ]),
                child: _buildCategory(),
              ),
              SizedBox(
                height: size.height * .015,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildTopSlider() {
    return Container(
      height: size.height * .28,
      width: size.width,
      margin: EdgeInsets.only(
        top: size.height * .02,
      ),
      child: Column(
        children: [
          Container(
            height: size.height * .25,
            width: size.width,
            child: CarouselSlider(
              items: sliderController.sliderList.map((i) {
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
                          "https://dentino.app" + i.picture,
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
                autoPlay: true,
                reverse: false,
                enableInfiniteScroll: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(milliseconds: 2000),
                scrollDirection: Axis.horizontal,
                pageSnapping: true,
                height: size.width,
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
            height: size.height * .02,
          ),
          AnimatedSmoothIndicator(
            activeIndex: _current,
            onDotClicked: (value) {
              setState(() {
                _current = value;
              });
            },
            count: sliderController.sliderList.length,
            effect: ExpandingDotsEffect(
                activeDotColor: ColorsHelper.mainColor,
                dotWidth: size.width * .016,
                dotHeight: size.height * .008),
          ),
        ],
      ),
    );
  }

  _buildCategory() {
    return Padding(
      padding: EdgeInsets.only(top: size.height * .015),
      child: StaggeredGridView.countBuilder(
        crossAxisCount: 4,
        itemCount: catItem.length,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: itemBuilder,
        staggeredTileBuilder: (int index) {
          if (catItem.length % 2 != 0 && catItem.length - 5 == index) {
            return new StaggeredTile.count(4, 1.5);
          }
          return new StaggeredTile.count(2, 1.5);
        },
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    var item = catItem[index];
    return GestureDetector(
      onTap: () {
        if(item.id == 7){
          ViewHelper.showSuccessDialog(context, "تا چند لحظه دیگر به سایت دوره ها منتقل میشوید");
          Future.delayed(Duration(seconds: 5)).then((value) {
          _launchURL("https://parsianedu.com/");
          });
        }else{
        Get.to(item.func,);
        }

      },
      child: Container(
        height: size.height * .2,
        width: size.width * .45,
        padding: EdgeInsets.all(5),
        child: Container(
          height: size.height * .13,
          width: size.width * .35,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 2,
                blurRadius: 8,
              )
            ],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Stack(
            children: [
              (item.id == 5)
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        height: size.height * .0225,
                        width: size.width * .15,
                        margin: EdgeInsets.all(size.width * .03),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 2,
                                blurRadius: 5,
                              ),
                            ]),
                        child: Center(
                          child: AutoSizeText(
                            "ویژه کلینیک ها",
                            maxFontSize: 24,
                            minFontSize: 6,
                            maxLines: 1,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 8,
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Image.asset(item.image),
                    ),
                    SizedBox(
                      height: size.height * .01,
                    ),
                    Flexible(
                      flex: 1,
                      child: AutoSizeText(
                        item.title,
                        maxFontSize: 24,
                        minFontSize: 12,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
