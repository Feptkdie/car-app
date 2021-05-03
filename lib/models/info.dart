class Info {
  int id;
  String title;
  String subtitle;
  String fileMode;
  String filePath;
  String content;
  String createdAt;
  List<dynamic> categories;

  Info({
    this.id,
    this.title,
    this.subtitle,
    this.fileMode,
    this.filePath,
    this.content,
    this.createdAt,
    this.categories,
  });

  factory Info.fromJson(Map<String, dynamic> json) {
    return Info(
      id: json["id"],
      title: json["title"],
      subtitle: json["subtitle"],
      fileMode: json["fileMode"],
      filePath: json["filePath"],
      content: json["content"],
      createdAt: json["createdAt"],
      categories: json["categories"],
    );
  }
}
