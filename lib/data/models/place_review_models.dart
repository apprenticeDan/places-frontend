import 'dart:convert';
import 'package:places/domain/entities/place_entity.dart';
import 'package:places/domain/entities/review_entity.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel({
    required super.id,
    required super.name,
    required super.description,
    required super.rating,
    required super.images,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['id'] as int,
      name: json['nombre'] as String,
      description: json['descripcion'] as String,
      rating: json['rating'] as int,
      images: PlaceImages(
        thumb: json['images']['thumb'] as String,
        medium: json['images']['medium'] as String,
        full: json['images']['full'] as String,
      ),
    );
  }

  static List<PlaceModel> fromJsonList(String body) {
    final List<dynamic> data = jsonDecode(body);
    return data.map((json) => PlaceModel.fromJson(json)).toList();
  }
}

class ReviewModel extends ReviewEntity {
  const ReviewModel({
    required super.id,
    required super.userName,
    required super.summary,
    required super.stars,
    required super.comment,
    required super.profileImageUrl,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int,
      userName: json['userName'] as String,
      summary: json['summary'] as String,
      stars: json['stars'] as int,
      comment: json['commentText'] as String,
      profileImageUrl: json['profileImageUrl'] as String,
    );
  }

  static List<ReviewModel> fromJsonList(String body) {
    final List<dynamic> data = jsonDecode(body);
    return data.map((json) => ReviewModel.fromJson(json)).toList();
  }
}
