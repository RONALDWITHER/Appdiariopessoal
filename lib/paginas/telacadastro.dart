import 'package:appdiario/paginas/telaDeLogin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:appdiario/paginas/telainicial.dart';

class Telacadastro extends StatefulWidget {
  const Telacadastro({super.key});
  @override
  _TelacadastroState createState() => _TelacadastroState();
}

class _TelacadastroState extends State<Telacadastro> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _registrar(String name) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.reload();

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Telainicial()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao criar conta: $e")),
      );
    }
  }

  Future<void> _signInWithEmail() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Telainicial()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao fazer login: $e")),
      );
    }
  }

  final _nameController = TextEditingController();

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Telainicial()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao fazer login: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 30),
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
                      Text(
                        'Cadastrar',
                        style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF32CD99),
                            fontWeight: FontWeight.w500),
                      ),
                      Flexible(
                          child: TextField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: "Usuario",
                          hintText: "Fulano De tal",
                        ),
                      )),
                      SizedBox(height: 15),
                      Flexible(
                          child: TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: "E-mail",
                          hintText: "emailexemplo@gmail.com",
                        ),
                      )),
                      SizedBox(height: 15),
                      Flexible(
                          child: TextField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          labelText: "Senha",
                        ),
                      )),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          _registrar(_nameController.text.trim());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF32CD99)),
                        child: Row(
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
                      SizedBox(height: 15),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Já tem uma conta?'),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) => telaDelogin()),
                              );
                            },
                            child: Text(
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
    );
  }
}
