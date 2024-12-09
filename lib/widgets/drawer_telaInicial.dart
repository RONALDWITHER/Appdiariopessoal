import 'package:appdiario/drawer/calendario.dart';
import 'package:appdiario/paginas/telaDeLogin.dart';
import 'package:flutter/material.dart';

class DrawerTelainicial extends StatelessWidget {
  String user;

  DrawerTelainicial({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                Text('Bem-vindo, $user'),
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
              Navigator.pop(context); // Fecha o Drawer
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const telaDelogin()),
              );
            },
          ),
        ],
      ),
    );
  }
}
