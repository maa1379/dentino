import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClubScreen extends StatefulWidget {
  @override
  _ClubScreenState createState() => _ClubScreenState();
}

class _ClubScreenState extends State<ClubScreen> {
  Size size;
  final List<String> images = [
    "assets/images/BaversCard.png",
    "assets/images/BaversCard.png",
    "assets/images/BaversCard.png",
  ];

  //
  // Future<void> _launchInBrowser(String url) async {
  //   if (await canLaunch(url)) {
  //     await launch(
  //       url,
  //       forceSafariVC: false,
  //       forceWebView: false,
  //     );
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  // List<NegaCardModel> negaCardList = [
  //   NegaCardModel(
  //     title: "نگاکارت طلایی",
  //     disCount: "90",
  //     id: 1,
  //     imagePath: "assets/images/gold.jpg",
  //     selected: false,
  //   ),
  //   NegaCardModel(
  //     title: "نگاکارت نقره ای",
  //     disCount: "75",
  //     id: 2,
  //     imagePath: "assets/images/gold.jpg",
  //     selected: false,
  //   ),
  //   NegaCardModel(
  //     title: "نگاکارت برنزی",
  //     disCount: "60",
  //     id: 3,
  //     imagePath: "assets/images/gold.jpg",
  //     selected: false,
  //   ),
  // ];

  double margin = 0.0;

  String description =
      "لورم ایپسوم متن ساختگی با تولید سادگی نامفهوم از صنعت چاپ و با استفاده از طراحان گرافیک است. چاپگرها و متون بلکه روزنامه و مجله در ستون و سطرآنچنان که لازم است و برای شرایط فعلی تکنولوژی مورد نیاز و کاربردهای متنوع با هدف بهبود ابزارهای کاربردی می باشد. کتابهای زیادی در شصت و سه درصد گذشته، حال و آینده شناخت فراوان جامعه و متخصصان را می طلبد";
  List<int> data = [1, 2, 3];
  int indexList = 0;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "باشگاه مشتریان",
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
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.,
            children: [
              SizedBox(
                height: size.height * .02,
              ),
              Container(
                alignment: Alignment.center,
                height: size.height / 4,
                width: size.width,
                child: PageView.builder(
                  controller: PageController(viewportFraction: 0.8),
                  itemCount: images.length,
                  physics: BouncingScrollPhysics(),
                  onPageChanged: (page) {
                    setState(() {
                      this.indexList = page;
                    });
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return new Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: this.indexList == index ? 16.0 : 40.0,
                        horizontal: 8.0,
                      ),
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 350),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: this.indexList == index
                                ? Colors.white
                                : Colors.transparent,
                            boxShadow: [
                              if (this.indexList == index)
                                BoxShadow(
                                  color: Colors.white,
                                  blurRadius: 5,
                                ),
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset(
                            images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: size.height * .02,
              ),
              (indexList == 1)
                  ? _buildBody(
                      disCount: "90",
                      description: this.description,
                      title: "دنتینو کارت طلایی",
                      price: 500000)
                  : (indexList == 2)
                      ? _buildBody(
                          disCount: "75",
                          description: this.description,
                          title: "دنتینو کارت نقره ای",
                          price: 350000)
                      : _buildBody(
                          disCount: "60",
                          description: this.description,
                          title: "دنتینو کارت برنزی",
                          price: 200000),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBody(
      {String title, String description, String disCount, double price}) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: size.height * .06,
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: size.width * .05),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: AutoSizeText(
            title,
            textAlign: TextAlign.center,
            maxLines: 1,
            minFontSize: 12,
            maxFontSize: 24,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        SizedBox(
          height: size.height * .06,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * .05),
          height: size.height * .06,
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: size.width * .05),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    "$disCount%",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 24,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  AutoSizeText(
                    ": درصد تخفیف",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 24,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: size.width * .05),
          height: size.height * .06,
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: size.width * .05),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    "50",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 24,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  AutoSizeText(
                    ": امتیاز شما",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 24,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * .05, vertical: size.height * .01),
          height: size.height * .21,
          width: size.width,
          margin: EdgeInsets.symmetric(horizontal: size.width * .05),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)
            ],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AutoSizeText(
                    ": درباره ${title}",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 24,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  SizedBox(
                    height: size.height * .01,
                  ),
                  AutoSizeText(
                    description,
                    textAlign: TextAlign.end,
                    maxLines: 10,
                    minFontSize: 12,
                    maxFontSize: 24,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: size.height * .02,
        ),
        // Spacer(),
        _buildEndBtn(),
        SizedBox(
          height: size.height * .01,
        ),
      ],
    );
  }

  Widget _buildEndBtn() {
    return GestureDetector(
      onTap: () {
        // chargeCredit();
      },
      child: Container(
        height: size.height * .055,
        width: size.width * .85,
        margin: EdgeInsets.symmetric(horizontal: size.width * .05),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)
          ],
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Center(
          child: AutoSizeText(
            "دریافت کارت",
            textAlign: TextAlign.center,
            maxLines: 1,
            minFontSize: 12,
            maxFontSize: 24,
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
