import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'providers/article_provider.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/main_screen.dart';
import 'screens/add_article_screen.dart';
import 'screens/edit_article_screen.dart';
import 'screens/article_detail_screen.dart';

void main() {
  runApp(
    // Menyediakan provider ke seluruh widget tree
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Newzly',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      // Gunakan FutureBuilder untuk memeriksa token saat aplikasi dimulai
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SplashScreen(); // Tampilkan splash screen saat menunggu
          }

          // Periksa jika snapshot memiliki data dan tidak null
          if (snapshot.hasData && snapshot.data != null) {
            final prefs = snapshot.data!;
            final token = prefs.getString('token');

            if (token != null && token.isNotEmpty) {
              return MainScreen(); // Jika ada token, langsung ke main screen
            }
          }

          // Jika tidak ada data atau token, ke login screen
          return LoginScreen();
        },
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/main': (context) => MainScreen(),
        '/add-article': (context) => AddArticleScreen(),
        '/edit-article': (context) => EditArticleScreen(),
        '/article-detail': (context) => ArticleDetailScreen(),
      },
    );
  }
}
