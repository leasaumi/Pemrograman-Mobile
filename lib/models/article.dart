class Article {
  final String id;
  final String title;
  final String thumbnail;
  final String publishDate;
  final String author;
  final String content;
  final String category;
  final String source;

  Article({
    required this.id,
    required this.title,
    required this.thumbnail,
    required this.publishDate,
    required this.author,
    required this.content,
    required this.category,
    required this.source,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'thumbnail': thumbnail,
      'publishDate': publishDate,
      'author': author,
      'content': content,
      'category': category,
      'source': source,
    };
  }

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'],
      title: json['title'],
      thumbnail: json['thumbnail'],
      publishDate: json['publishDate'],
      author: json['author'],
      content: json['content'],
      category: json['category'],
      source: json['source'],
    );
  }
}
