import 'dart:io';
import 'package:appdiario/models/anotacoes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AnotacaoServico {
  String userID;

  AnotacaoServico() : userID = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> adicionarTarefa(Anotacoes anotacao) async {
    await _firestore
        .collection('usuarios')
        .doc(userID)
        .collection('anotacoes')
        .doc(anotacao.id)
        .set(anotacao.toMap());
  }

  Future<void> editarAnotacao(Anotacoes anotacao) async {
    await _firestore
        .collection('usuarios')
        .doc(userID)
        .collection('anotacoes')
        .doc(anotacao.id)
        .update(anotacao.toMap());
  }

  Future<void> excluirAnotacao(Anotacoes anotacao) async {
    await _firestore
        .collection('usuarios')
        .doc(userID)
        .collection('anotacoes')
        .doc(anotacao.id)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectarStreamTarefas() {
    return _firestore
        .collection('usuarios')
        .doc(userID)
        .collection('anotacoes')
        .snapshots();
  }

  Future<String> uploadImageToStorage(File image) async {
    try {
      
      String filePath = 'anotacoes/${Uuid().v1()}.jpg';
      Reference ref = _storage.ref().child(filePath);

      // Fazendo o upload do arquivo
      UploadTask uploadTask = ref.putFile(image);

      // Espera o upload ser completado
      TaskSnapshot taskSnapshot = await uploadTask;

      // Obtém a URL do arquivo após o upload
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();

      // Retorna a URL da imagem
      return downloadUrl;
    } catch (e) {
      throw Exception('Erro ao fazer upload da imagem: $e');
    }
  }
}
