class ReviewEntity {
  final int id;
  final String userName;
  final String summary;
  final int stars;
  final String comment;
  final String profileImageUrl;

  const ReviewEntity({
    required this.id,
    required this.userName,
    required this.summary,
    required this.stars,
    required this.comment,
    required this.profileImageUrl,
  });
}