import 'dart:convert';

import 'package:http/http.dart' as http;

enum WebControllers {
  reservation,
  doctor,
  register,
  exertise,
  verify_user_register,
  date_list,
  time,
  reserve,
  update_profile,
  doctor_filter,
  filter_list,
  contact_us,
  about_us,
  slider,
  insurance,
  company,
  common_course,
  common_course_detail,
  get_profile,
  clinic_list,
  clinic_detail,
  Prescriptions,
  category_list,
  product_list,
  product_detail,
  AddToCart,
  ListCart,
  ClearCartItem,
  delete_cart,
  doctor_profile,
  reserve_list,
  compliment_create,
  order_create,
  bank,
  token,
  location,
  zone_list,
  city_list,
  province_list,
  clinic_doctor,
  reserve_delete,
  dict_category,
  doctordictionarylist,
  order_list,
  discount,
}
// enum WebMethods {
//
// }

class RequestHelper {
  static const String BaseUrl = 'https://dentino-app.darkube.app/';
  static const String ImageUrl = 'https://dentino.app/';

  static String imgUrl([String path = 'ProductGroups']) =>
      'https://new.negamarket.ir/admin/src/images/$path/';
  static const String ImageUrlForProducts =
      'https://new.negamarket.ir/admin/src/images/Products/';
  static const String token = 'test';

