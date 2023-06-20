class User {
  final int id;
  final String username;
  final int clubId;
  final String? code;

  const User({
    required this.id,
    required this.username,
    required this.clubId,
    this.code,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        username = json['username'],
        clubId = json['clubId'],
        code = json['code'];
}
