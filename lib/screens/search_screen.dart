import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/article_provider.dart';
import 'article_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Bersihkan hasil pencarian sebelumnya saat layar dibuka
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ArticleProvider>(context, listen: false).clearSearch();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Cari Berita',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Ketik judul atau isi berita...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                filled: true,
                fillColor: Colors.grey[100],
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    Provider.of<ArticleProvider>(context, listen: false).searchArticles('');
                  },
                ),
              ),
              onChanged: (value) {
                // Panggil provider untuk melakukan pencarian setiap kali teks berubah
                Provider.of<ArticleProvider>(context, listen: false).searchArticles(value);
              },
            ),
          ),

          // Daftar hasil pencarian
          Expanded(
            child: Consumer<ArticleProvider>(
              builder: (context, provider, child) {
                // Tampilkan pesan jika pencarian belum dimulai
                if (!provider.isSearching) {
                  return Center(
                    child: Text(
                      'Silakan mulai mencari berita.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }
                // Tampilkan pesan jika tidak ada hasil
                if (provider.searchedArticles.isEmpty) {
                  return Center(
                    child: Text(
                      'Tidak ada berita yang ditemukan.',
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  );
                }
                // Tampilkan hasil pencarian
                return ListView.builder(
                  itemCount: provider.searchedArticles.length,
                  itemBuilder: (context, index) {
                    final article = provider.searchedArticles[index];
                    return _buildSearchResultItem(context, article);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResultItem(BuildContext context, Article article) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          article.featuredImageUrl ?? 'https://placehold.co/80x80/EEE/31343C?text=N/A',
          width: 60,
          height: 60,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 60,
              height: 60,
              color: Colors.grey[300],
              child: Icon(Icons.broken_image, color: Colors.grey, size: 24),
            );
          },
        ),
      ),
      title: Text(article.title, maxLines: 2, overflow: TextOverflow.ellipsis),
      subtitle: Text(article.summary ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailScreen(),
            settings: RouteSettings(arguments: article),
          ),
        );
      },
    );
  }
}
