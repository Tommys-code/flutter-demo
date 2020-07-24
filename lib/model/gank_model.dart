class GankModel {
  final String desc;
  final List images;
  final String publishedAt;
  final String url;
  final String author;

  const GankModel(
      {this.desc, this.images, this.publishedAt, this.url, this.author});

  GankModel.fromJson(Map<String, dynamic> json)
      : desc = json['desc'],
        images = json['images'],
        publishedAt = json['publishedAt'],
        url = json['url'],
        author = json['author'];
}
