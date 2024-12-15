import 'package:appdiario/main.dart';
import 'package:appdiario/paginas/telacadastro.dart';
import 'package:appdiario/paginas/telainicial.dart';
import 'package:appdiario/servicos/autenticacao.dart';
import 'package:flutter/material.dart';
import 'recup_senha.dart';

class TeladeLogin extends StatefulWidget {
  const TeladeLogin({super.key});

  @override
  State<TeladeLogin> createState() => _telaDeloginState();
}

class _telaDeloginState extends State<TeladeLogin> {
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
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {
        final isDarkMode = currentTheme == ThemeMode.dark;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: isDarkMode
              ? const Color.fromARGB(255, 10, 10, 10)
              : const Color.fromARGB(255, 247, 244, 244),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Image.asset(
                    'assets/imagens/life.png',
                    height: MediaQuery.of(context).size.height * 0.4,
                    width: MediaQuery.of(context).size.width * 1.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDarkMode
                            ? const Color.fromARGB(255, 13, 13, 13)
                            : const Color.fromARGB(255, 255, 255, 255),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Seja bem vindo(a)',
                            style: TextStyle(
                              fontSize: 30,
                              color: Color(0xFF32CD99),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              labelText: "E-mail",
                              hintText: "emailexemplo@gmail.com",
                              hintStyle: TextStyle(
                                color: isDarkMode
                                    ? const Color.fromARGB(255, 158, 158, 158)
                                    : const Color.fromARGB(151, 103, 103, 104),
                              ),
                              labelStyle: TextStyle(
                                color: isDarkMode
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : const Color.fromARGB(255, 9, 9, 9),
                              ),
                            ),
                            style: TextStyle(
                              color: isDarkMode
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : const Color.fromARGB(255, 14, 14, 14),
                            ),
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: "Senha",
                              labelStyle: TextStyle(
                                color: isDarkMode
                                    ? const Color.fromARGB(255, 255, 255, 255)
                                    : const Color.fromARGB(255, 14, 14, 14),
                              ),
                            ),
                            style: TextStyle(
                              color: isDarkMode
                                  ? const Color.fromARGB(255, 255, 255, 255)
                                  : const Color.fromARGB(255, 11, 11, 11),
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
                              _autenticacaoServicos
                                  .signInWithGoogle()
                                  .then((value) {
                                if (value != null) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text(value),
                                    backgroundColor:
                                        const Color.fromARGB(255, 244, 67, 54),
                                  ));
                                } else {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => Telainicial()),
                                  );
                                }
                              });
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/imagens/google_icon.png',
                                  height: 24,
                                  width: 24,
                                ),
                                const SizedBox(width: 10),
                                const Text(
                                  "Login com o Google",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
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
                                        builder: (context) =>
                                            const Telacadastro()),
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
      },
    );
  }
}
