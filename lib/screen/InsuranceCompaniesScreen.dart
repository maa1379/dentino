import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';





class InsuranceCompaniesScreen extends StatelessWidget {
  Size size;

  List logo = [
    "assets/images/bimeLogo/5701655d1a4d38cfa31e598d8232473e.jpg",
    "assets/images/bimeLogo/bime1.jpg",
    "assets/images/bimeLogo/Pasargad.jpg",
    "assets/images/bimeLogo/saman.png",
    "assets/images/bimeLogo/unnamed.png",
    "assets/images/bimeLogo/بیمه_کارآفرین.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "شرکت های بیمه",
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
      body: Container(
        height: size.height,
        width: size.width,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          children: [
            SizedBox(
              height: size.height * .05,
            ),
            _buildGridView(),
          ],
        ),
      ),
    );
  }

  _buildGridView() {
    return Expanded(
      child: AnimationLimiter(
        child: GridView.builder(
          itemCount: logo.length,
          physics: BouncingScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, childAspectRatio: 1),
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      columnCount: 2,
      duration: const Duration(milliseconds: 500),
      child: ScaleAnimation(
        child: FadeInAnimation(
          child: Container(
            height: size.height * .15,
            width: size.width * .3,
            padding: EdgeInsets.all(size.width * .02),
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 5,
              )
            ]),
            margin: EdgeInsets.symmetric(
                horizontal: size.width * .02, vertical: size.height * .01),
            child: Image.asset(logo[index]),
          ),
        ),
      ),
    );
  }
}

