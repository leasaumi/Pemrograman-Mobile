import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/article_provider.dart';

class MyArticlesScreen extends StatefulWidget {
  @override
  _MyArticlesScreenState createState() => _MyArticlesScreenState();
}

class _MyArticlesScreenState extends State<MyArticlesScreen> {
  // Panggil fetchArticles saat widget pertama kali dibuat
  @override
  void initState() {
    super.initState();
    // Gunakan addPostFrameCallback untuk memastikan context sudah tersedia
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ArticleProvider>(context, listen: false).fetchArticles();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Artikel Anda',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      // Gunakan Consumer untuk mendengarkan perubahan dari ArticleProvider
      body: Consumer<ArticleProvider>(
        builder: (context, provider, child) {
          if (provider.state == NotifierState.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.state == NotifierState.error) {
            return Center(child: Text('Error: ${provider.errorMessage}'));
          }
          if (provider.articles.isEmpty) {
            return Center(
              child: Text(
                'Yuk Tambah Artikel :))',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          }
          // Tampilkan daftar artikel jika data berhasil dimuat
          return ListView.builder(
            itemCount: provider.articles.length,
            itemBuilder: (context, index) {
              final article = provider.articles[index];
              return _buildArticleItem(context, article);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-article');
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }

  Widget _buildArticleItem(BuildContext context, Article article) {
    final provider = Provider.of<ArticleProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  article.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/edit-article',
                        arguments: article,
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      // Tampilkan dialog konfirmasi sebelum menghapus
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Hapus Artikel?'),
                          content:
                              Text('Apakah Anda yakin ingin menghapus artikel "${article.title}"?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: Text('Batal'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: Text('Hapus'),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        await provider.deleteArticle(article.id);
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '${article.category ?? "No Category"} | ${article.publishedAt?.toLocal().toString().substring(0, 10) ?? "No Date"}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
