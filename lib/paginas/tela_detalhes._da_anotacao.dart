import 'package:appdiario/models/anotacoes.dart';
import 'package:flutter/material.dart';

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
                                    Expanded(
                                      child: const Center(
                                        child: Text('Carregando imagem...'),
                                      ),
                                    ),
                                    LinearProgressIndicator(
                                      value: _loadingProgress,
                                      backgroundColor: Colors.grey[300],
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
                                  style: TextStyle(color: Colors.red),
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
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
