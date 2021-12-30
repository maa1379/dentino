import 'package:dentino/helpers/AlertHelper.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/widgets/DrawerWidget.dart';
import 'package:dentino/widgets/MainWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:get/get.dart';
import 'MyTurnScreen.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController(initialPage: 1);
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  ShapeBorder bottomBarShape = const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  );
  SnakeBarBehaviour snakeBarStyle = SnakeBarBehaviour.floating;
  EdgeInsets padding = const EdgeInsets.all(12);

  int _selectedItemPosition = 1;
  SnakeShape snakeShape = SnakeShape.circle;

  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;

  Color selectedColor = ColorsHelper.mainColor;
  Gradient selectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.amber]);

  Color unselectedColor = Colors.blueGrey;
  Gradient unselectedGradient =
      const LinearGradient(colors: [Colors.red, Colors.blueGrey]);

  //
  // @override
  // void initState() {
  //   SchedulerBinding.instance.addPostFrameCallback((_) {
  //     if (getProfileBlocInstance.profile.name == "") {
  //       AlertHelpers.UpdateProfileDialog(
  //           size: Get.size,
  //           context: Get.context,
  //           func: () {
  //             Get.back();
  //             NavHelper.push(context, ProfileScreen());
  //           },
  //           func2: () {
  //             Navigator.of(context).pop();
  //           });
  //     } else {
  //       print("profile ok***");
  //     }
  //   });
  //   super.initState();
  // }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => AlertHelpers.ExitDialog(context: Get.context,size: Get.size),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: _key,
        bottomNavigationBar: _buildNavbar(),
        endDrawer: DrawerWidget(),
        appBar: AppBar(
          title: (this._selectedItemPosition == 1)
              ? Text(
                  "Dentino",
                  style: TextStyle(color: ColorsHelper.mainColor),
                )
              : (this._selectedItemPosition == 0)
                  ? Text(
                      "لیست سفارشات",
                      style: TextStyle(color: ColorsHelper.mainColor),
                    )
                  : (this._selectedItemPosition == 2)
                      ? Text(
                          "نوبت های من",
                          style: TextStyle(color: ColorsHelper.mainColor),
                        )
                      : Container(),
          centerTitle: true,
          elevation: 5,
          backgroundColor: Colors.white,
          leading: Image.asset("assets/images/theesLogo.png"),
          actions: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: GestureDetector(
                onTap: () {
                  _key.currentState.openEndDrawer();
                },
                child: Icon(
                  Icons.menu,
                  color: ColorsHelper.mainColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: Container(
          height: Get.height,
          width: Get.width,
          color: Colors.white,
          child: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: pageController,
            onPageChanged: (page) {
              setState(() {
                _selectedItemPosition = page;
              });
            },
            children: [
              // ProfileWidget(),
              Container(),
              MainWidget(),
              MyTurnScreen(),
            ],
          ),
        ),
      ),
    );
  }

  _buildNavbar() {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SnakeNavigationBar.color(
        height: 55,
        behaviour: snakeBarStyle,
        snakeShape: snakeShape,
        shape: bottomBarShape,
        padding: padding,
        snakeViewColor: selectedColor,
        selectedItemColor:
            snakeShape == SnakeShape.indicator ? selectedColor : null,
        unselectedItemColor: Colors.blueGrey,
        showUnselectedLabels: showUnselectedLabels,
        showSelectedLabels: showSelectedLabels,
        backgroundColor: Colors.black12,
        currentIndex: _selectedItemPosition,
        onTap: (index) => setState(() {
          _selectedItemPosition = index;
          pageController.jumpToPage(index);
        }),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/user.png",
              width: Get.width * .075,
              color: _selectedItemPosition == 0 ? Colors.white : Colors.black,
            ),
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/home.png",
                width: Get.width * .075,
                color:
                    _selectedItemPosition == 1 ? Colors.white : Colors.black),
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/booking.png",
                width: Get.width * .075,
                color:
                    _selectedItemPosition == 2 ? Colors.white : Colors.black),
          ),
        ],
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 10),
      ),
    );
  }
}
