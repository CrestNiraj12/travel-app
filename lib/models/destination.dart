import 'package:cloud_firestore/cloud_firestore.dart';

class Destination {
  final String id;
  final String name;
  final String country;
  final String imageUrl;
  final String description;
  final GeoPoint location;

  Destination({
    required this.id,
    required this.name,
    required this.country,
    required this.imageUrl,
    required this.description,
    required this.location,
  });

  Destination.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        country = json['country'],
        imageUrl = json['image_url'],
        description = json['description'],
        location = json['location'];
}
