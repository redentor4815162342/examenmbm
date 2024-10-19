import 'package:flutter/material.dart';
import 'package:examen/models/category.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({super.key});

  @override
  AddCategoryScreenState createState() => AddCategoryScreenState();
}

class AddCategoryScreenState extends State<AddCategoryScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Añadir Categoría")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _descriptionController.text.isNotEmpty) {
                  final newCategory = Category(
                    id: DateTime.now().toString(),
                    name: _nameController.text,
                    description: _descriptionController.text,
                  );
                  Navigator.pop(context, newCategory);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Por favor, completa todos los campos")),
                  );
                }
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }
}
