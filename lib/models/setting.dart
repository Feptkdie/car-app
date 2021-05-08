class Setting {
  int id;
  String phone;
  String about;
  String sliders;

  Setting({
    this.id,
    this.phone,
    this.about,
    this.sliders,
  });

  factory Setting.fromJson(Map<String, dynamic> json) {
    return Setting(
      id: json["id"],
      phone: json["phone"],
      about: json["about"],
      sliders: json["sliders"],
    );
  }
}
