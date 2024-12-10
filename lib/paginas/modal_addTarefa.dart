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

  File? _selectedImage; // Variável para armazenar a imagem selecionada

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
                  SizedBox(
                    height: 250,
                    child: _selectedImage != null
                        ? Image.file(
                            _selectedImage!,
                            fit: BoxFit.cover,
                          )
                        : const Text('Nenhuma imagem selecionada.'),
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
                // Se uma imagem foi selecionada, faz o upload
                String? imageUrl;
                if (_selectedImage != null) {
                  imageUrl = await _anotacaoServico
                      .uploadImageToStorage(_selectedImage!);
                }
                nova_anotacao = Anotacoes(
                  titulo_da_anotacao: _titulo_da_anotacao.text,
                  texto_da_anotacao: _texto_da_anotacao.text,
                  dataHorario: DateTime.now(),
                  id: const Uuid().v1(),
                  urlImagem: imageUrl, // Salva a URL da imagem no campo
                );

                await _anotacaoServico.adicionarTarefa(nova_anotacao);
                widget.mensagem(context);
                Navigator.pop(context);
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
