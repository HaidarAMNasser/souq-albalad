import 'package:souq_al_balad/global/endpoints/models/message_model.dart';
import 'package:souq_al_balad/global/endpoints/models/result_class.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class Model {
  MessageModel? error;
  List<MessageModel?>? errorList;

  Model({this.error, this.errorList});

  bool get hasErrors =>
      error != null || (errorList != null && errorList!.isNotEmpty);

  String get getErrors {
    if (error != null) {
      return error?.message ?? '';
    } else {
      var kontan = StringBuffer();
      errorList?.forEach((element) {
        kontan.writeln(element?.message ?? '');
        kontan.writeln('\n');
      });
      return kontan.toString();
    }
  }

  static Model catchErrorMethod(dynamic error, dynamic stacktrace) {
    Model model = Model();
    if (error is DioError) {
      var response = error.response?.data;
      if (response != null) {
        if (response is List) {
          if (response is List<MessageModel>) model.errorList = response;
          model.errorList = [MessageModel()];
        } else {
          debugPrint('_withError ${response.runtimeType}');
          if (response is MessageModel) {
            model.error = response;
          } else if (response is Map<String, dynamic>) {
            model.error = MessageModel.fromMap(response);
          } else {
            model.error = MessageModel();
          }
        }
      } else {
        model.error = MessageModel(message: error.toString());
      }
    } else {
      debugPrint('error: $error & stacktrace: $stacktrace');
      model.error = MessageModel(message: error.toString());
    }

    return model;
  }

  static DateTime? getTryDateTime(String? s) {
    try {
      if (s == null) return null;
      if (DateTime.tryParse(s) != null) {
        String addUtc = s.toUpperCase().contains('Z') ? '' : 'Z';
        return DateTime.parse(s + addUtc).toLocal();
      }
    } catch (e) {
      debugPrint('error parsing date $s => $e');
      return null;
    }
    return null;
  }

  static DateTime getDateTime(String s) {
    return getTryDateTime(s) ?? DateTime.now();
  }

  static ResponseState<T> catchError<T>(error, stacktrace) {
    assert(T != dynamic);
    return ResponseState.error(Model.catchErrorMethod(error, stacktrace));
  }
}
