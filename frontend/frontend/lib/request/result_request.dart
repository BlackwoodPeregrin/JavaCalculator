import 'package:json_annotation/json_annotation.dart';

part 'result_request.g.dart';

abstract class ResultRequest {}

@JsonSerializable()
class FailedRequest extends ResultRequest {
  FailedRequest({required this.errorMsg});

  final String errorMsg;

  factory FailedRequest.fromJson(Map<String, dynamic> json) =>
      _$FailedRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FailedRequestToJson(this);
}

@JsonSerializable()
class SuccessRequestCalc extends ResultRequest {
  SuccessRequestCalc({required this.resultCalc});

  final String resultCalc;

  factory SuccessRequestCalc.fromJson(Map<String, dynamic> json) =>
      _$SuccessRequestCalcFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessRequestCalcToJson(this);
}

@JsonSerializable()
class SuccessRequestHistoryCalc extends ResultRequest {
  SuccessRequestHistoryCalc({required this.history});

  final List<HistoryCalculation> history;

  factory SuccessRequestHistoryCalc.fromJson(Map<String, dynamic> json) =>
      _$SuccessRequestHistoryCalcFromJson(json);

  Map<String, dynamic> toJson() => _$SuccessRequestHistoryCalcToJson(this);
}

@JsonSerializable()
class HistoryCalculation {
  HistoryCalculation({required this.id, required this.expression, required this.result});

  final int id;
  final String expression;
  final String result;

  factory HistoryCalculation.fromJson(Map<String, dynamic> json) =>
      _$HistoryCalculationFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryCalculationToJson(this);
}