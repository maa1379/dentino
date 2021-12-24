import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/helpers/ViewHelpers.dart';
import 'package:dentino/helpers/prefHelper.dart';
import 'package:dentino/models/ContactUsModel.dart';
import 'package:get/get.dart';

class ContactUSController extends GetxController {
  ContactUsModel contactUsModel;
  getContactUs() async {
    RequestHelper.contactUs().then(
      (value) {
        if(value.isDone){
          contactUsModel= ContactUsModel.fromJson(value.data);
        }else{
          print("faild");
        }
        update();
      },
    );
  }

  @override
  void onReady() {
    getContactUs();
    super.onReady();
  }

}


class AboutUSController extends GetxController {

  AboutUsModel aboutUsModel;
  getAboutUs() async {
    RequestHelper.aboutUs().then(
          (value) {
        if(value.isDone){
          aboutUsModel = AboutUsModel.fromJson(value.data);
          print(aboutUsModel);
        }else{
          print("faild");
        }

        update();
      },
    );
  }




  @override
  void onReady() {
    getAboutUs();
    super.onReady();
  }

}


class SliderController extends GetxController {
  RxList<SliderModel> sliderList = <SliderModel>[].obs;


  getSlider() async {
    RequestHelper.slider().then(
          (value) {
        print(value.data);
        for (var i in value.data) {
          sliderList.add(SliderModel.fromJson(i));
        }
        update();
      },
    );
  }

}


// class InsuranceController extends GetxController {
//   RxList<SliderModel> sliderList = <SliderModel>[].obs;
//
//
//   getSlider() async {
//     RequestHelper.insurance().then(
//           (value) {
//         print(value.data);
//         for (var i in value.data) {
//           sliderList.add(SliderModel.fromJson(i));
//         }
//       },
//     );
//   }
//
//   @override
//   void onReady() {
//     getSlider();
//     super.onReady();
//   }
//
// }


class ComplimentCreate extends GetxController{

  compliment({String text})async{
    RequestHelper.complimentCreate(text: text,token: await PrefHelper.getToken()).then((value){
      if(value.isDone){
        ViewHelper.showSuccessDialog(Get.context, "پیام شما با موفقیت ثبت شد");
      }else{
        ViewHelper.showErrorDialog(Get.context,"ارتباط برقرار نشد");
      }
    });
  }


}

