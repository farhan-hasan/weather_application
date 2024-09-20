import 'dart:convert';

import 'package:http/http.dart';
import 'package:networking_practice/config/network/error_response.dart';

class ApiManagerHTTP {
  Map<String, String> commonHeader = {
    "Content-type": "application/json",
    "Accept": "application/json"
  };

  Future getRequest({required String url}) async {
    try {
      Response response = await get(Uri.parse(url), headers: commonHeader);
      print(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        return ErrorResponse(
            statusCode: response.statusCode, message: response.body);
      }
    } catch (e) {}
    return ErrorResponse(statusCode: 1400, message: "Something went wrong");
  }

  Future postRequest(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      Response response = await post(Uri.parse(url),
          body: jsonEncode(body), headers: commonHeader);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        return ErrorResponse(
            statusCode: response.statusCode, message: response.body);
      }
    } catch (e) {}
    return ErrorResponse(statusCode: 1400, message: "Something went wrong");
  }

  Future deleteRequest(
      {required String url, required Map<String, dynamic> body}) async {
    try {
      Response response = await delete(Uri.parse(url),
          body: jsonEncode(body), headers: commonHeader);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        return ErrorResponse(
            statusCode: response.statusCode, message: response.body);
      }
    } catch (e) {}
    return ErrorResponse(statusCode: 1400, message: "Something went wrong");
  }
}
