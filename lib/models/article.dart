class Article {
  final String id;
  final String title;
  final String? summary;
  final String? content;
  final String? featuredImageUrl;
  final String? category;
  final String? authorId;
  final String? authorName;
  final DateTime? publishedAt;
  final int? viewCount; // Ditambahkan untuk trending

  Article({
    required this.id,
    required this.title,
    this.summary,
    this.content,
    this.featuredImageUrl,
    this.category,
    this.authorId,
    this.authorName,
    this.publishedAt,
    this.viewCount, // Ditambahkan
  });

  // Factory constructor untuk membuat instance Article dari JSON
  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] as String,
      title: json['title'] as String,
      summary: json['summary'] as String?,
      content: json['content'] as String?,
      featuredImageUrl: json['featured_image_url'] as String?,
      category: json['category'] as String?,
      authorId: json['author_id'] as String?,
      authorName: json['author_name'] as String?,
      publishedAt:
          json['published_at'] != null ? DateTime.parse(json['published_at'] as String) : null,
      // API terkadang mengirim 'view count' atau 'view_count'
      viewCount: json['view_count'] as int? ?? json['view count'] as int? ?? 0,
    );
  }
}
