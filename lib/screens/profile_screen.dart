import 'package:flutter/material.dart';
import 'my_articles_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold dan AppBar dihapus, karena sudah di-handle oleh MainScreen
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          SizedBox(height: 20),
          // Profile picture
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            child: Icon(
              Icons.person,
              size: 60,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 20),

          // Name
          Text(
            'ITG News', // Nama default dari akun
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'news@itg.ac.id', // Email default
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 40),

          // Menu items
          ListTile(
            leading: Icon(Icons.article_outlined),
            title: Text('Artikel Saya'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyArticlesScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Pengaturan'),
            trailing: Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              // Aksi untuk pengaturan
            },
          ),

          Spacer(),

          Text(
            'Versi Aplikasi 1.0.0',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
