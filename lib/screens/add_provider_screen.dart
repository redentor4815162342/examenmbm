import 'package:flutter/material.dart';
import 'package:examen/models/provider.dart';

class AddProviderScreen extends StatefulWidget {
  const AddProviderScreen({super.key});

  @override
  AddProviderScreenState createState() => AddProviderScreenState();
}

class AddProviderScreenState extends State<AddProviderScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Añadir Proveedor")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Dirección'),
            ),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(labelText: 'Teléfono'),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_nameController.text.isNotEmpty &&
                    _addressController.text.isNotEmpty &&
                    _phoneController.text.isNotEmpty) {
                  final newProvider = Provider(
                    id: DateTime.now().toString(), // Genera un ID único
                    name: _nameController.text,
                    address: _addressController.text,
                    phone: _phoneController.text,
                  );
                  Navigator.pop(
                      context, newProvider); // Retorna el nuevo proveedor
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
