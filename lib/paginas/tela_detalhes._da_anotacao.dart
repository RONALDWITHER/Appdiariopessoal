import 'package:appdiario/models/anotacoes.dart';
import 'package:flutter/material.dart';

class TelaDetalhesAnotacao extends StatefulWidget {
  final Anotacoes anotacao;

  const TelaDetalhesAnotacao({super.key, required this.anotacao});

  @override
  State<TelaDetalhesAnotacao> createState() => _TelaDetalhesAnotacaoState();
}

class _TelaDetalhesAnotacaoState extends State<TelaDetalhesAnotacao> {
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
              widget.anotacao.titulo_da_anotacao,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Criado em: ${widget.anotacao.dataHorario}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.anotacao.texto_da_anotacao,
              style: const TextStyle(fontSize: 16),
            ),
            SizedBox(height: 50),
            SizedBox(
              height: 350,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: widget.anotacao.urlImagem != null
                          ? Image.network(
                              widget.anotacao.urlImagem!,
                              fit: BoxFit.cover,
                            )
                          : const Text(
                              ' ',
                            ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
