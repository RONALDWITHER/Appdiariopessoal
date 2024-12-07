import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TelaAnotacoes extends StatefulWidget {
  final void Function(BuildContext) mensagem;
  final void Function(String, String, DateTime) salvar;

  TelaAnotacoes({required this.mensagem, required this.salvar});

  @override
  _TelaAnotacoesState createState() => _TelaAnotacoesState();
}

class _TelaAnotacoesState extends State<TelaAnotacoes> {
  final TextEditingController _texto_da_anotacao = TextEditingController();
  final TextEditingController _titulo_da_anotacao = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  bool _isLoading = false;

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
            const SizedBox(height: 16),
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
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (_titulo_da_anotacao.text.isEmpty ||
                          _texto_da_anotacao.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Preencha o título e o texto!')),
                        );
                        return;
                      }

                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        if (user != null) {
                          await FirebaseFirestore.instance
                              .collection('usuarios')
                              .doc(user!.uid)
                              .collection('anotacoes')
                              .add({
                            'titulo': _titulo_da_anotacao.text,
                            'texto': _texto_da_anotacao.text,
                            'dataHorario': DateTime.now().toIso8601String(),
                          });
                          widget.mensagem(context);
                          _titulo_da_anotacao.clear();
                          _texto_da_anotacao.clear();
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Erro: usuário não autenticado!')),
                          );
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao salvar: $e')),
                        );
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF32CD99),
                    ),
                    child: const Text(
                      'Salvar Anotação',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
