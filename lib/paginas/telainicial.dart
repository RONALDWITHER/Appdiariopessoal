import 'package:appdiario/drawer/calendario.dart';
import 'package:appdiario/models/anotacoes.dart';
import 'package:appdiario/paginas/telaDeLogin.dart';
import 'package:appdiario/paginas/telacadastro.dart';
import 'package:appdiario/paginas/teladeanotar.dart';
import 'package:appdiario/widgets/lista_de_anotacao.dart';
import 'package:appdiario/widgets/tela_detalhes._da_anotacao.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

  void salvar_as_anotacoes(String titulo_Da_Anotacao, String texto_Da_Anotacao,
      DateTime DataHorario) {
    Anotacoes novaAnotacao = Anotacoes(
        titulo_da_anotacao: titulo_Da_Anotacao,
        DataHorario: DataHorario,
        texto_da_anotacao: texto_Da_Anotacao);

    setState(() {
      anotacoes_do_usuario.add(novaAnotacao);
    });
  }

  void deletar_anotacao(Anotacoes anotacao) {
    anotacao_deletada = anotacao;
    indice_da_tarefa_del = anotacoes_do_usuario.indexOf(anotacao);
    setState(() {
      anotacoes_do_usuario.remove(anotacao);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.white,
        content: const Text(
          'Anotação removida com sucesso!',
          style: TextStyle(color: Colors.black),
        ),
        action: SnackBarAction(
            backgroundColor: Colors.white,
            label: 'Desfazer',
            textColor: const Color(0xFF32CD99),
            onPressed: () {
              setState(() {
                anotacoes_do_usuario.insert(
                    indice_da_tarefa_del!, anotacao_deletada!);
              });
            }),
        duration: const Duration(seconds: 5),
      ),
    );
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
                Navigator.pop(context); // Fecha o Drawer
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const telaDelogin()),
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Flexible(
                child: ListView(
              shrinkWrap: true,
              children: [
                for (Anotacoes anotacao in anotacoes_do_usuario)
                  Anotacao_do_usuario(
                    anotacao: anotacao,
                    deletar_anotacao: deletar_anotacao,
                    onClick: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TelaDetalhesAnotacao(anotacao: anotacao),
                        ),
                      );
                    },
                  ),
                const SizedBox(height: 30),
              ],
            ))
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TelaAnotacoes(
                      mensagem: confirmar, salvar: salvar_as_anotacoes)),
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
