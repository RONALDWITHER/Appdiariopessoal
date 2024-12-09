import 'package:appdiario/models/anotacoes.dart';
import 'package:appdiario/paginas/modal_addTarefa.dart';
import 'package:appdiario/paginas/tela_detalhes._da_anotacao.dart';
import 'package:appdiario/servicos/anotacao_servico.dart';
import 'package:appdiario/widgets/drawer_telaInicial.dart';
import 'package:appdiario/widgets/lista_de_anotacao.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

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

  void salvar_as_anotacoes(String titulo_Da_Anotacao, String texto_Da_Anotacao,
      DateTime dataHorario) {
    Anotacoes novaAnotacao = Anotacoes(
        id: const Uuid().v1(),
        titulo_da_anotacao: titulo_Da_Anotacao,
        dataHorario: dataHorario,
        texto_da_anotacao: texto_Da_Anotacao);
    _anotacaservico.adicionarTarefa(novaAnotacao);
  }

  void confirmar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Anotação salva com sucesso!')),
    );
  }

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
                      return Center(
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
                        return Text('Adicione uma anotação...');
                      }
                    }
                  }),
            )
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return Modal_addTarefa(
                  mensagem: confirmar,
                  salvar: salvar_as_anotacoes,
                ); // Substitua por seu widget
              },
            );
          },
          backgroundColor: const Color(0xFF32CD99),
          label: const Icon(
            Icons.add,
            color: Colors.white,
            size: 30,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
