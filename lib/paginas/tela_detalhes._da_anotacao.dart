import 'package:appdiario/models/anotacoes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TelaDetalhesAnotacao extends StatefulWidget {
  final Anotacoes anotacao;

  const TelaDetalhesAnotacao({super.key, required this.anotacao});

  @override
  State<TelaDetalhesAnotacao> createState() => _TelaDetalhesAnotacaoState();
}

class _TelaDetalhesAnotacaoState extends State<TelaDetalhesAnotacao> {
  double _loadingProgress = 0.0;

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
              'Criado em: ${DateFormat('dd/MM/yyyy HH:mm').format(widget.anotacao.dataHorario)}',
              style: const TextStyle(
                fontSize: 14,
                color: Color.fromARGB(255, 158, 158, 158),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.anotacao.texto_da_anotacao,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            SizedBox(
              height: 350,
              child: widget.anotacao.urlImagem != null &&
                      widget.anotacao.urlImagem!.isNotEmpty
                  ? Column(
                      children: [
                        Expanded(
                          child: Image.network(
                            widget.anotacao.urlImagem!,
                            fit: BoxFit.contain,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                _loadingProgress = (loadingProgress
                                            .cumulativeBytesLoaded /
                                        (loadingProgress.expectedTotalBytes ??
                                            1))
                                    .clamp(0.0, 1.0);
                                return Column(
                                  children: [
                                    const Expanded(
                                      child: const Center(
                                        child: Text('Carregando imagem...'),
                                      ),
                                    ),
                                    LinearProgressIndicator(
                                      value: _loadingProgress,
                                      backgroundColor: const Color.fromARGB(
                                          255, 224, 224, 224),
                                      color: const Color(0xFF32CD99),
                                    ),
                                  ],
                                );
                              }
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Center(
                                child: Text(
                                  'Erro ao carregar imagem.',
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 241, 68, 55)),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    )
                  : const Center(
                      child: Text(
                        'Nenhuma imagem anexada.',
                        style: TextStyle(
                            color: Color.fromARGB(255, 158, 158, 158)),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
