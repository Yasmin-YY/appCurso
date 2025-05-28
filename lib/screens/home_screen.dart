import 'package:flutter/material.dart';
import '../model/user_model.dart';
import 'login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});
  void _logout(BuildContext context) async {
    // Limpa o e-mail salvo nas preferências
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('email_salvo');
    // Redireciona para a tela de login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Principal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Colors.blue,
              child: Text(
                user.email[0]
                    .toUpperCase(), // Exibe a primeira letra do nome/email
                style: const TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Bem-vindo, ${user.email}!',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica adicional para outras funcionalidades do app
              },
              child: const Text('Ir para a funcionalidade X'),
            ),
          ],
        ),
      ),
    );
  }
}
