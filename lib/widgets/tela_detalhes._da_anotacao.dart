import 'package:flutter/material.dart';
import 'package:appdiario/models/anotacoes.dart';

class TelaDetalhesAnotacao extends StatelessWidget {
  final Anotacoes anotacao;

  const TelaDetalhesAnotacao({super.key, required this.anotacao});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes da Anotação'),
        backgroundColor: const Color(0xFF32CD99),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0), 
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              anotacao.titulo_da_anotacao,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Criado em: ${anotacao.DataHorario}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              anotacao.texto_da_anotacao,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
