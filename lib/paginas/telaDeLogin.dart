import 'package:appdiario/paginas/telacadastro.dart';
import 'package:appdiario/paginas/telainicial.dart';
import 'package:appdiario/servicos/autenticacao.dart';
import 'package:flutter/material.dart';
import 'recup_senha.dart'; // Importe a tela de recuperação de senha

class telaDelogin extends StatefulWidget {
  const telaDelogin({super.key});

  @override
  State<telaDelogin> createState() => _telaDeloginState();
}

class _telaDeloginState extends State<telaDelogin> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AutenticacaoServicos _autenticacaoServicos = AutenticacaoServicos();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 1),
              Image.asset(
                'assets/imagens/life.png',
                height: 330,
                width: 330,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                height: 500,
                width: 600,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Seja bem vindo(a)',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF32CD99),
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 15),
                      Flexible(
                        child: TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                              labelText: "E-mail",
                              hintText: "emailexemplo@gmail.com",
                              hintStyle: TextStyle(
                                  color: Color.fromARGB(151, 103, 103, 104))),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Flexible(
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            labelText: "Senha",
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          _autenticacaoServicos
                              .logar_usuario(
                                  email: _emailController.text,
                                  senha: _passwordController.text)
                              .then((value) {
                            if (value != null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(value),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Telainicial()));
                            }
                          });
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: const Color(0xFF32CD99)),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      const SizedBox(height: 15),
                      const Text('OU'),
                      const SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          _autenticacaoServicos.logarComGoogle().then((value) {
                            if (value != null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(value),
                                backgroundColor: Colors.red,
                              ));
                            } else {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => Telainicial()));
                            }
                          });
                        },
                        child: const Text(
                          "Login com o Google",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text('Não tem uma conta?'),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => const Telacadastro()),
                              );
                            },
                            child: const Text(
                              "Cadastrar",
                              style: TextStyle(color: Colors.blue),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TelaRecuperacaoSenha(),
                            ),
                          );
                        },
                        child: const Text(
                          "Esqueci a senha",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
