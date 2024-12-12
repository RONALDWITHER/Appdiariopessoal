import 'package:appdiario/drawer/calendario.dart';
import 'package:appdiario/paginas/telacadastro.dart';
import 'package:appdiario/paginas/telainicial.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../main.dart'; //

class Configuracoes extends StatefulWidget {
  const Configuracoes({super.key});

  @override
  State<Configuracoes> createState() => _ConfiguracoesState();
}

class _ConfiguracoesState extends State<Configuracoes> {
  final user = FirebaseAuth.instance.currentUser;

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
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Telainicial()));
                },
                icon: Icon(Icons.home))
          ],
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
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Telainicial()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.calendar_month_outlined),
                title: const Text('Calendário'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Calendario()),
                  );
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
                  FirebaseAuth.instance.signOut();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Telacadastro()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(Icons.dark_mode),
                const Text('Alternar Tema'),
                Switch(
                  value: themeNotifier.value == ThemeMode.dark,
                  onChanged: (bool value) {
                    setState(() {
                      themeNotifier.value =
                          value ? ThemeMode.dark : ThemeMode.light;
                    });
                  },
                ),
              ],
            ),
            const Divider(),
          ],
        ));
  }
}
