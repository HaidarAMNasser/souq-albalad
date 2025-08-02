import 'dart:convert';

class MessageModel {
  bool success;
  dynamic result;
  String message;

  MessageModel({
    this.success = false,
    this.result,
    this.message = 'Unknown Error',
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      MessageModel.fromMap(json);

  String toJson() => json.encode(toMap());

  // factory MessageModel.EmptyMessageSuccess() => MessageModel(isSuccess: true);

  factory MessageModel.fromMap(Map<String, dynamic> json) => MessageModel(
        success: json['success'] == 1,
        result: json['result'] ?? '',
        message: json['message'] ?? 'Unknown Error',
      );

  Map<String, dynamic> toMap() => {
        'success': success,
        'result': result,
        'message': message,
      };
}
