import 'package:flutter/material.dart';

class TelaAnotacoes extends StatefulWidget {
  final void Function(String, String, DateTime) salvar;
  final void Function(BuildContext) mensagem;

  TelaAnotacoes({required this.mensagem, required this.salvar});

  @override
  _TelaAnotacoesState createState() => _TelaAnotacoesState();
}

class _TelaAnotacoesState extends State<TelaAnotacoes> {
  TextEditingController _texto_da_anotacao = TextEditingController();
  TextEditingController _titulo_da_anotacao = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Anotação',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF32CD99),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titulo_da_anotacao,
              decoration: const InputDecoration(hintText: "Título"),
            ),
            SizedBox(height: 2),
            Flexible(
              child: TextField(
                controller: _texto_da_anotacao,
                decoration: const InputDecoration(
                  hintText: 'Comece a escrever...',
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                widget.salvar(_titulo_da_anotacao.text, _texto_da_anotacao.text,
                    DateTime.now());
                widget.mensagem(context); // Chama o callback
                Navigator.pop(context); // Fecha a tela
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF32CD99),
              ),
              child: const Text('Salvar Anotação',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
