import 'package:dentino/helpers/RequestHelper.dart';
import 'package:dentino/models/CommonCourseModel.dart';
import 'package:get/get.dart';

class CommonCourseController extends GetxController{

  RxList<CommonCourseModel> commonCourseList = <CommonCourseModel> [].obs;


  getCommonCourseList()async{
    RequestHelper.commonCourseList().then((value){
      if(value.isDone) {
        for (var i in value.data) {
          commonCourseList.add(CommonCourseModel.fromJson(i));
        }
      }else{
          print("faild");
      }
    });
  }

  @override
  void onInit() {
    getCommonCourseList();
    super.onInit();
  }

}


class CommonCourseDetailController extends GetxController{

  RxBool loading = false.obs;

  CommonCourseModel commonCourseList;


  getCommonCourse()async{
    RequestHelper.getCommonCourse(id: Get.arguments["commonCourse_id"]).then((value){
      if(value.isDone) {
        commonCourseList = CommonCourseModel.fromJson(value.data);
        print(commonCourseList.video);
        loading.value = true;
      }else{
        loading.value = false;
        print("faild");
      }
    });
  }











  @override
  void onInit() {
    getCommonCourse();

    super.onInit();
  }


}