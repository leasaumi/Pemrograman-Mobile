import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/article.dart';
import '../providers/article_provider.dart';

class EditArticleScreen extends StatefulWidget {
  @override
  _EditArticleScreenState createState() => _EditArticleScreenState();
}

class _EditArticleScreenState extends State<EditArticleScreen> {
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Article? _article;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ambil argumen artikel dan isi controllernya
    final article = ModalRoute.of(context)?.settings.arguments as Article?;
    if (article != null && _article == null) {
      _article = article;
      _titleController.text = article.title;
      _summaryController.text = article.summary ?? '';
      _contentController.text = article.content ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Artikel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Judul'),
                validator: (value) => value!.isEmpty ? 'Judul tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _summaryController,
                decoration: InputDecoration(labelText: 'Ringkasan'),
                validator: (value) => value!.isEmpty ? 'Ringkasan tidak boleh kosong' : null,
              ),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(labelText: 'Konten'),
                maxLines: 5,
                validator: (value) => value!.isEmpty ? 'Konten tidak boleh kosong' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() && _article != null) {
                    await Provider.of<ArticleProvider>(context, listen: false).updateArticle(
                      _article!.id,
                      _titleController.text,
                      _summaryController.text,
                      _contentController.text,
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Simpan Perubahan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
