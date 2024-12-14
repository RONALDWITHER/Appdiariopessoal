import 'package:appdiario/drawer/calendario.dart';
import 'package:appdiario/paginas/telaDeLogin.dart';
import 'package:appdiario/paginas/telainicial.dart';
import 'package:flutter/material.dart';
import 'package:appdiario/main.dart';

class DrawerTelainicial extends StatefulWidget {
  final String user;
  const DrawerTelainicial({super.key, required this.user});

  @override
  _DrawerTelainicialState createState() => _DrawerTelainicialState();
}

class _DrawerTelainicialState extends State<DrawerTelainicial> {
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
                Text('Bem-vindo, ${widget.user}'),
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
              leading: const Icon(Icons.dark_mode),
              title: const Text('Alternar Tema'),
              trailing: Switch(
                value: themeNotifier.value == ThemeMode.dark,
                onChanged: (bool value) {
                  setState(() {
                    themeNotifier.value =
                        value ? ThemeMode.dark : ThemeMode.light;
                  });
                },
              )),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              Navigator.pop(context);
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
