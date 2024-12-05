import 'package:appdiario/paginas/telacadastro.dart';
import 'package:appdiario/paginas/teladeanotar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Telainicial extends StatefulWidget {
  Telainicial({super.key});

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  final user = FirebaseAuth.instance.currentUser;

  void confirmar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Anotação salva com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diário Pessoal',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF32CD99),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF32CD99),
              ),
              child: Column(
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text('Bem-vindo, ${user?.displayName ?? 'Usuário'}!'),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              onTap: () {
                Navigator.pop(context); // Fecha o Drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Telacadastro()),
                );
              },
            ),
          ],
        ),
      ),
      body: const Center(
          child: Column(
        children: [],
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TelaAnotacoes(
                  mensagem: () => confirmar(context),
                ),
              ),
            );
          },
          backgroundColor: const Color(0xFF32CD99),
          label: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
