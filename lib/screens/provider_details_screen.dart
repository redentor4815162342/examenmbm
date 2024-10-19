import 'package:flutter/material.dart';
import 'package:examen/models/provider.dart';

class ProviderDetailsScreen extends StatelessWidget {
  final Provider provider;

  const ProviderDetailsScreen({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(provider.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nombre: ${provider.name}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Dirección: ${provider.address}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text("Teléfono: ${provider.phone}",
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
