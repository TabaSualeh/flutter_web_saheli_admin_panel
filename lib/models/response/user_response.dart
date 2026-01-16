// To parse this JSON data, do
//
//     final userResponse = userResponseFromJson(jsonString);

import 'dart:convert';

import '../user.dart';

UserResponse userResponseFromJson(String str) => UserResponse.fromJson(json.decode(str));

String userResponseToJson(UserResponse data) => json.encode(data.toJson());

class UserResponse {
  bool? success;
  String? message;
  int? totalCount;
  int? totalPages;
  List<User>? data;

  UserResponse({
    this.success,
    this.message,
    this.totalCount,
    this.totalPages,
    this.data,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        success: json["success"],
        message: json["message"],
        totalCount: json["totalCount"],
        totalPages: json["totalPages"],
        data: json["data"] == null ? [] : List<User>.from(json["data"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "totalCount": totalCount,
        "totalPages": totalPages,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}
