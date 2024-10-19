import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:examen/models/product.dart';
import 'package:examen/screens/add_product_screen.dart';
import 'package:examen/screens/edit_product_screen.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  ProductsScreenState createState() => ProductsScreenState();
}

class ProductsScreenState extends State<ProductsScreen> {
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  // Cargar productos desde shared_preferences o cargar ejemplos si no hay datos
  Future<void> _loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String? productsJson = prefs.getString('products');
    if (productsJson != null) {
      final List<dynamic> productList = json.decode(productsJson);
      setState(() {
        products = productList.map((json) => Product.fromMap(json)).toList();
      });
    } else {
      // Si no hay productos guardados, cargar ejemplos
      _loadExampleProducts();
    }
  }

  // Cargar ejemplos de productos si no hay datos
  void _loadExampleProducts() {
    setState(() {
      products = [
        Product(id: '1', name: 'Sofa', category: 'Muebles', price: 200000),
        Product(
            id: '2',
            name: 'Interruptor',
            category: 'Electricidad',
            price: 5500),
      ];
    });
  }

  // Guardar productos en shared_preferences
  Future<void> _saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final String productsJson =
        json.encode(products.map((product) => product.toMap()).toList());
    await prefs.setString('products', productsJson);
  }

  // Eliminar un producto y guardar
  void _deleteProduct(String id) async {
    setState(() {
      products.removeWhere((product) => product.id == id);
    });
    _saveProducts();
  }

  // Añadir un nuevo producto
  Future<void> _addProduct() async {
    final newProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddProductScreen(),
      ),
    );
    if (newProduct != null) {
      setState(() {
        products.add(newProduct);
      });
      _saveProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Productos")),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.orangeAccent,
                child: Text(product.name[0].toUpperCase()),
              ),
              title: Text(product.name,
                  style: Theme.of(context).textTheme.titleLarge),
              subtitle: Text(
                  "Categoría: ${product.category} - Precio: \$${product.price.toStringAsFixed(2)}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blueAccent),
                    onPressed: () async {
                      final updatedProduct = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EditProductScreen(product: product),
                        ),
                      );
                      if (updatedProduct != null) {
                        setState(() {
                          products[index] = updatedProduct;
                        });
                        _saveProducts();
                      }
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.redAccent),
                    onPressed: () {
                      _deleteProduct(product.id);
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addProduct,
        child: const Icon(Icons.add),
      ),
    );
  }
}
