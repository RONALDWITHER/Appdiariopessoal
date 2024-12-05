import 'package:appdiario/paginas/telaDeLogin.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class Logotela extends StatefulWidget {
  @override
  _LogotelaState createState() => _LogotelaState();
}

class _LogotelaState extends State<Logotela> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => telaDelogin()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 280),
          Image.asset(
            'assets/imagens/logo.png',
            width: 300,
            height: 300,
          ),
        ],
      )),
      backgroundColor: const Color(0xFF32CD99),
    );
  }
}
