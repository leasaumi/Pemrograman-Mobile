import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/article.dart';

class ApiService {
  // Base URL dari dokumentasi API
  static const String _baseUrl = 'http://45.149.187.204:3000/api';

  // Fungsi untuk mendapatkan token dari SharedPreferences
  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Fungsi untuk login
  Future<String> login() async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      // Menggunakan kredensial default sesuai permintaan
      body: jsonEncode({
        'email': 'news@itg.ac.id',
        'password': 'ITG#news',
      }),
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final token = body['body']['data']['token'];

      // Simpan token ke SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      return token;
    } else {
      throw Exception('Failed to login');
    }
  }

  // Fungsi untuk mendapatkan artikel milik author (GET)
  Future<List<Article>> getMyArticles() async {
    final token = await _getToken();
    if (token == null) throw Exception('Token not found');

    final response = await http.get(
      Uri.parse('$_baseUrl/author/news'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> articlesJson = body['body']['data'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load articles');
    }
  }

  // Fungsi baru untuk mendapatkan semua berita publik
  Future<List<Article>> getPublicNews() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/news'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<dynamic> articlesJson = body['body']['data'];
      return articlesJson.map((json) => Article.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load public news');
    }
  }

  // Fungsi untuk membuat artikel baru (POST)
  Future<Article> addArticle(String title, String summary, String content) async {
    final token = await _getToken();
    if (token == null) throw Exception('Token not found');

    final response = await http.post(
      Uri.parse('$_baseUrl/author/news'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'summary': summary,
        'content': content,
        'featuredImageUrl': 'https://placehold.co/600x400/EEE/31343C?text=Newzly', // Placeholder
        'category': 'Default', // Kategori default
        'isPublished': true,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final body = jsonDecode(response.body);
      return Article.fromJson(body['body']['data']);
    } else {
      throw Exception('Failed to add article');
    }
  }

  // Fungsi untuk mengupdate artikel (PUT)
  Future<void> updateArticle(String id, String title, String summary, String content) async {
    final token = await _getToken();
    if (token == null) throw Exception('Token not found');

    final response = await http.put(
      Uri.parse('$_baseUrl/author/news/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'summary': summary,
        'content': content,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update article');
    }
  }

  // Fungsi untuk menghapus artikel (DELETE)
  Future<void> deleteArticle(String id) async {
    final token = await _getToken();
    if (token == null) throw Exception('Token not found');

    final response = await http.delete(
      Uri.parse('$_baseUrl/author/news/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete article');
    }
  }
}
