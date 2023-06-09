class User {
  final int id;
  final String username;
  final int clubId;

  const User({
    required this.id,
    required this.username,
    required this.clubId,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        clubId = json['clubId'];
}
