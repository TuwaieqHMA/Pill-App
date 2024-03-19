class SaedUser {
  SaedUser({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.age,
  });

  late final String? id;
  late final String name;
  late final String email;
  late final String password;
  late final int age;

  SaedUser.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        email = json['email'],
        password = json['password'],
        age = json['age'];

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['name'] = name;
    _data['email'] = email;
    _data['password'] = password;
    _data['age'] = age;
    return _data;
  }
}
