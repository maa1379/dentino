import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/controllers/MainController.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ComplimentCreateScreen extends StatelessWidget {

  ComplimentCreate complimentCreate = Get.put(ComplimentCreate());

  TextEditingController answerTextEditingController = TextEditingController();

  final RoundedLoadingButtonController btnController2 =
      RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "ثبت شکایت",
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: Get.height * .2,
            ),
            _messageTextField(),
            Spacer(),
            _submitBtn(),
            SizedBox(
              height: Get.height * .05,
            )
          ],
        ),
      ),
    );
  }

  Widget _messageTextField() {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: Get.height * .4,
          maxWidth: Get.width,
          minHeight: Get.height * .2),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
        child: TextField(
          keyboardType: TextInputType.multiline,
          maxLines: null,
          textDirection: TextDirection.rtl,
          controller: answerTextEditingController,
          maxLength: 500,
          minLines: 1,
          decoration: InputDecoration(
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white.withOpacity(.40)),
              borderRadius: BorderRadius.circular(30),
            ),
            labelText: "متن شکایت خود را بنویسید",
            hintText: "متن شکایت",
            // contentPadding: EdgeInsets.all(size.width * .03),
            labelStyle: TextStyle(
              fontSize: 12,
              color: Colors.black.withOpacity(.40),
            ),
            counter: Offstage(),
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(.40)),
              borderRadius: const BorderRadius.all(
                const Radius.circular(30.0),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey.withOpacity(.40),
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.withOpacity(.40)),
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            hintStyle:
                TextStyle(fontSize: 12, color: Colors.grey.withOpacity(.20)),
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  _submitBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
      child: RoundedLoadingButton(
          height: Get.height * .055,
          width: Get.width,
          successColor: Color(0xff077F7F),
          color: Colors.blue,
          child: AutoSizeText(
            "ورود",
            maxLines: 1,
            maxFontSize: 22,
            minFontSize: 10,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          controller: btnController2,
          animateOnTap: true,
          resetAfterDuration: true,
          resetDuration: Duration(seconds: 2),
          onPressed: () {
            complimentCreate.compliment(text: answerTextEditingController.text);
          }),
    );
  }
}
