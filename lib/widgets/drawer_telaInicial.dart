import 'package:appdiario/drawer/calendario.dart';
import 'package:appdiario/paginas/telaDeLogin.dart';
import 'package:appdiario/paginas/telainicial.dart';
import 'package:flutter/material.dart';
import 'package:appdiario/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DrawerTelainicial extends StatefulWidget {
  final String user;
  const DrawerTelainicial({super.key, required this.user});

  @override
  _DrawerTelainicialState createState() => _DrawerTelainicialState();
}

class _DrawerTelainicialState extends State<DrawerTelainicial> {
  @override
  final user = FirebaseAuth.instance.currentUser;

  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF32CD99), Color(0xFF008080)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            padding: EdgeInsets.only(bottom: 20), // Ajusta o tamanho
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: user?.photoURL != null
                      ? NetworkImage(user!.photoURL!)
                      : const AssetImage('assets/profile_placeholder.png')
                          as ImageProvider,
                  backgroundColor: Colors.white,
                ),
                const SizedBox(height: 5),
                Text(
                  'Bem-vindo, ${widget.user}',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
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
                MaterialPageRoute(builder: (context) => const Telainicial()),
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
                MaterialPageRoute(builder: (context) => const Calendario()),
              );
            },
          ),
          ListTile(
            leading: Icon(
              themeNotifier.value == ThemeMode.dark
                  ? Icons.nightlight_round
                  : Icons.wb_sunny,
            ),
            title: const Text('Alternar Tema'),
            trailing: Switch(
              value: themeNotifier.value == ThemeMode.dark,
              onChanged: (bool value) async {
                await toggleTheme(value);
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const TeladeLogin()),
              );
            },
          ),
        ],
      ),
    );
  }
}
