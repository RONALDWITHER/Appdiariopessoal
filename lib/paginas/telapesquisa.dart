import 'package:flutter/material.dart';
import 'package:appdiario/models/anotacoes.dart';
import 'package:appdiario/servicos/anotacao_servico.dart';
import 'package:appdiario/paginas/tela_detalhes._da_anotacao.dart';

class TelaPesquisa extends StatefulWidget {
  const TelaPesquisa({super.key});

  @override
  State<TelaPesquisa> createState() => _TelaPesquisaState();
}

class _TelaPesquisaState extends State<TelaPesquisa> {
  final TextEditingController _controladorPesquisa = TextEditingController();
  AnotacaoServico _anotacaoServico = AnotacaoServico();
  List<Anotacoes> _resultadosPesquisa = [];

  void _realizarPesquisa(String query) async {
    if (query.isNotEmpty) {
      List<Anotacoes> resultados =
          await _anotacaoServico.buscarAnotacoesPorTitulo(query);
      setState(() {
        _resultadosPesquisa = resultados;
      });
    } else {
      setState(() {
        _resultadosPesquisa = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _controladorPesquisa,
          decoration: const InputDecoration(
            hintText: 'Pesquisar pelo título...',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Color.fromARGB(179, 255, 255, 255)),
          ),
          style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255), fontSize: 18),
          onChanged: (query) => _realizarPesquisa(query),
        ),
        backgroundColor: const Color(0xFF32CD99),
        iconTheme:
            const IconThemeData(color: Color.fromARGB(255, 255, 255, 255)),
      ),
      body: _resultadosPesquisa.isNotEmpty
          ? ListView.builder(
              itemCount: _resultadosPesquisa.length,
              itemBuilder: (context, index) {
                final anotacao = _resultadosPesquisa[index];
                return ListTile(
                  title: Text(anotacao.titulo_da_anotacao),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TelaDetalhesAnotacao(anotacao: anotacao),
                      ),
                    );
                  },
                );
              },
            )
          : const Center(
              child: Text(
                'Nenhuma anotação encontrada.',
                style: TextStyle(fontSize: 16),
              ),
            ),
    );
  }
}
