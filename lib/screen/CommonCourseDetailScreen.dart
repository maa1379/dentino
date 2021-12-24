import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/CommonCourseController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class CommonCourseDetailScreen extends StatefulWidget {
  @override
  _CommonCourseDetailScreenState createState() =>
      _CommonCourseDetailScreenState();
}

class _CommonCourseDetailScreenState extends State<CommonCourseDetailScreen> {
  final commonCourseController = Get.put(CommonCourseDetailController());

  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://dentino.app/media/common_course/video/16197165-732685233.mp4',
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
    );
    _controller.play();
    _controller.addListener(() {
      setState(() {});
    });
    _controller.setLooping(true);
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (commonCourseController.loading == true) {
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
      } else {
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
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          VideoPlayer(_controller),
          ClosedCaption(text: _controller.value.caption.text),
          _ControlsOverlay(controller: _controller),
          VideoProgressIndicator(_controller, allowScrubbing: true),
        ],
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

class _ControlsOverlay extends StatelessWidget {
  const _ControlsOverlay({this.controller});

  static const _examplePlaybackRates = [
    0.25,
    0.5,
    1.0,
    1.5,
    2.0,
    3.0,
    5.0,
    10.0,
  ];

  final VideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: Duration(milliseconds: 50),
          reverseDuration: Duration(milliseconds: 200),
          child: controller.value.isPlaying
              ? SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: Center(
                    child: Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller.value.isPlaying ? controller.pause() : controller.play();
          },
        ),
        Align(
          alignment: Alignment.topRight,
          child: PopupMenuButton<double>(
            initialValue: controller.value.playbackSpeed,
            tooltip: 'Playback speed',
            onSelected: (speed) {
              controller.setPlaybackSpeed(speed);
            },
            itemBuilder: (context) {
              return [
                for (final speed in _examplePlaybackRates)
                  PopupMenuItem(
                    value: speed,
                    child: Text('${speed}x'),
                  )
              ];
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(
                // Using less vertical padding as the text is also longer
                // horizontally, so it feels like it would need more spacing
                // horizontally (matching the aspect ratio of the video).
                vertical: 12,
                horizontal: 16,
              ),
              child: Text('${controller.value.playbackSpeed}x'),
            ),
          ),
        ),
      ],
    );
  }
}
