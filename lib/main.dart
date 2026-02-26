import 'package:flutter/material.dart';

// 🔥 Firebase
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// 📄 Páginas
import 'pages/home_page.dart';
import 'pages/catalog_page.dart';
import 'pages/about_page.dart';
import 'pages/contact_page.dart';

Future<void> main() async {
  // 🔑 Necesario para Firebase
  WidgetsFlutterBinding.ensureInitialized();

  // 🔥 Inicialización Firebase (WEB / ANDROID / IOS)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Zoe's Crochet",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8B7355),
          background: const Color(0xFFFAF8F5),
        ),
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/catalog': (context) => const CatalogPage(),
        '/about': (context) => const AboutPage(),
        '/contact': (context) => const ContactPage(),
      },
    );
  }
}
