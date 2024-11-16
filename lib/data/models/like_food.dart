class FavoriteFood {
  final String imageUrl;
  final String title;
  final double rating;
  final double distance;
  final int minute;
  final List<String> tags;

  FavoriteFood({
    required this.imageUrl,
    required this.title,
    required this.rating,
    required this.distance,
    required this.minute,
    required this.tags,
  });
}
