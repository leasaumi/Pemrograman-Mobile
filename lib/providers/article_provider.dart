import 'package:flutter/material.dart';
import '../models/article.dart';
import '../services/api_service.dart';

// Enum untuk merepresentasikan status loading
enum NotifierState { initial, loading, loaded, error }

class ArticleProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  // State untuk artikel milik author
  List<Article> _articles = [];
  List<Article> get articles => _articles;
  NotifierState _state = NotifierState.initial;
  NotifierState get state => _state;
  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  // State untuk berita publik
  List<Article> _publicArticles = [];
  List<Article> get publicArticles => _publicArticles;
  NotifierState _publicState = NotifierState.initial;
  NotifierState get publicState => _publicState;
  String _publicErrorMessage = '';
  String get publicErrorMessage => _publicErrorMessage;

  // State untuk hasil pencarian
  List<Article> _searchedArticles = [];
  List<Article> get searchedArticles => _searchedArticles;
  bool _isSearching = false;
  bool get isSearching => _isSearching;

  // State untuk Kategori dan Trending
  List<String> _categories = [];
  List<String> get categories => _categories;
  List<Article> _trendingArticles = [];
  List<Article> get trendingArticles => _trendingArticles;
  Map<String, List<Article>> _articlesByCategory = {};
  Map<String, List<Article>> get articlesByCategory => _articlesByCategory;

  void _setState(NotifierState state) {
    _state = state;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    _setState(NotifierState.error);
  }

  void _setPublicState(NotifierState state) {
    _publicState = state;
    notifyListeners();
  }

  void _setPublicError(String message) {
    _publicErrorMessage = message;
    _setPublicState(NotifierState.error);
  }

  // Proses data setelah berhasil diambil
  void _processPublicArticles() {
    // 1. Ekstrak kategori unik
    final categorySet = <String>{};
    for (var article in _publicArticles) {
      if (article.category != null && article.category!.isNotEmpty) {
        categorySet.add(article.category!);
      }
    }
    _categories = categorySet.toList()..sort();

    // 2. Urutkan berita trending berdasarkan view count
    _trendingArticles = List.from(_publicArticles);
    _trendingArticles.sort((a, b) => (b.viewCount ?? 0).compareTo(a.viewCount ?? 0));
    _trendingArticles = _trendingArticles.take(5).toList(); // Ambil 5 teratas

    // 3. Kelompokkan artikel berdasarkan kategori
    _articlesByCategory = {};
    for (var category in _categories) {
      _articlesByCategory[category] =
          _publicArticles.where((article) => article.category == category).toList();
    }
  }

  // Mengambil daftar artikel milik author dari API
  Future<void> fetchArticles() async {
    _setState(NotifierState.loading);
    try {
      _articles = await _apiService.getMyArticles();
      _setState(NotifierState.loaded);
    } catch (e) {
      _setError(e.toString());
    }
  }

  // Mengambil daftar berita publik dari API
  Future<void> fetchPublicArticles() async {
    _setPublicState(NotifierState.loading);
    try {
      _publicArticles = await _apiService.getPublicNews();
      _processPublicArticles(); // Proses data setelah diambil
      _setPublicState(NotifierState.loaded);
    } catch (e) {
      _setPublicError(e.toString());
    }
  }

  // Fungsi untuk melakukan pencarian di sisi client
  void searchArticles(String query) {
    _isSearching = query.isNotEmpty;
    if (query.isEmpty) {
      _searchedArticles = [];
    } else {
      _searchedArticles = _publicArticles
          .where((article) =>
              article.title.toLowerCase().contains(query.toLowerCase()) ||
              (article.content?.toLowerCase().contains(query.toLowerCase()) ?? false))
          .toList();
    }
    notifyListeners();
  }

  // Fungsi untuk membersihkan hasil pencarian
  void clearSearch() {
    _searchedArticles = [];
    _isSearching = false;
    notifyListeners();
  }

  // Menambah artikel baru
  Future<void> addArticle(String title, String summary, String content) async {
    try {
      final newArticle = await _apiService.addArticle(title, summary, content);
      _articles.insert(0, newArticle);
      notifyListeners();
    } catch (e) {
      print('Error adding article: $e');
      rethrow;
    }
  }

  // Mengupdate artikel
  Future<void> updateArticle(String id, String title, String summary, String content) async {
    try {
      await _apiService.updateArticle(id, title, summary, content);
      await fetchArticles();
    } catch (e) {
      print('Error updating article: $e');
      rethrow;
    }
  }

  // Menghapus artikel
  Future<void> deleteArticle(String id) async {
    try {
      await _apiService.deleteArticle(id);
      _articles.removeWhere((article) => article.id == id);
      notifyListeners();
    } catch (e) {
      print('Error deleting article: $e');
      rethrow;
    }
  }
}
