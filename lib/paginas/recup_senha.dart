import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaRecuperacaoSenha extends StatefulWidget {
  const TelaRecuperacaoSenha({super.key});

  @override
  _TelaRecuperacaoSenhaState createState() => _TelaRecuperacaoSenhaState();
}

class _TelaRecuperacaoSenhaState extends State<TelaRecuperacaoSenha> {
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _recuperarSenha() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
        email: _emailController.text.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Link enviado com sucesso!")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Recuperar Senha"),
        backgroundColor: const Color(0xFF32CD99),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Digite seu e-mail para recuperar a senha',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: "E-mail",
                hintText: "Digite seu e-mail",
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _recuperarSenha,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF32CD99),
              ),
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
