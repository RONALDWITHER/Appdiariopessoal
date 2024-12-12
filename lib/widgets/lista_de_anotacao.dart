import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import '../models/anotacoes.dart';
import '../servicos/anotacao_servico.dart';
import '../paginas/tela_edicao.dart';
import 'package:share_plus/share_plus.dart';

class Anotacao_do_usuario extends StatefulWidget {
  final Anotacoes anotacao;
  final VoidCallback onClick;

  Anotacao_do_usuario({
    super.key,
    required this.anotacao,
    required this.onClick,
  });

  @override
  State<Anotacao_do_usuario> createState() => _Anotacao_do_usuarioState();
}

class _Anotacao_do_usuarioState extends State<Anotacao_do_usuario> {
  final AnotacaoServico _anotacaoServico = AnotacaoServico();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Tela_editarAnotacao(
                    anotacao: widget.anotacao,
                  ),
                ),
              );
            },
            backgroundColor: Colors.blue,
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: (context) {
              String dataFormatada =
                  DateFormat('dd/MM/yyyy').format(widget.anotacao.dataHorario);

              String anotacao = '''
-- *Título: ${widget.anotacao.titulo_da_anotacao}*

-- Texto : ${widget.anotacao.texto_da_anotacao}

*-- Data : $dataFormatada*
'''
                  .trim();

              String anotacaoFormatada =
                  anotacao.trim().replaceAll(RegExp(r'\s+'), ' ');
              Share.share(anotacaoFormatada);
            },
            backgroundColor: Colors.green,
            icon: Icons.share,
          ),
          SlidableAction(
            onPressed: (context) =>
                _anotacaoServico.excluirAnotacaoComImagem(widget.anotacao),
            backgroundColor: Colors.red,
            icon: Icons.delete,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: widget.onClick,
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor, // Cor do tema atual
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.anotacao.urlImagem != null &&
                  widget.anotacao.urlImagem!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      widget.anotacao.urlImagem!,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 60),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return SizedBox(
                          width: 60,
                          height: 60,
                          child: Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              // Detalhes da anotação
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.anotacao.titulo_da_anotacao,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.anotacao.texto_da_anotacao.length > 50
                          ? '${widget.anotacao.texto_da_anotacao.substring(0, 50)}...'
                          : widget.anotacao.texto_da_anotacao,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 14,
                          ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Data: ${widget.anotacao.dataHorario.toString().split(" ")[0]}',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            fontSize: 12,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
