class Setting {
  int id;
  String phone;
  String about;

  Setting({
    this.id,
    this.phone,
    this.about,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      id: json["id"],
      phone: json["phone"],
      about: json["about"],
    );
  }
}
