import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:appdiario/models/anotacoes.dart';
import 'package:appdiario/servicos/anotacao_servico.dart';
import 'package:uuid/uuid.dart';

class Modal_addTarefa extends StatefulWidget {
  final void Function(BuildContext) mensagem;
  const Modal_addTarefa({super.key, required this.mensagem});

  @override
  State<Modal_addTarefa> createState() => _Modal_addTarefaState();
}

class _Modal_addTarefaState extends State<Modal_addTarefa> {
  late Anotacoes nova_anotacao;

  File? _selectedImage;

  TextEditingController _texto_da_anotacao = TextEditingController();
  TextEditingController _titulo_da_anotacao = TextEditingController();
  AnotacaoServico _anotacaoServico = AnotacaoServico();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titulo_da_anotacao,
              decoration: const InputDecoration(hintText: "Título"),
            ),
            SizedBox(height: 2),
            Flexible(
              child: TextField(
                controller: _texto_da_anotacao,
                decoration: const InputDecoration(
                  hintText: 'Comece a escrever...',
                  border: InputBorder.none,
                ),
                maxLines: null,
              ),
            ),
            const SizedBox(height: 15),
            Flexible(
              child: ListView(
                children: [
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
            Row(
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
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
                        content: Text('Anotação salva com sucesso!')),
                  );
                  Navigator.pop(context);
                } catch (e) {
                  // Mostra mensagem de erro
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Erro ao salvar anotação: $e')),
                  );
                } finally {
                  // Fecha a tela de carregamento
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF32CD99),
              ),
              child: const Text('Salvar Anotação',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible:
          false, // Impede que o usuário feche o diálogo manualmente
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  void _uploadImage({required bool iscamera}) async {
    try {
      ImagePicker imagePicker = ImagePicker();

      XFile? image = await imagePicker.pickImage(
        source: (iscamera) ? ImageSource.camera : ImageSource.gallery,
        maxHeight: 2000,
        maxWidth: 2000,
      );

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
    }
  }
}

class TelaImagemCompleta extends StatelessWidget {
  final File imageFile;

  TelaImagemCompleta({required this.imageFile});

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
          fit: BoxFit.contain, // Ajusta a imagem ao tamanho da tela
        ),
      ),
    );
  }
}
