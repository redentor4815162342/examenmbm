import 'package:flutter/material.dart';
import 'package:examen/models/product.dart';

class EditProductScreen extends StatefulWidget {
  final Product product;

  const EditProductScreen({super.key, required this.product});

  @override
  EditProductScreenState createState() => EditProductScreenState();
}

class EditProductScreenState extends State<EditProductScreen> {
  late TextEditingController _nameController;
  late TextEditingController _categoryController;
  late TextEditingController _priceController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.product.name);
    _categoryController = TextEditingController(text: widget.product.category);
    _priceController =
        TextEditingController(text: widget.product.price.toString());
  }

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
      appBar: AppBar(title: const Text("Editar Producto")),
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
                  Navigator.pop(
                    context,
                    Product(
                      id: widget.product.id,
                      name: _nameController.text,
                      category: _categoryController.text,
                      price: double.parse(_priceController.text),
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
