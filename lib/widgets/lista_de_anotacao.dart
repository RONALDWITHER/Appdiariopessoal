//import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:appdiario/models/anotacoes.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Anotacao_do_usuario extends StatefulWidget {
  final Anotacoes anotacao;
  final VoidCallback onClick;
  final Function(Anotacoes) deletar_anotacao;

  Anotacao_do_usuario(
      {super.key,
      required this.anotacao,
      required this.onClick,
      required this.deletar_anotacao});

  @override
  State<Anotacao_do_usuario> createState() => _Anotacao_do_usuarioState();
}

class _Anotacao_do_usuarioState extends State<Anotacao_do_usuario> {
  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(motion: const ScrollMotion(), children: [
        SlidableAction(
          onPressed: (context) => widget.deletar_anotacao(widget.anotacao),
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
                'Data: ${widget.anotacao.DataHorario.toString().split(" ")[0]}',
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
