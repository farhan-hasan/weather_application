import 'package:dio/dio.dart';

import 'error_response.dart';

class ApiManagerDio {
  final dio = Dio();
  Map<String, String> commonHeader = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };

  Future getRequest({required String url}) async {
    try {
      Response response = await dio.get(url);
      final statusCode = response.statusCode ?? 500;
      print(response.data);
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
      } else {
        return ErrorResponse(statusCode: statusCode, message: response.data);
      }
    } catch (e) {}
    return ErrorResponse(statusCode: 1400, message: "Something went wrong");
  }

  Future postRequest(
      {required String url, required Map<String, dynamic> data}) async {
    try {
      Response response = await dio.post(url,
          data: data,
          options: Options(
            headers: commonHeader,
            contentType: "application/json",
          ));
      final statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
      } else {
        return ErrorResponse(statusCode: statusCode, message: response.data);
      }
    } catch (e) {}
    return ErrorResponse(statusCode: 1400, message: "Something went wrong");
  }

  Future deleteRequest(
      {required String url, required Map<String, dynamic> data}) async {
    try {
      Response response = await dio.delete(url, data: data);
      final statusCode = response.statusCode ?? 500;
      if (statusCode >= 200 && statusCode < 300) {
        return response.data;
      } else {
        return ErrorResponse(statusCode: statusCode, message: response.data);
      }
    } catch (e) {}
    return ErrorResponse(statusCode: 1400, message: "Something went wrong");
  }
}
