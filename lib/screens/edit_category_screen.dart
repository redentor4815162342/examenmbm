import 'package:flutter/material.dart';
import 'package:examen/models/category.dart';

class EditCategoryScreen extends StatefulWidget {
  final Category category;

  const EditCategoryScreen({super.key, required this.category});

  @override
  EditCategoryScreenState createState() => EditCategoryScreenState();
}

class EditCategoryScreenState extends State<EditCategoryScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.category.name);
    _descriptionController =
        TextEditingController(text: widget.category.description);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Editar Categoría")),
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
                  Navigator.pop(
                    context,
                    Category(
                      id: widget.category.id,
                      name: _nameController.text,
                      description: _descriptionController.text,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text("Por favor, completa todos los campos")),
                  );
                }
              },
              child: const Text("Guardar Cambios"),
            ),
          ],
        ),
      ),
    );
  }
}
