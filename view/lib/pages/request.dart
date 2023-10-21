import 'package:json_annotation/json_annotation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'request.g.dart';

@JsonSerializable()
class RequestReceived {
  const RequestReceived({required this.valid, required this.value});

  final bool valid;
  final String value;

  factory RequestReceived.fromJson(Map<String, dynamic> json) =>
      _$RequestReceivedFromJson(json);

  Map<String, dynamic> toJson() => _$RequestReceivedToJson(this);
}

class RequestMaker {
  static Future<RequestReceived> post(
      {required String url, required String expression}) async {
    return http
        .post(Uri.parse(url), body: jsonEncode({'expression': expression}))
        .then((response) {
      if (response.statusCode == 200) {
        print(response.body);
        return RequestReceived.fromJson(jsonDecode(response.body));
      } else {
        return RequestReceived(
            valid: false,
            value: 'Request failed with status: ${response.statusCode}.');
      }
    }).onError((error, stackTrace) => RequestReceived(
            valid: false,
            value: 'Exception in RequestMaker: ${error.toString()}'));
  }
}
