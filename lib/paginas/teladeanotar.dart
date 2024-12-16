import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appdiario/models/anotacoes.dart';
import 'package:appdiario/servicos/anotacao_servico.dart';
import 'package:uuid/uuid.dart';

class TelaAnotacoes extends StatefulWidget {
  const TelaAnotacoes({super.key});

  @override
  _TelaAnotacoesState createState() => _TelaAnotacoesState();
}

class _TelaAnotacoesState extends State<TelaAnotacoes> {
  late Anotacoes nova_anotacao;

  File? _selectedImage;

  TextEditingController _texto_da_anotacao = TextEditingController();
  TextEditingController _titulo_da_anotacao = TextEditingController();
  AnotacaoServico _anotacaoServico = AnotacaoServico();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Anotação',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        backgroundColor: const Color(0xFF32CD99),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListView(
                  children: [
                    TextField(
                      controller: _titulo_da_anotacao,
                      decoration: const InputDecoration(hintText: "Título"),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: _texto_da_anotacao,
                      decoration: const InputDecoration(
                        hintText: 'Comece a escrever...',
                        border: InputBorder.none,
                      ),
                      maxLines: null,
                    ),
                    const SizedBox(height: 20),
                    if (_selectedImage != null)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TelaImagemCompleta(
                                imageFile: _selectedImage!,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 150,
                          width: 150,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      _uploadImage(iscamera: true);
                    },
                    icon: const Icon(Icons.camera_alt_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      _uploadImage(iscamera: false);
                    },
                    icon: const Icon(Icons.photo_size_select_actual),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            if (_texto_da_anotacao.text.isEmpty &&
                _titulo_da_anotacao.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _showLoadingDialog(context);

            try {
              String? imageUrl;
              if (_selectedImage != null) {
                imageUrl = await _anotacaoServico
                    .uploadImageToStorage(_selectedImage!);
              }
              final novaAnotacao = Anotacoes(
                titulo_da_anotacao: _titulo_da_anotacao.text,
                texto_da_anotacao: _texto_da_anotacao.text,
                dataHorario: DateTime.now(),
                id: const Uuid().v1(),
                urlImagem: imageUrl,
              );
              await _anotacaoServico.adicionarTarefa(novaAnotacao);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Anotação salva com sucesso!'),
                  backgroundColor: Color.fromARGB(255, 76, 175, 80),
                ),
              );
              Navigator.pop(context);
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Erro ao salvar anotação: $e')),
              );
            } finally {
              Navigator.pop(context);
            }
          },
          backgroundColor: const Color(0xFF32CD99),
          label: const Text(
            'Salvar anotação',
            style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _uploadImage({required bool iscamera}) async {
    try {
      _showLoadingDialog(context);

      ImagePicker imagePicker = ImagePicker();
      XFile? image = await imagePicker.pickImage(
        source: iscamera ? ImageSource.camera : ImageSource.gallery,
        maxHeight: 2000,
        maxWidth: 2000,
      );
      await Future.delayed(const Duration(seconds: 2));
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nenhuma imagem foi selecionada.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao selecionar imagem: $e')),
      );
    } finally {
      Navigator.pop(context);
    }
  }
}

class TelaImagemCompleta extends StatelessWidget {
  final File imageFile;
  const TelaImagemCompleta({required this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imagem Completa'),
        backgroundColor: const Color(0xFF32CD99),
      ),
      body: Center(
        child: Image.file(
          imageFile,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
