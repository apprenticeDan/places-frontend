class PlaceEntity {
  final int id;
  final String name;
  final String description;
  final int rating;
  final PlaceImages images;

  const PlaceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.rating,
    required this.images,
  });
}

class PlaceImages {
  final String thumb;
  final String medium;
  final String full;

  const PlaceImages({
    required this.thumb,
    required this.medium,
    required this.full,
  });
}
