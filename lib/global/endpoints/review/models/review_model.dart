import 'package:souq_al_balad/global/endpoints/user/models/user_model.dart';

class ReviewModel {
  int? id;
  int? rate;
  String? comment;
  String? createdAt;
  UserModel? user;

  ReviewModel({this.id, this.rate, this.comment, this.createdAt, this.user});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'],
      rate: json['rate'],
      comment: json['comment'],
      createdAt: json['created_at'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['rate'] = rate;
    data['comment'] = comment;
    data['created_at'] = createdAt;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
