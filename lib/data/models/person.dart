/// Represents a user who can stream.
class Celebrity {
  final String name;
  final String photoUrl;
  final DateTime joinedDate;
  final bool isLive;

  Celebrity({
    required this.name,
    required this.photoUrl,
    required this.joinedDate,
    required this.isLive,
  });
}
