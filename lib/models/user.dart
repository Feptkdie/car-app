class User {
  int id;
  String email;
  String token;
  String lastname;
  String firstname;
  String phone;
  String avatar;
  String cars;

  User({
    this.id,
    this.email,
    this.token,
    this.lastname,
    this.firstname,
    this.phone,
    this.avatar,
    this.cars,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      token: json["token"],
      lastname: json["lastname"],
      firstname: json["firstname"],
      phone: json["phone"],
      avatar: json["avatar"],
      cars: json["cars"],
    );
  }
}
