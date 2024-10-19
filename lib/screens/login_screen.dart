import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Función para validar las credenciales de usuario
  Future<void> _login() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    // Solo usa el Navigator si el widget está montado
    if (_emailController.text == storedEmail &&
        _passwordController.text == storedPassword) {
      if (mounted) {
        Navigator.pushNamed(context, '/home'); // Navega a la pantalla de inicio
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Credenciales incorrectas")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration:
                  const InputDecoration(labelText: 'Correo Electrónico'),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text("Iniciar sesión"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(
                    context, '/register'); // Navega a la pantalla de registro
              },
              child: const Text("¿Tienes cuenta? Regístrate"),
            ),
            const Spacer(),
            // Mostrar número de versión y creador en la parte inferior
            const Text(
              "Versión 1.7.0",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            const Text(
              "Creado por Marcelo Baeza",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
