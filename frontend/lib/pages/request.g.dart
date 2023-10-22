// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RequestReceived _$RequestReceivedFromJson(Map<String, dynamic> json) =>
    RequestReceived(
      valid: json['valid'] as bool,
      value: json['value'] as String,
    );

Map<String, dynamic> _$RequestReceivedToJson(RequestReceived instance) =>
    <String, dynamic>{
      'valid': instance.valid,
      'value': instance.value,
    };
