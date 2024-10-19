import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/providers_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/products_screen.dart';
import 'screens/register_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gestión de Inventario',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blueAccent,
          elevation: 1,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16.0, color: Colors.black87),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.blueAccent,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/providers': (context) => const ProvidersScreen(),
        '/categories': (context) => const CategoriesScreen(),
        '/products': (context) => const ProductsScreen(),
      },
    );
  }
}
