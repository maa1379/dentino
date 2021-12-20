import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/CommonCourseController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';



class CommonCourseDetailScreen extends StatefulWidget {

  @override
  _CommonCourseDetailScreenState createState() => _CommonCourseDetailScreenState();
}

class _CommonCourseDetailScreenState extends State<CommonCourseDetailScreen> {
  final commonCourseController = Get.put(CommonCourseDetailController());

  TargetPlatform _platform;

  VideoPlayerController _videoPlayerController1;


  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController1 = VideoPlayerController.network(
        'https://dentino-app.darkube.app/media/common_course/video/2_1.mp4'
    );
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 2 / 1,
      autoPlay: true,
      looping: true,
      showControls: true,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.red,
        handleColor: Colors.blue,
        backgroundColor: Colors.grey,
        bufferedColor: Colors.lightGreen,
      ),
      placeholder: Container(
        color: Colors.white,
        width: Get.width,
      ),
      autoInitialize: true,
    );

    _videoPlayerController1.addListener(() {
      if (_videoPlayerController1.value.position ==
          _videoPlayerController1.value.duration) {
        print('video Ended');
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _chewieController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Obx((){
      if(commonCourseController.loading == true){
        return Scaffold(
          appBar: AppBar(
            elevation: 5,
            backgroundColor: Colors.white,
            title: AutoSizeText(
              commonCourseController.commonCourseList.title,
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
    return Obx(
          () {
        if (!commonCourseController.loading.value) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              height: Get.height * .08,
              width: Get.width * .15,
              child: CircularProgressIndicator(),
            ),
          );
        }
          return _buildItem();
      },
    );
  }

  _buildItem() {
    return Container(
      height: Get.height,
      width: Get.width,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildVideoPlayer(),
            SizedBox(
              height: Get.height * .05,
            ),
            _buildDescription(),
            SizedBox(
              height: Get.height * .05,
            ),
            _buildAddress()
          ],
        ),
      ),
    );
  }

  _buildVideoPlayer() {
    return Container(
      height: Get.height * .25,
      width: Get.width,
      margin: EdgeInsets.only(top: Get.height * .03),
      child: Chewie(
        controller: _chewieController,
      ),

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
              "منبع:",
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
            minHeight: Get.height * .08,
            maxWidth: Get.width,
          ),
          child: Container(
            height: Get.height * .08,
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
                "${commonCourseController.commonCourseList.source}",
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


  _buildDescription() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: EdgeInsets.only(right: Get.width * .08),
            child: AutoSizeText(
              "توضیحات:",
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
              commonCourseController.commonCourseList.description
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
}
