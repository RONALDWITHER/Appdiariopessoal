import 'package:appdiario/models/anotacoes.dart';
import 'package:appdiario/servicos/anotacao_servico.dart';
import 'package:flutter/material.dart';

class Tela_editarAnotacao extends StatefulWidget {
  Tela_editarAnotacao({super.key, required this.anotacao});

  Anotacoes anotacao;

  @override
  State<Tela_editarAnotacao> createState() => _Tela_editarAnotacaoState();
}

class _Tela_editarAnotacaoState extends State<Tela_editarAnotacao> {
  late TextEditingController controlar_titulo;
  late TextEditingController controlar_texto;
  AnotacaoServico _anotacaoServico = AnotacaoServico();

  @override
  void initState() {
    super.initState();
    controlar_titulo =
        TextEditingController(text: widget.anotacao.titulo_da_anotacao);
    controlar_texto =
        TextEditingController(text: widget.anotacao.texto_da_anotacao);
  }

  @override
  void dispose() {
    controlar_titulo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edição de anotação',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF32CD99),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controlar_titulo,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              decoration: InputDecoration(),
            ),
            TextField(
              controller: controlar_texto,
              decoration: InputDecoration(
                border: InputBorder.none,
              ),
              maxLines: null,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          String novo_titulo = controlar_titulo.text;
          String novo_texto = controlar_texto.text;

          if (novo_titulo.isNotEmpty || novo_texto.isNotEmpty) {
            setState(() {
              widget.anotacao.titulo_da_anotacao = novo_titulo;
              widget.anotacao.texto_da_anotacao = novo_texto;
            });
          }
          await _anotacaoServico.editarAnotacao(widget.anotacao);
          Navigator.pop(context);
        },
        backgroundColor: const Color(0xFF32CD99),
        label: Text(
          'Salvar alteraões',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
