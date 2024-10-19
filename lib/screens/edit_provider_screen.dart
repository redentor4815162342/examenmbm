import 'package:flutter/material.dart';
import 'package:examen/models/provider.dart';

class EditProviderScreen extends StatefulWidget {
  final Provider provider;

  const EditProviderScreen({super.key, required this.provider});

  @override
  EditProviderScreenState createState() => EditProviderScreenState();
}

class EditProviderScreenState extends State<EditProviderScreen> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.provider.name);
    _addressController = TextEditingController(text: widget.provider.address);
    _phoneController = TextEditingController(text: widget.provider.phone);
  }

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
      appBar: AppBar(title: const Text("Editar Proveedor")),
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
                  // Actualizar el proveedor y regresar a la pantalla anterior
                  Navigator.pop(
                    context,
                    Provider(
                      id: widget.provider.id,
                      name: _nameController.text,
                      address: _addressController.text,
                      phone: _phoneController.text,
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
