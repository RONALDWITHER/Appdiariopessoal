import 'package:appdiario/models/anotacoes.dart';
import 'package:appdiario/paginas/tela_detalhes._da_anotacao.dart';
import 'package:appdiario/paginas/teladeanotar.dart';
import 'package:appdiario/paginas/telapesquisa.dart';
import 'package:appdiario/servicos/anotacao_servico.dart';
import 'package:appdiario/widgets/drawer_telaInicial.dart';
import 'package:appdiario/widgets/lista_de_anotacao.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Telainicial extends StatefulWidget {
  Telainicial({super.key});

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  final user = FirebaseAuth.instance.currentUser;

  AnotacaoServico _anotacaservico = AnotacaoServico();
  Anotacoes? anotacao_deletada;
  int? indice_da_tarefa_del;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Diário Pessoal',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF32CD99),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TelaPesquisa(),
                ),
              );
            },
          ),
        ],
      ),
      drawer: DrawerTelainicial(user: user?.displayName ?? 'Usuário'),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Flexible(
                child: StreamBuilder(
                  stream: _anotacaservico.conectarStreamTarefas(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else {
                      if (snapshot.hasData &&
                          snapshot.data != null &&
                          snapshot.data!.docs.isNotEmpty) {
                        List<Anotacoes> anotacoesDoUsuario = [];
                        for (var doc in snapshot.data!.docs) {
                          anotacoesDoUsuario.add(Anotacoes.fromMap(doc.data()));
                        }
                        return ListView(
                          shrinkWrap: true,
                          children: [
                            for (Anotacoes anotacao in anotacoesDoUsuario)
                              Anotacao_do_usuario(
                                anotacao: anotacao,
                                onClick: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TelaDetalhesAnotacao(
                                              anotacao: anotacao),
                                    ),
                                  );
                                },
                              ),
                            const SizedBox(height: 30),
                          ],
                        );
                      } else {
                        return const Text('Adicione uma anotação...');
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TelaAnotacoes()),
          );
        },
        backgroundColor: const Color(0xFF32CD99),
        label: const Icon(
          Icons.add,
          color: Colors.white,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
