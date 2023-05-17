class User {
  int id;
  String name;
  String email;
  String avatar;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        avatar = json['avatar'] ??
            "https://ui-avatars.com/api/?background=random&size=500&name=${json['name'].toString().trim().toLowerCase()}";
}
