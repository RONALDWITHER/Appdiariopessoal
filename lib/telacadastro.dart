import 'package:appdiario/telainicial.dart';
import 'package:flutter/material.dart';

class Telacadastro extends StatefulWidget {
  const Telacadastro({super.key});
  @override
  _TelacadastroState createState() => _TelacadastroState();
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 33, 147, 241),
        borderRadius: BorderRadius.circular(30),
      ),
      child: const TextField(
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          hintText: 'Digite aqui...',
          border: InputBorder.none,
        ),
        style: TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
    );
  }
}

class _TelacadastroState extends State<Telacadastro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 120,
        ),
        const Text(
          'Email:',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const CustomTextField(),
        const SizedBox(height: 20),
        const Text(
          'Senha:',
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Center(child: CustomTextField()),
        const SizedBox(height: 20),
        const SizedBox(height: 10),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Telainicial()),
              );
            },
            child: const Text('Logar'))
      ],
    ));
  }
}
