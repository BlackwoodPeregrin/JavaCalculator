// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FailedRequest _$FailedRequestFromJson(Map<String, dynamic> json) =>
    FailedRequest(
      errorMsg: json['errorMsg'] as String,
    );

Map<String, dynamic> _$FailedRequestToJson(FailedRequest instance) =>
    <String, dynamic>{
      'errorMsg': instance.errorMsg,
    };

SuccessRequestCalc _$SuccessRequestCalcFromJson(Map<String, dynamic> json) =>
    SuccessRequestCalc(
      resultCalc: json['resultCalc'] as String,
    );

Map<String, dynamic> _$SuccessRequestCalcToJson(SuccessRequestCalc instance) =>
    <String, dynamic>{
      'resultCalc': instance.resultCalc,
    };

SuccessRequestHistoryCalc _$SuccessRequestHistoryCalcFromJson(
        Map<String, dynamic> json) =>
    SuccessRequestHistoryCalc(
      history: (json['history'] as List<dynamic>)
          .map((e) => HistoryCalculation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SuccessRequestHistoryCalcToJson(
        SuccessRequestHistoryCalc instance) =>
    <String, dynamic>{
      'history': instance.history,
    };

HistoryCalculation _$HistoryCalculationFromJson(Map<String, dynamic> json) =>
    HistoryCalculation(
      id: json['id'] as int,
      expression: json['expression'] as String,
      result: json['result'] as String,
    );

Map<String, dynamic> _$HistoryCalculationToJson(HistoryCalculation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'expression': instance.expression,
      'result': instance.result,
    };
