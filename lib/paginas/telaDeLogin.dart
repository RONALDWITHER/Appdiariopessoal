import 'package:appdiario/paginas/telacadastro.dart';
import 'package:flutter/material.dart';

class telaDelogin extends StatefulWidget {
  const telaDelogin({super.key});

  @override
  State<telaDelogin> createState() => _telaDeloginState();
}

class _telaDeloginState extends State<telaDelogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Center(
        child: Padding(
            padding: const EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              height: 500,
              width: 600,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Seja bem vindo(a)',
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 15),
                    Flexible(
                        child: TextField(
                      decoration: InputDecoration(
                        labelText: "E-mail",
                        hintText: "emailexemplo@gmail.com",
                      ),
                    )),
                    const SizedBox(height: 15),
                    Flexible(
                        child: TextField(
                      decoration: InputDecoration(
                        labelText: "Senha",
                      ),
                    )),
                    const SizedBox(height: 15),
                    TextButton(
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.lightBlue),
                        child: const Text(
                          'Entrar',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        )),
                    const SizedBox(height: 15),
                    const Text('OU'),
                    const SizedBox(height: 15),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Login com o google",
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
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
