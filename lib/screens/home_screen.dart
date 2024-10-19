import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestión de Inventario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2, // Mostrar 2 tarjetas por fila
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: <Widget>[
            buildCard(
              context,
              'Proveedores',
              Icons.business,
              const Color.fromARGB(172, 238, 238, 9),
              '/providers',
            ),
            buildCard(
              context,
              'Categorías',
              Icons.category,
              const Color.fromARGB(255, 255, 180, 236),
              '/categories',
            ),
            buildCard(
              context,
              'Productos',
              Icons.shopping_bag,
              const Color.fromARGB(255, 243, 175, 72),
              '/products',
            ),
          ],
        ),
      ),
    );
  }

  // Función para construir las tarjetas con InkWell
  Widget buildCard(BuildContext context, String title, IconData icon,
      Color color, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
            context, route); // Navegar a la ruta correspondiente
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Card(
          elevation: 8, // Sombra para la tarjeta
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Bordes redondeados
          ),
          color: color,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                icon,
                size: 60,
                color: Colors.white, // Color del ícono
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, // Color del texto
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
