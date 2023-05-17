import 'package:traveller/models/user.dart';

class Review {
  int id;
  double ratings;
  String? comment;
  int destId;
  User user;
  DateTime updatedAt;

  Review({
    required this.id,
    required this.ratings,
    required this.comment,
    required this.destId,
    required this.user,
    required this.updatedAt,
  });

  Review.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        ratings = double.parse(json['ratings'].toString()),
        comment = json['comment'],
        destId = json['dest_id'],
        user = User.fromJson(json['user']),
        updatedAt = DateTime.parse(json['updated_at']);
}
