//import 'dart:ffi';

import 'package:appdiario/models/anotacoes.dart';
import 'package:appdiario/servicos/anotacao_servico.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Anotacao_do_usuario extends StatefulWidget {
  final Anotacoes anotacao;
  final VoidCallback onClick;
  Anotacao_do_usuario(
      {super.key, required this.anotacao, required this.onClick});

  @override
  State<Anotacao_do_usuario> createState() => _Anotacao_do_usuarioState();
}

class _Anotacao_do_usuarioState extends State<Anotacao_do_usuario> {
  AnotacaoServico _anotacaoServico = AnotacaoServico();

  void editarAnotacao(Anotacoes anotacao) {
    TextEditingController editarControlador =
        TextEditingController(text: anotacao.texto_da_anotacao);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editar anotacao'),
        content: TextField(
          controller: editarControlador,
          decoration: const InputDecoration(
            labelText: 'anotacao',
            hintText: 'Edite sua anotacao aqui',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              String novoNome = editarControlador.text.trim();
              if (novoNome.isNotEmpty) {
                setState(() {
                  anotacao.texto_da_anotacao = novoNome;
                });
                await _anotacaoServico.editarAnotacao(anotacao);
              }
              Navigator.of(context).pop(); // Fecha o diálogo
            },
            child: const Text('Salvar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) => editarAnotacao(widget.anotacao),
          backgroundColor: Colors.blue,
          icon: Icons.edit,
        ),
        SlidableAction(
          onPressed: (context) =>
              _anotacaoServico.excluirAnotacao(widget.anotacao),
          backgroundColor: Colors.red,
          icon: Icons.delete,
        )
      ]),
      child: GestureDetector(
        onTap: widget.onClick,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.anotacao.titulo_da_anotacao,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                widget.anotacao.texto_da_anotacao.length > 50
                    ? '${widget.anotacao.texto_da_anotacao.substring(0, widget.anotacao.texto_da_anotacao.length > 200 ? 200 : widget.anotacao.texto_da_anotacao.length)}...'
                    : widget.anotacao.texto_da_anotacao,
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Text(
                'Data: ${widget.anotacao.dataHorario.toString().split(" ")[0]}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}