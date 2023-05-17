import 'package:traveller/models/review.dart';

class Destination {
  final int id;
  final String name;
  final String country;
  final String imageUrl;
  final String description;
  final double latitude;
  final double longitude;
  final double avgReviews;
  final List<Review> reviews;

  Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.avgReviews = 0,
    this.reviews = const [],
  });

  Destination.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        country = json['country'],
        imageUrl = json['imageUrl'],
        description = json['description'],
        latitude = double.parse(json['latitude']),
        longitude = double.parse(json['longitude']),
        avgReviews = double.parse(json['avg_reviews'].toString()),
        reviews = List.from(json['reviews'])
            .map((review) => Review.fromJson(review as Map<String, dynamic>))
            .toList();
}