  static Future<ApiResult> _makeRequest({
    WebControllers webController,
    // WebMethods webMethod
    Map<String, String> header = const {},
    Map body = const {},
  }) async {
    String url = RequestHelper._makePath(
      webController,
    );
    print(
        "Request url: $url\nRequest body: ${jsonEncode(body)}\n ${jsonEncode(header)}\n");
    http.Response response =
        await http.post(Uri.parse(url), headers: header, body: body);
    ApiResult apiResult = new ApiResult();
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.statusCode = response.statusCode;
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
        apiResult.data2 = jsonDecode(response.body);
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        // apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else if (response.statusCode == 201) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.statusCode = response.statusCode;
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        // apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = false;
      apiResult.statusCode = response.statusCode;
      print(response.body);
    }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "isDone: ${apiResult.isDone}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static Future<ApiResult> _makeRequestPut({
    WebControllers webController,
    // WebMethods webMethod
    Map<String, String> header = const {},
    Map body = const {},
  }) async {
    String url = RequestHelper._makePath(
      webController,
    );
    print(
        "Request url: $url\nRequest body: ${jsonEncode(body)}\n ${jsonEncode(header)}\n");
    http.Response response =
        await http.put(Uri.parse(url), headers: header, body: body);
    ApiResult apiResult = new ApiResult();
    if (response.statusCode == 200) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.statusCode = response.statusCode;
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        // apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else if (response.statusCode == 201) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.statusCode = response.statusCode;
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        // apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = false;
      apiResult.statusCode = response.statusCode;
      print(response.body);
    }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "isDone: ${apiResult.isDone}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static Future<ApiResult> _makeRequestGet({
    WebControllers webController,
    // WebMethods webMethod
    Map<String, String> header = const {},
    Map body = const {},
  }) async {
    String url = RequestHelper._makePath(
      webController,
    );
    print(
        "Request url: $url\nRequest body: ${jsonEncode(body)}\n ${jsonEncode(header)}\n");
    http.Response response = await http.get(Uri.parse(url), headers: header);
    ApiResult apiResult = new ApiResult();
    if (response.statusCode == 200 || response.statusCode == 201) {
      try {
        print(response.body);
        Map data = jsonDecode(response.body);
        apiResult.isDone = data['isDone'] == true;
        apiResult.requestedMethod = data['requestedMethod'].toString();
        apiResult.data = data['data'];
      } catch (e) {
        apiResult.isDone = false;
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);
        print(response.body);

        // apiResult.requestedMethod = webMethod.toString().split('.').last;
        apiResult.data = response.body;
      }
    } else {
      apiResult.isDone = false;
    }
    print("\nRequest url: $url\nRequest body: ${jsonEncode(body)}\nResponse: {"
        "status: ${response.statusCode}\n"
        "isDone: ${apiResult.isDone}\n"
        "data: ${apiResult.data}"
        "}");
    return apiResult;
  }

  static String _makePath(
    WebControllers webController,
  ) {
    return "${RequestHelper.BaseUrl}api/${webController.toString().split('.').last}/";
  }

  static Future<ApiResult> register({String mobile}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.register,
      body: {"phone_number": mobile},
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> verify({String code, String mobile}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.verify_user_register,
      body: {"phone_number": mobile, "verify_code": code},
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> exertiseGet() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.exertise,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> getPrescriptions() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.Prescriptions,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> GetCategoryShop() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.category_list,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> exertisePost({String id}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.exertise,
      body: {
        "pk": id,
      },
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> doctorDateList({String id}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.date_list,
      body: {
        "doctor_id": id,
      },
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> doctorTimeList(
      {String dateId, String doctorId}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.time,
      body: {
        "doctor_id": doctorId,
        "date_id": dateId,
      },
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> updateProfile(
      {String name, String family, String national_code, String token}) async {
    return await RequestHelper._makeRequestPut(
        webController: WebControllers.update_profile,
        body: {
          "name": name,
          "family": family,
          "national_code": national_code,
        },
        header: {
          'Authorization': 'Bearer $token',
        }).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> contactUs() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.contact_us,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> aboutUs() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.about_us,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> getClinicList() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.clinic_list,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> slider() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.slider,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> getProfile({String token}) async {
    return await RequestHelper._makeRequestGet(
        webController: WebControllers.get_profile,
        header: {
          'Authorization': 'Bearer $token',
        }).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> insurance() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.insurance,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> company() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.company,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> doctorFilter(
      {String clinic,
      String insurance,
      String expertise_id,
      String clinic_type,
      String province,
      String city,
      String zone}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.doctor_filter,
      body: {
        "clinic": clinic,
        "insurance": insurance,
        "expertise_id": expertise_id,
        "zone": zone,
        "clinic_type": clinic_type,
        "city": city,
      },
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> clinicProfile({String id}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.clinic_detail,
      body: {
        "id": id,
      },
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> dataFilterList() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.filter_list,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> getCommonCourse({String id}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.common_course_detail,
      body: {"id": id},
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> getProductList({String id}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.product_list,
      body: {"category_id": id},
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> getDetailProduct({String product_id}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.product_detail,
      body: {"id": product_id},
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> AddToCart(
      {String product_id, String quantity, String token}) async {
    return await RequestHelper._makeRequest(
        webController: WebControllers.AddToCart,
        body: {
          "product_id": product_id,
          "quantity": quantity,
        },
        header: {
          'Authorization': 'Bearer $token',
        }).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> ToBank({String order_id, String token}) async {
    return await RequestHelper._makeRequest(
        webController: WebControllers.bank,
        body: {
          "order_id": order_id,
        },
        header: {
          'Authorization': 'Bearer $token',
        }).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> commonCourseList() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.common_course,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> GetCartList({String token}) async {
    return await RequestHelper._makeRequestGet(
        webController: WebControllers.ListCart,
        header: {
          'Authorization': 'Bearer $token',
        }).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> ClearITemCart({String token, String row_id}) async {
    return await RequestHelper._makeRequest(
        webController: WebControllers.delete_cart,
        body: {
          "row_id": row_id
        },
        header: {
          'Authorization': 'Bearer $token',
        }).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> reserveApi(
      {String time,
      String doctor_id,
      String date_id,
      String name,
      String family,
      String phone_number,
      String token,
      String national_code}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.reserve,
      header: {
        'Authorization': 'Bearer $token',
      },
      body: {
        "time": time,
        "doctor_id": doctor_id,
        "day": date_id,
        "name": name,
        "family": family,
        "phone_number": phone_number,
        "national_code": national_code,
      },
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> doctorProfile({String doctor_id}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.doctor_profile,
      body: {
        "id": doctor_id,
      },
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> complimentCreate(
      {String text, String token, String doctor_id, String clinic_id}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.compliment_create,
      body: {"text": text, "doctor_id": doctor_id, "clinic_id": clinic_id},
      header: {
        'Authorization': 'Bearer $token',
      },
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> reserveList({String token}) async {
    return await RequestHelper._makeRequestGet(
        webController: WebControllers.reserve_list,
        header: {
          'Authorization': 'Bearer $token',
        }).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> location({String token}) async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.location,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> orderCreate(
      {String address,
      String token,
      String name,
      String family,
      String code,
      String email}) async {
    return await RequestHelper._makeRequest(
        webController: WebControllers.order_create,
        body: {
          "address": address,
          "name": name,
          "family": family,
          "code": code,
          "email": email,
        },
        header: {
          'Authorization': 'Bearer $token',
        }).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> Token({String username, String password}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.token,
      body: {"username": username, "password": password},
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> provinceList() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.province_list,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> clinicDoctorList({String clinic_id}) async {
    return await RequestHelper._makeRequest(
        webController: WebControllers.clinic_doctor,
        body: {"clinic_id": clinic_id}).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> CityList({String province_id}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.city_list,
      body: {"province": province_id},
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> ZoneList({String city_id}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.zone_list,
      body: {"city": city_id},
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> deleteReserveItem({String reserve_id}) async {
    return await RequestHelper._makeRequest(
      webController: WebControllers.reserve_delete,
      body: {"reserve_id": reserve_id},
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> DirectoryCategory() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.dict_category,
    ).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> orderList({String token}) async {
    return await RequestHelper._makeRequestGet(
        webController: WebControllers.order_list,
        header: {
          'Authorization': 'Bearer $token',
        }).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> DoctorDirectoryList({String cat_id}) async {
    return await RequestHelper._makeRequest(
        webController: WebControllers.doctordictionarylist,
        body: {"category_id": cat_id}).timeout(
      Duration(seconds: 180),
    );
  }

  static Future<ApiResult> DiscountListApi() async {
    return await RequestHelper._makeRequestGet(
      webController: WebControllers.discount,
    ).timeout(
      Duration(seconds: 180),
    );
  }
}

class ApiResult {
  bool isDone;
  String requestedMethod;
  dynamic data;
  dynamic data2;
  var statusCode;

  ApiResult({
    this.statusCode,
    this.isDone,
    this.requestedMethod,
    this.data,
    this.data2,
  });
}
