import 'package:appdiario/drawer/calendario.dart';
import 'package:appdiario/models/anotacoes.dart';
import 'package:appdiario/paginas/telaDeLogin.dart';
import 'package:appdiario/paginas/teladeanotar.dart';
import 'package:appdiario/widgets/lista_de_anotacao.dart';
import 'package:appdiario/widgets/tela_detalhes._da_anotacao.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Telainicial extends StatefulWidget {
  Telainicial({super.key});

  @override
  State<Telainicial> createState() => _TelainicialState();
}

class _TelainicialState extends State<Telainicial> {
  final user = FirebaseAuth.instance.currentUser;

  List<Anotacoes> anotacoes_do_usuario = [];
  Anotacoes? anotacao_deletada;
  int? indice_da_tarefa_del;

  // Adiciona nova anotação
  void salvar_as_anotacoes(String titulo_Da_Anotacao, String texto_Da_Anotacao,
      DateTime DataHorario) {
    Anotacoes novaAnotacao = Anotacoes(
      titulo_da_anotacao: titulo_Da_Anotacao,
      DataHorario: DataHorario,
      texto_da_anotacao: texto_Da_Anotacao,
    );

    setState(() {
      anotacoes_do_usuario.add(novaAnotacao);
    });
  }

  // Deleta uma anotação
  void deletar_anotacao(String idAnotacao) async {
    try {
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(user!.uid)
          .collection('anotacoes')
          .doc(idAnotacao)
          .delete();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Anotação removida com sucesso!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erro ao deletar anotação!')),
      );
    }
  }

  // Exibe mensagem de confirmação
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFF32CD99),
              ),
              child: Column(
                children: [
                  const Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  Text('Bem-vindo, ${user?.displayName ?? 'Usuário'}!'),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month_outlined),
              title: const Text('Calendário'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Calendario()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const telaDelogin()),
                );
              },
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user!.uid)
            .collection('anotacoes')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhuma anotação encontrada.'));
          }

          final anotacoes = snapshot.data!.docs;

          return ListView.builder(
            itemCount: anotacoes.length,
            itemBuilder: (context, index) {
              final anotacao = anotacoes[index];
              final idAnotacao = anotacao.id;
              final titulo = anotacao['titulo'];
              final texto = anotacao['texto'];
              final dataHorario = anotacao['dataHorario'];

              return Anotacao_do_usuario(
                anotacao: Anotacoes(
                  titulo_da_anotacao: titulo,
                  texto_da_anotacao: texto,
                  DataHorario: DateTime.parse(dataHorario),
                ),
                deletar_anotacao: (anotacao) => deletar_anotacao(idAnotacao),
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaDetalhesAnotacao(
                        anotacao: Anotacoes(
                          titulo_da_anotacao: titulo,
                          texto_da_anotacao: texto,
                          DataHorario: DateTime.parse(dataHorario),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TelaAnotacoes(
                mensagem: confirmar,
                salvar: salvar_as_anotacoes,
              ),
            ),
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
