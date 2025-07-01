import 'package:flutter/material.dart';
import 'my_articles_screen.dart';

class ProfileScreen extends StatelessWidget {
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
          '9:41',
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            
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
              'Endog Lini',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),
            
            // Menu items
            ListTile(
              leading: Icon(Icons.article),
              title: Text('Artikel Anda'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyArticlesScreen()),
                );
              },
            ),
            
            Spacer(),
            
            // Add button
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add-article');
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
