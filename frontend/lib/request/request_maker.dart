import 'package:app/request/result_request.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RequestMaker {
  static Future<ResultRequest> calculate({required String expression}) async {
    const url = 'http://localhost:8080/calc';
    return http
        .post(Uri.parse(url), body: jsonEncode({'expression': expression}))
        .then((response) {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        if (body.containsKey('resultCalc')) {
          return SuccessRequestCalc.fromJson(body);
        }
        return FailedRequest.fromJson(body);
      }
      return FailedRequest(
          errorMsg: 'Request failed with status: ${response.statusCode}.');
    }).catchError((onError) =>
            FailedRequest(errorMsg: 'Exception in RequestMaker: $onError'));
  }

  static Future<ResultRequest> pullHistory() async {
    const url = 'http://localhost:8080/pull/history';
    return http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body) as Map<String, dynamic>;
        if (body.containsKey('history')) {
          return SuccessRequestHistoryCalc.fromJson(body);
        }
        return FailedRequest.fromJson(body);
      }
      return FailedRequest(
          errorMsg: 'Request failed with status: ${response.statusCode}.');
    }).catchError((onError) =>
        FailedRequest(errorMsg: 'Exception in RequestMaker: $onError'));
  }

  static Future<bool> clearHistory() async {
    const url = 'http://localhost:8080/clear/history';
    return http.get(Uri.parse(url)).then((response) {
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as bool;
      }
      return false;
    }).catchError((onError) => false);
  }

  static Future<bool> pushHistory({required HistoryCalculation value}) async {
    const url = 'http://localhost:8080/push/history';
    return http.post(Uri.parse(url), body: jsonEncode(value)).then((response) {
      if (response.statusCode == 200) {
        return jsonDecode(response.body) as bool;
      }
      return false;
    }).catchError((onError) => false);
  }
}
