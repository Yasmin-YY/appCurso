import 'package:flutter/material.dart';
import 'package:app_curso/screens/home_screen.dart';
import '../database/user_dao.dart';
import '../model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_curso/screens/forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  bool _lembrarUsuario = false;

  @override
  void initState() {
    super.initState();
    _carregarEmailSalvo();
  }

  void _carregarEmailSalvo() async {
    final prefs = await SharedPreferences.getInstance();
    final emailSalvo = prefs.getString('email_salvo');
    if (emailSalvo != null) {
      final user = await UserDao.getUserByEmail(emailSalvo);
      if (user != null) {
        // Login automático
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
        );
      }
    }
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      final senha = _senhaController.text;
      final user = await UserDao.getUserByEmail(email);

      if (user == null || user.password != senha) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Credenciais inválidas')));
        return;
      }

      if (_lembrarUsuario) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('email_salvo', user.email);
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
      );
    }
  }

  void _goToRegister() {
    // Navegar para a tela de registro
  }

  void _goToForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        actions: [
          TextButton(
            onPressed: _goToRegister,
            child: const Text(
              'Registrar-se',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Campo E-mail
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe seu e-mail';
                    }
                    if (!value.contains('@')) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo Senha
                TextFormField(
                  controller: _senhaController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.lock),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Informe sua senha';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Checkbox
                CheckboxListTile(
                  title: const Text('Lembrar usuário'),
                  value: _lembrarUsuario,
                  onChanged: (value) {
                    setState(() {
                      _lembrarUsuario = value ?? false;
                    });
                  },
                ),

                const SizedBox(height: 12),

                // Botão Entrar
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.deepPurple,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _login,
                  child: const Text('Entrar', style: TextStyle(fontSize: 18)),
                ),

                // Link "Esqueci minha senha"
                TextButton(
                  onPressed: _goToForgotPassword,
                  child: const Text('Esqueci minha senha'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
