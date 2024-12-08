import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class TelaAnotacoes extends StatefulWidget {
  final void Function(BuildContext) mensagem;
  final void Function(String, String, DateTime) salvar;

  TelaAnotacoes({required this.mensagem, required this.salvar});

  @override
  _TelaAnotacoesState createState() => _TelaAnotacoesState();
}

class _TelaAnotacoesState extends State<TelaAnotacoes> {
  final TextEditingController _texto_da_anotacao = TextEditingController();
  final TextEditingController _titulo_da_anotacao = TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  final ImagePicker _imagePicker = ImagePicker();
  File? _selectedImage;
  bool _isLoading = false;

  Future<void> _pickImageFromSource(ImageSource source) async {
    PermissionStatus status;

    if (source == ImageSource.camera) {
      status = await Permission.camera.request();
    } else {
      status = await Permission.photos.request();
    }

    if (status.isGranted) {
      final pickedFile = await _imagePicker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Permissão negada. Habilite-a nas configurações.'),
        ),
      );
    }
  }

  Future<String?> _uploadImageToFirebase(File image) async {
    try {
      final ref = FirebaseStorage.instance.ref().child(
          'anotacoes/${user!.uid}/${DateTime.now().toIso8601String()}.jpg');
      final uploadTask = ref.putFile(image);

      // Aguarde o término do upload e valide
      final taskSnapshot = await uploadTask;
      if (taskSnapshot.state == TaskState.success) {
        return await ref.getDownloadURL();
      } else {
        throw Exception("Falha no upload da imagem");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao enviar imagem: $e')),
      );
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nova Anotação',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF32CD99),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titulo_da_anotacao,
              decoration: const InputDecoration(hintText: "Título"),
            ),
            const SizedBox(height: 16),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final source = await showModalBottomSheet<ImageSource>(
                  context: context,
                  builder: (context) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.camera),
                        title: const Text('Câmera'),
                        onTap: () => Navigator.pop(context, ImageSource.camera),
                      ),
                      ListTile(
                        leading: const Icon(Icons.photo_library),
                        title: const Text('Galeria'),
                        onTap: () =>
                            Navigator.pop(context, ImageSource.gallery),
                      ),
                    ],
                  ),
                );

                if (source != null) {
                  await _pickImageFromSource(source);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF32CD99),
              ),
              child: const Text(
                'Adicionar Imagem',
                style: TextStyle(color: Colors.white),
              ),
            ),
            if (_selectedImage != null)
              Image.file(
                _selectedImage!,
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      if (_titulo_da_anotacao.text.isEmpty ||
                          _texto_da_anotacao.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Preencha o título e o texto!')),
                        );
                        return;
                      }

                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        String? imageUrl;
                        if (_selectedImage != null) {
                          imageUrl =
                              await _uploadImageToFirebase(_selectedImage!);
                          if (imageUrl == null) {
                            throw Exception("Erro ao obter URL da imagem.");
                          }
                        }

                        if (user != null) {
                          await FirebaseFirestore.instance
                              .collection('usuarios')
                              .doc(user!.uid)
                              .collection('anotacoes')
                              .add({
                            'titulo': _titulo_da_anotacao.text,
                            'texto': _texto_da_anotacao.text,
                            'dataHorario': DateTime.now().toIso8601String(),
                            'imagemUrl': imageUrl,
                          });

                          widget.mensagem(context);
                          _titulo_da_anotacao.clear();
                          _texto_da_anotacao.clear();
                          setState(() {
                            _selectedImage = null;
                          });
                          Navigator.pop(context);
                        } else {
                          throw Exception("Usuário não autenticado!");
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro ao salvar: $e')),
                        );
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF32CD99),
                    ),
                    child: const Text(
                      'Salvar Anotação',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
