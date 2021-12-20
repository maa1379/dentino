import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'LoginScreen.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  Size size;
  int _selectedIndex = 0;
  LiquidController liquidController;

  List page = [
    "assets/anim/1.json",
    "assets/anim/2.json",
    "assets/anim/3.json",
  ];
  bool revers = false;

  @override
  void initState() {
    liquidController = LiquidController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Container(
        height: size.height,
        width: size.width,
        child: Stack(
          children: [
            _buildSlider(),
            _buildIndicator(),
            (_selectedIndex == 2) ? Container() :_buildSkipButton(),
            (_selectedIndex != 2) ? Container() : _buildNextButton(),
          ],
        ));
  }

  _buildSlider() {
    return PageView.builder(
      reverse: false,
      onPageChanged: (page) {
        if (page == 5) {
          setState(() {
            revers = true;
          });
        }
        setState(
          () {
            _selectedIndex = page;
          },
        );
      },
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return _buildPage(path: page[index]);
      },
    );
  }

  _buildSkipButton() {
    return Padding(
      padding:
          EdgeInsets.only(bottom: size.height * .045, left: size.width * .08),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              PageTransition(
                type: PageTransitionType.topToBottom,
                duration: Duration(milliseconds: 500),
                curve: Curves.easeInOutCubic,
                child: LoginScreen(),
              ),
            );
          },
          child: AutoSizeText(
            "رد کردن",
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
      ),
    );
  }

  Widget _buildPage({String path}) {
    return Container(
      height: size.height,
      width: size.width,
      child: Column(
        children: [
          SizedBox(
            height: size.height * .1,
          ),
          Lottie.asset(path),
          Spacer(),
          Container(
            height: size.height * .35,
            width: size.width,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  spreadRadius: 2,
                  offset: Offset(5,0)
                ),
              ],
              color: ColorsHelper.mainColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * .05,
                ),
                AutoSizeText(
                  "دندان پزشکی",
                  maxFontSize: 22,
                  minFontSize: 10,
                  maxLines: 1,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: size.height * .05,
                ),
                AutoSizeText(
                  "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ، و با استفاده از طراحان گرافیک است، چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است، و برای شرایط فعلی تکنولوژی مورد نیاز، و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد",
                  maxFontSize: 22,
                  minFontSize: 10,
                  maxLines: 5,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildNextButton() {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          PageTransition(
            type: PageTransitionType.topToBottom,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOutCubic,
            child: LoginScreen(),
          ),
        );
      },
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: EdgeInsets.only(bottom: size.height * .04),
          height: size.height * .05,
          width: size.width * .25,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  bottomLeft: Radius.circular(50))),
          child: Center(
            child: AutoSizeText(
              "ورود",
              maxLines: 1,
              maxFontSize: 22,
              minFontSize: 10,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }

  _buildIndicator() {
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * .05),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: AnimatedSmoothIndicator(
          activeIndex: _selectedIndex,
          onDotClicked: (value) {
            setState(() {
              _selectedIndex = value;
            });
            liquidController.jumpToPage(page: _selectedIndex);
          },
          count: page.length,
          effect: ExpandingDotsEffect(
              activeDotColor: Colors.white,
              dotColor: Colors.black.withOpacity(0.5),
              dotWidth: size.width * .016,
              dotHeight: size.height * .008),
        ),
      ),
    );
  }
}
