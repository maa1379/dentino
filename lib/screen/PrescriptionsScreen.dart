import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/PrescriptionsController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/models/PrescriptionsModel.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';

class PrescriptionsScreen extends StatelessWidget {

  final prescriptionsController = Get.put(PrescriptionsController());

  String _parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString = parse(document.body.text).documentElement.text;

    return parsedString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "نسخه های رایج",
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
        height: Get.height,
        width: Get.width,
        child: _buildList(),
      ),

    );
  }

  _buildList() {
    return ListView.builder(
        itemCount: prescriptionsController.prescriptionsList.length,
        physics: BouncingScrollPhysics(),
        itemBuilder: itemBuilder);
  }

  Widget itemBuilder(BuildContext context, int index) {
    return _buildCategoryDetail(prescriptionsController.prescriptionsList[index]);
  }

  _buildCategoryDetail(PrescriptionsModel item) {
    return Container(
      width: Get.width,
      margin: EdgeInsets.only(top: Get.height * .03),
      child: Column(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: ExpandableNotifier(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Get.width * .05, vertical: Get.height * .02),
                child: Card(
                  elevation: 3,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: <Widget>[
                      Container(
                          height: Get.height * .2,
                          width: Get.width,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(15),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(item.image),
                            )
                          ),
                          margin: EdgeInsets.symmetric(horizontal: Get.width * .05,vertical: Get.height * .02),
                      ),
                      ScrollOnExpand(
                        scrollOnExpand: true,
                        scrollOnCollapse: false,
                        child: ExpandablePanel(
                          collapsed: Text(
                            _parseHtmlString(item.description),
                            softWrap: true,
                            maxLines: 4,
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.ellipsis,
                          ),
                          theme: const ExpandableThemeData(
                            headerAlignment:
                            ExpandablePanelHeaderAlignment.center,
                            tapBodyToCollapse: true,
                          ),
                          header: Padding(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              item.title,
                              style: Theme.of(Get.context).textTheme.bodyText2,
                            ),
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: Get.height * .02,),
                              for (var _ in Iterable.generate(1))
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10),
                                  child: Text(
                                    _parseHtmlString(item.description),
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                            ],
                          ),
                          builder: (_, collapsed, expanded) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 10),
                              child: Expandable(
                                collapsed: collapsed,
                                expanded: expanded,
                                theme:
                                const ExpandableThemeData(crossFadePoint: 0),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
