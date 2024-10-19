import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:examen/models/provider.dart';
import 'package:examen/screens/provider_details_screen.dart';
import 'package:examen/screens/edit_provider_screen.dart';
import 'package:examen/screens/add_provider_screen.dart';

class ProvidersScreen extends StatefulWidget {
  const ProvidersScreen({super.key});

  @override
  ProvidersScreenState createState() => ProvidersScreenState();
}

class ProvidersScreenState extends State<ProvidersScreen> {
  List<Provider> providers = [];

  @override
  void initState() {
    super.initState();
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    final prefs = await SharedPreferences.getInstance();
    final String? providersJson = prefs.getString('providers');
    if (providersJson != null) {
      final List<dynamic> providerList = json.decode(providersJson);
      setState(() {
        providers = providerList.map((json) => Provider.fromMap(json)).toList();
      });
    } else {
      // Si no hay proveedores guardados, cargar un ejemplo
      _loadExampleProviders();
    }
  }

  void _loadExampleProviders() {
    setState(() {
      providers = [
        Provider(
            id: '1',
            name: 'Homecenter',
            address: 'Pajaritos 7777',
            phone: '56-233453566'),
        Provider(
            id: '2',
            name: 'Easy',
            address: 'Americo Vespucio 420',
            phone: '56-233445567'),
      ];
    });
  }

  Future<void> _saveProviders() async {
    final prefs = await SharedPreferences.getInstance();
    final String providersJson =
        json.encode(providers.map((provider) => provider.toMap()).toList());
    await prefs.setString('providers', providersJson);
  }

  void _deleteProvider(String id) async {
    setState(() {
      providers.removeWhere((provider) => provider.id == id);
    });
    _saveProviders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Proveedores")),
      body: ListView.builder(
        itemCount: providers.length,
        itemBuilder: (context, index) {
          final provider = providers[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                child: Text(provider.name[0].toUpperCase()),
              ),
              title: Text(provider.name,
                  style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text(provider.address),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () async {
                      // Navegar a la pantalla de edición y esperar el resultado
                      final updatedProvider = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProviderScreen(provider: provider),
                        ),
                      );
                      if (updatedProvider != null) {
                        setState(() {
                          providers[index] = updatedProvider;
                        });
                        _saveProviders(); // Guardar cambios en shared_preferences
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      _deleteProvider(provider.id);
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ProviderDetailsScreen(provider: provider),
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newProvider = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProviderScreen()),
          );
          if (newProvider != null) {
            setState(() {
              providers.add(newProvider);
            });
            _saveProviders();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
