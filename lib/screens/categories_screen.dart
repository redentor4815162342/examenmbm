import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:examen/models/category.dart';
import 'package:examen/screens/add_category_screen.dart';
import 'package:examen/screens/edit_category_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  CategoriesScreenState createState() => CategoriesScreenState();
}

class CategoriesScreenState extends State<CategoriesScreen> {
  List<Category> categories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  // Cargar categorías desde shared_preferences o agregar ejemplos
  Future<void> _loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String? categoriesJson = prefs.getString('categories');
    if (categoriesJson != null) {
      final List<dynamic> categoryList = json.decode(categoriesJson);
      setState(() {
        categories =
            categoryList.map((json) => Category.fromMap(json)).toList();
      });
    } else {
      // Si no hay categorías, cargar ejemplos
      _loadExampleCategories();
    }
  }

  // Cargar ejemplos de categorías si no hay datos guardados
  void _loadExampleCategories() {
    setState(() {
      categories = [
        Category(
            id: '1', name: 'Electricidad', description: 'Productos electricos'),
        Category(id: '2', name: 'Muebles', description: 'Muebles en general'),
      ];
    });
  }

  // Guardar categorías en shared_preferences
  Future<void> _saveCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final String categoriesJson =
        json.encode(categories.map((category) => category.toMap()).toList());
    await prefs.setString('categories', categoriesJson);
  }

  // Eliminar una categoría y guardar
  void _deleteCategory(String id) async {
    setState(() {
      categories.removeWhere((category) => category.id == id);
    });
    _saveCategories();
  }

  // Añadir una nueva categoría
  Future<void> _addCategory() async {
    final newCategory = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddCategoryScreen(),
      ),
    );
    if (newCategory != null) {
      setState(() {
        categories.add(newCategory);
      });
      _saveCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categorías")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.greenAccent,
                child: Text(category.name[0].toUpperCase()),
              ),
              title: Text(category.name,
                  style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text(category.description),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () async {
                      final updatedCategory = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditCategoryScreen(category: category),
                        ),
                      );
                      if (updatedCategory != null) {
                        setState(() {
                          categories[index] = updatedCategory;
                        });
                        _saveCategories(); // Guardar los cambios
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      _deleteCategory(category.id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addCategory,
        child: const Icon(Icons.add),
      ),
    );
  }
}
