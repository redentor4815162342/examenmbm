import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>(); // Clave del formulario para validar
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Expresión regular para validar el formato del correo
  String? _validateEmail(String? value) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty) {
      return 'El correo es obligatorio';
    } else if (!regex.hasMatch(value)) {
      return 'Por favor, ingrese un correo válido'; // Si no coincide con el patrón
    }
    return null; // Si es válido
  }

  // Validación para una contraseña segura
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'La contraseña es obligatoria';
    } else if (value.length < 8) {
      return 'La contraseña debe tener al menos 8 caracteres';
    } else if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'La contraseña debe tener al menos una letra mayúscula';
    } else if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'La contraseña debe tener al menos una letra minúscula';
    } else if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'La contraseña debe tener al menos un número';
    } else if (!RegExp(r'[!@#\$&*~]').hasMatch(value)) {
      return 'La contraseña debe tener al menos un carácter especial (!@#\$&*~)';
    }
    return null; // Si la contraseña cumple todos los requisitos
  }

  // Función para guardar los datos en SharedPreferences
  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _nameController.text);
      await prefs.setString('email', _emailController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setBool('isRegistered', true);

      // Verifica si el widget sigue montado antes de usar el BuildContext
      if (mounted) {
        // Opcional: muestra un mensaje de confirmación y redirige al login
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Usuario registrado exitosamente")),
        );
        Navigator.pop(context); // Vuelve a la pantalla de login
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Registro")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Clave del formulario
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration:
                    const InputDecoration(labelText: 'Correo Electrónico'),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail, // Validar el correo
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Contraseña'),
                obscureText: true, // Ocultar la contraseña
                validator: _validatePassword, // Validar la contraseña segura
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveUserData, // Guardar los datos tras validación
                child: const Text("Registrar"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Vuelve a la pantalla de login
                },
                child: const Text("Si ya tienes cuenta - Inicia sesión"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
