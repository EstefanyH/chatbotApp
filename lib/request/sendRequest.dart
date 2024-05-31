import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class SendRequest {
  final String msg;

  const SendRequest({
    required this.msg
  });

  Map<String, dynamic> toJson() => {
    'msg': msg
  };
}