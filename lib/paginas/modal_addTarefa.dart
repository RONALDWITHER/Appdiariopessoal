import 'package:flutter/material.dart';

class Modal_addTarefa extends StatefulWidget {
  final void Function(String, String, DateTime) salvar;
  final void Function(BuildContext) mensagem;
  const Modal_addTarefa(
      {super.key, required this.salvar, required this.mensagem});

  @override
  State<Modal_addTarefa> createState() => _Modal_addTarefaState();
}

class _Modal_addTarefaState extends State<Modal_addTarefa> {
  TextEditingController _texto_da_anotacao = TextEditingController();
  TextEditingController _titulo_da_anotacao = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 15,
      child: Padding(
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
