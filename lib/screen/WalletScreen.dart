import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dentino/helpers/ColorHelpers.dart';
import 'package:dentino/helpers/widgetHelper.dart';
import 'package:dentino/models/IncreaseWalletAmountModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class WalletScreen extends StatefulWidget {
  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  Size size;
  List<IncreaseWalletAmountModel> increaseWalletAmountList = [
    IncreaseWalletAmountModel(
      selected: false,
      id: 1,
      title: "تومان",
      fo: FlutterMoneyFormatter(amount: 1000000),
    ),
    IncreaseWalletAmountModel(
      selected: false,
      id: 2,
      title: "تومان",
      fo: FlutterMoneyFormatter(amount: 2000000),
    ),
    IncreaseWalletAmountModel(
      selected: false,
      id: 3,
      title: "تومان",
      fo: FlutterMoneyFormatter(amount: 5000000),
    ),
    IncreaseWalletAmountModel(
      selected: false,
      id: 4,
      title: "تومان",
      fo: FlutterMoneyFormatter(amount: 10000000),
    )
  ];


  TextEditingController priceTextController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final RoundedLoadingButtonController _btnController1 =
      RoundedLoadingButtonController();

  void _Submited(RoundedLoadingButtonController controller) async {
    Timer(Duration(seconds: 3), () {
      controller.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.white,
        title: AutoSizeText(
          "کیف پول",
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
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          margin: EdgeInsets.symmetric(vertical: size.height * .05),
          child: Column(
            children: [
              _buildInstallments(),
              SizedBox(height: size.height * .08,),
              _buildAmountField(),
              _increaseWalletAmountBtn(),
              Spacer(),
              _submitFilterBtn(),
            ],
          ),
        ),
      ),
    );
  }

  _buildAmountField() {
    return WidgetHelper.profileTextField(
      width: size.width,
      height: size.height * .07,
      color: Colors.transparent,
      fontSize: 12,
      hintText: "مقدار اعتبار را وارد کنید",
      enabled: true,
      text: "مقدار اعتبار",
      onChange: (value) {
        // WidgetHelper.onChange(value, mobileController);
      },
      controller: priceTextController,
      // errorText: "شماره موبایل خود را وارد کنید!",
      size: size,
      maxLine: 1,
      maxLength: 120,
      icon: Icon(Icons.mobile_friendly_rounded),
      obscureText: false,
      keyBoardType: TextInputType.text,
      margin: EdgeInsets.symmetric(horizontal: size.width * .1),
    );
  }

  _submitFilterBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .05),
      child: RoundedLoadingButton(
        height: size.height * .055,
        width: size.width,
        successColor: Color(0xff077F7F),
        color: Colors.blue,
        child: AutoSizeText(
          "شارژ کیف پول",
          maxLines: 1,
          maxFontSize: 22,
          minFontSize: 10,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        controller: _btnController1,
        animateOnTap: true,
        onPressed: () => _Submited(_btnController1),
      ),
    );
  }

  Widget _increaseWalletAmountBtn() {
    return Container(
      height: size.height * .25,
      width: size.width,
      padding: EdgeInsets.symmetric(
          horizontal: size.height * .04, vertical: size.height * .05),
      child: GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20),
          // physics: NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return _buildItem(item: increaseWalletAmountList[index]);
          }),
    );
  }

  Widget _buildItem({IncreaseWalletAmountModel item}) {
    return WidgetHelper.BtnHelper(
      color: (item.selected) ? ColorsHelper.mainColor : Colors.white,
      width: 0,
      height: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AutoSizeText(
            item.fo.output.withoutFractionDigits,
            style: TextStyle(
                color: (item.selected) ? Colors.white : ColorsHelper.mainColor,
                fontSize: 14),
            minFontSize: 8,
            maxFontSize: 22,
          ),
          SizedBox(
            width: size.width * .02,
          ),
          AutoSizeText(
            item.title,
            style: TextStyle(
                color: (item.selected) ? Colors.white : ColorsHelper.mainColor,
                fontSize: 14),
            minFontSize: 8,
            maxFontSize: 22,
          )
        ],
      ),
      elevation: 0,
      size: size,
      borderColor: Colors.grey,
      borderWidth: 0.0,
      radius: 24.0,
      shadowColor: Colors.transparent,
      blurRadius: 0,
      spreadRadius: 0,
      func: () {
        increaseWalletAmountList.forEach((element) {
          setState(() {
            element.selected = false;
          });
        });
        setState(
          () {
            item.selected = true;
            priceTextController.text =
                item.fo.output.withoutFractionDigits.toString();
          },
        );
      },
    );
  }

  _buildInstallments() {
    return Container(
      height: size.height* .25,
      width: size.width,
      margin: EdgeInsets.symmetric(horizontal: size.width * .05),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ]
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset("assets/images/Installment.jpg",fit: BoxFit.cover,)),
    );
  }
}
