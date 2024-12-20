import 'package:appdiario/paginas/telaDeLogin.dart';
import 'package:appdiario/paginas/telainicial.dart';
import 'package:appdiario/servicos/autenticacao.dart';
import 'package:flutter/material.dart';
import 'package:appdiario/main.dart';

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
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (context, currentTheme, _) {
        final isDarkMode = currentTheme == ThemeMode.dark;

        return Scaffold(
          backgroundColor: isDarkMode
              ? const Color.fromARGB(255, 0, 0, 0)
              : const Color.fromARGB(255, 255, 255, 255),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      Image.asset(
                        'assets/imagens/life.png',
                        height: 330,
                        width: 330,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: isDarkMode
                              ? const Color.fromARGB(255, 0, 0, 0)
                              : const Color.fromARGB(255, 255, 255, 255),
                          borderRadius: BorderRadius.circular(30),
                        ),
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
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: "Usuário",
                                  hintText: "Thayane",
                                  labelStyle: TextStyle(
                                    color: isDarkMode
                                        ? const Color.fromARGB(
                                            255, 247, 245, 245)
                                        : const Color.fromARGB(255, 12, 12, 12),
                                  ),
                                  hintStyle: TextStyle(
                                    color: isDarkMode
                                        ? const Color.fromARGB(
                                            255, 255, 255, 255)
                                        : const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                style: TextStyle(
                                  color: isDarkMode
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : const Color.fromARGB(255, 11, 11, 11),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: "E-mail",
                                  hintText: "emailexemplo@gmail.com",
                                  labelStyle: TextStyle(
                                    color: isDarkMode
                                        ? const Color.fromARGB(
                                            255, 255, 255, 255)
                                        : const Color.fromARGB(255, 11, 11, 11),
                                  ),
                                  hintStyle: TextStyle(
                                    color: isDarkMode
                                        ? const Color.fromARGB(
                                            255, 248, 246, 246)
                                        : const Color.fromARGB(255, 0, 0, 0),
                                  ),
                                ),
                                style: TextStyle(
                                  color: isDarkMode
                                      ? const Color.fromARGB(255, 255, 255, 255)
                                      : const Color.fromARGB(255, 11, 11, 11),
                                ),
                              ),
                              const SizedBox(height: 15),
                              TextField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  labelText: "Senha",
                                  hintText: "Mínimo: 6 dígitos",
                                  labelStyle: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  hintStyle: TextStyle(
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                style: TextStyle(
                                  color:
                                      isDarkMode ? Colors.white : Colors.black,
                                ),
                              ),
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
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                              SnackBar(content: Text(value)));
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Telainicial()),
                                      );
                                    }
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF32CD99),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.app_registration,
                                      color: Color.fromARGB(255, 245, 245, 245),
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'Registrar',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 254, 253, 253)),
                                    ),
                                  ],
                                ),
                              ),
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
                                        backgroundColor: const Color.fromARGB(
                                            255, 244, 67, 54),
                                      ));
                                    } else {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const Telainicial()),
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
                                      "Cadastrar com o Google",
                                      style: TextStyle(
                                        color: Colors.black,
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
                                  Text(
                                    'Já tem uma conta?',
                                    style: TextStyle(
                                      color: isDarkMode
                                          ? const Color.fromARGB(
                                              255, 255, 255, 255)
                                          : const Color.fromARGB(
                                              255, 19, 19, 19),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const TeladeLogin()),
                                      );
                                    },
                                    child: const Text(
                                      "Entrar",
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 33, 150, 243)),
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
          ),
        );
      },
    );
  }
}
