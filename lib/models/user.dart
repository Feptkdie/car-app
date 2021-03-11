class User {
  String id;
  String email;
  String token;
  String username;
  String lastname;
  String firstname;
  String phone;
  String gender;
  String image;
  String provider;
  String providerId;

  User({
    this.id,
    this.email,
    this.token,
    this.username,
    this.lastname,
    this.firstname,
    this.phone,
    this.gender,
    this.image,
    this.provider,
    this.providerId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      email: json["email"],
      token: json["token"],
      username: json["username"],
      lastname: json["lastname"],
      firstname: json["firstname"],
      phone: json["phone"],
      gender: json["gender"],
      image: json["image"],
      provider: json["provider"],
      providerId: json["providerId"],
    );
  }
}
