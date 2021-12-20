
class CommonCourseModel {
  CommonCourseModel({
    this.id,
    this.title,
    this.image,
    this.description,
    this.source,
    this.video,
  });

  int id;
  String title;
  String image;
  String description;
  String source;
  String video;

  factory CommonCourseModel.fromJson(Map<String, dynamic> json) => CommonCourseModel(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    description: json["description"],
    source: json["source"],
    video: json["video"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "description": description,
    "source": source,
    "video": video,
  };
}