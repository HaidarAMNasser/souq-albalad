import 'package:equatable/equatable.dart';

class ErrorModel extends Equatable {
  final Map<String, List<String>> errors;

  const ErrorModel({required this.errors});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    final errorMap = <String, List<String>>{};
    json['errors'].forEach((key, value) {
      errorMap[key] = List<String>.from(value);
    });
    return ErrorModel(errors: errorMap);
  }

  String? getError(String field) {
    return errors[field]?.isNotEmpty == true ? errors[field]!.first : null;
  }

  @override
  List<Object?> get props => [errors];
}
