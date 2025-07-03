import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/article_provider.dart';
import 'article_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // Jika ada kategori, pilih yang pertama sebagai default
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ArticleProvider>(context, listen: false);
      if (provider.categories.isNotEmpty) {
        setState(() {
          _selectedCategory = provider.categories.first;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ArticleProvider>(
        builder: (context, provider, child) {
          if (provider.publicState == NotifierState.loading) {
            return Center(child: CircularProgressIndicator());
          }
          if (provider.categories.isEmpty) {
            return Center(child: Text('Tidak ada kategori ditemukan.'));
          }

          return Column(
            children: [
              // Daftar Chip Kategori
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: provider.categories.map((category) {
                      return _buildCategoryChip(category);
                    }).toList(),
                  ),
                ),
              ),

              // Daftar Artikel Berdasarkan Kategori yang Dipilih
              Expanded(
                child: _selectedCategory == null
                    ? Center(child: Text('Pilih sebuah kategori.'))
                    : ListView.builder(
                        itemCount: provider.articlesByCategory[_selectedCategory]?.length ?? 0,
                        itemBuilder: (context, index) {
                          final article = provider.articlesByCategory[_selectedCategory]![index];
                          return _buildNewsItem(context, article);
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    bool isSelected = category == _selectedCategory;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: ChoiceChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedCategory = category;
          });
        },
        selectedColor: Colors.blue,
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
        backgroundColor: Colors.grey[200],
        shape: StadiumBorder(side: BorderSide(color: Colors.grey.shade300)),
      ),
    );
  }

  Widget _buildNewsItem(BuildContext context, Article article) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          article.featuredImageUrl ?? 'https://placehold.co/80x80/EEE/31343C?text=N/A',
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 80,
              height: 80,
              color: Colors.grey[300],
              child: Icon(Icons.broken_image, color: Colors.grey, size: 30),
            );
          },
        ),
      ),
      title: Text(
        article.title,
        style: TextStyle(fontWeight: FontWeight.bold),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        'Oleh ${article.authorName ?? "Unknown"}',
        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
      ),
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
