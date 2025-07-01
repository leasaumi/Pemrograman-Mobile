import 'package:flutter/material.dart';
import '../models/article.dart';

class MyArticlesScreen extends StatefulWidget {
  @override
  _MyArticlesScreenState createState() => _MyArticlesScreenState();
}

class _MyArticlesScreenState extends State<MyArticlesScreen> {
  List<Article> articles = [
    Article(
      id: '1',
      title: 'Hot News!!!',
      thumbnail: '',
      publishDate: '05 Juli 1999',
      author: 'Test',
      content: 'Jadi Begini Gaess!',
      category: 'Teknologi',
      source: 'Test',
    ),
    Article(
      id: '2',
      title: 'Hot News!',
      thumbnail: '',
      publishDate: '05 Juli 1998',
      author: 'Admin',
      content: 'Content here',
      category: 'Teknologi',
      source: 'Admin',
    ),
  ];

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
      body: articles.isEmpty
          ? Center(
              child: Text(
                'Yuk Tambah Artikel :))',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            )
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                return _buildArticleItem(articles[index]);
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

  Widget _buildArticleItem(Article article) {
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
                    onPressed: () {
                      _deleteArticle(article.id);
                    },
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            '${article.category} | ${article.publishDate} | ${article.author}',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _deleteArticle(String id) {
    setState(() {
      articles.removeWhere((article) => article.id == id);
    });
  }
}
