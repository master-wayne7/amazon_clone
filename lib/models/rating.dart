// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Rating {
  final String userId;
  final String userName;
  final double rating;
  final String review;
  final String reviewHeading;
  final double reviewTime;
  Rating({
    required this.userId,
    required this.userName,
    required this.rating,
    required this.review,
    required this.reviewHeading,
    required this.reviewTime,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'userName': userName,
      'rating': rating,
      'review': review,
      'reviewHeading': reviewHeading,
      'reviewTime': reviewTime,
    };
  }

  factory Rating.fromMap(Map<String, dynamic> map) {
    return Rating(
      userId: map['userId'] as String,
      userName: map['userName'] as String,
      rating: double.parse(map['rating'].toString()),
      review: map['review'] as String,
      reviewHeading: map['reviewHeading'] as String,
      reviewTime: double.parse(map['reviewTime'].toString()),
    );
  }

  String toJson() => json.encode(toMap());

  factory Rating.fromJson(String source) =>
      Rating.fromMap(json.decode(source) as Map<String, dynamic>);
}
