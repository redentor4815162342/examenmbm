import 'package:flutter/material.dart';
import 'package:examen/models/product.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  AddProductScreenState createState() => AddProductScreenState();
}

class AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _categoryController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Añadir Producto")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration:
                  const InputDecoration(labelText: 'Nombre del Producto'),
            ),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
            TextField(
              controller: _priceController,
              decoration: const InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _categoryController.text.isNotEmpty &&
                    _priceController.text.isNotEmpty) {
                  final newProduct = Product(
                    id: DateTime.now().toString(),
                    name: _nameController.text,
                    category: _categoryController.text,
                    price: double.parse(_priceController.text),
                  );
                  Navigator.pop(context, newProduct);
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
