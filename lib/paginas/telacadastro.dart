import 'package:appdiario/paginas/telaDeLogin.dart';
import 'package:appdiario/paginas/telainicial.dart';
import 'package:appdiario/servicos/autenticacao.dart';
import 'package:flutter/material.dart';

class Telacadastro extends StatefulWidget {
  const Telacadastro({super.key});
  @override
  _TelacadastroState createState() => _TelacadastroState();
}

class _TelacadastroState extends State<Telacadastro> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AutenticacaoServicos _autenticacaoServicos = AutenticacaoServicos();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Center(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Image.asset(
                  'assets/imagens/life.png',
                  height: 330,
                  width: 330,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30)),
                  height: 500,
                  width: 600,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Cadastrar',
                          style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF32CD99),
                              fontWeight: FontWeight.w500),
                        ),
                        Flexible(
                            child: TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: "Usuario",
                            hintText: "Thayane",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(151, 103, 103, 104)),
                          ),
                        )),
                        const SizedBox(height: 15),
                        Flexible(
                            child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: "E-mail",
                            hintText: "emailexemplo@gmail.com",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(151, 103, 103, 104)),
                          ),
                        )),
                        const SizedBox(height: 15),
                        Flexible(
                            child: TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: "Senha",
                            hintText: "Minimo: 6 dígitos",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(151, 103, 103, 104)),
                          ),
                        )),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            _autenticacaoServicos
                                .cadastrarUsuarios(
                                    nome: _nameController.text,
                                    senha: _passwordController.text,
                                    email: _emailController.text)
                                .then((value) {
                              if (value != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(value)));
                              } else {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Telainicial()),
                                );
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF32CD99)),
                          child: const Row(
                            children: [
                              Icon(
                                Icons.app_registration,
                                color: Colors.white,
                              ),
                              Text(
                                'Registrar',
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text('Já tem uma conta?'),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => telaDelogin()),
                                );
                              },
                              child: const Text(
                                "Entrar",
                                style: TextStyle(color: Colors.blue),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
