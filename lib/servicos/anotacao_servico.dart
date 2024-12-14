import 'dart:io';
import 'package:appdiario/models/anotacoes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class AnotacaoServico {
  String userID;
  final CollectionReference =
      FirebaseFirestore.instance.collection('anotacoes');

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

  Future<List<Anotacoes>> buscarAnotacoesPorTitulo(
      String titulo_da_anotacao) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('usuarios')
          .doc(userID)
          .collection('anotacoes')
          .where('titulo_da_anotacao',
              isGreaterThanOrEqualTo: titulo_da_anotacao)
          .where('titulo_da_anotacao',
              isLessThanOrEqualTo: titulo_da_anotacao + '\uf8ff')
          .get();

      List<Anotacoes> anotacoes = querySnapshot.docs.map((doc) {
        return Anotacoes.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();

      return anotacoes;
    } catch (e) {
      print('Erro ao buscar anotações: $e');
      return [];
    }
  }

  Future<void> editarAnotacao(Anotacoes anotacao) async {
    await _firestore
        .collection('usuarios')
        .doc(userID)
        .collection('anotacoes')
        .doc(anotacao.id)
        .update(anotacao.toMap());
  }

  Future<void> excluirAnotacaoComImagem(Anotacoes anotacao) async {
    try {
      if (anotacao.urlImagem != null && anotacao.urlImagem!.isNotEmpty) {
        final ref = _storage.refFromURL(anotacao.urlImagem!);
        await ref.delete();
      }

      await _firestore
          .collection('usuarios')
          .doc(userID)
          .collection('anotacoes')
          .doc(anotacao.id)
          .delete();

      print('Anotação e imagem excluídas com sucesso.');
    } catch (e) {
      print('Erro ao excluir anotação ou imagem: $e');
      throw Exception('Erro ao excluir a anotação ou a imagem: $e');
    }
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
      UploadTask uploadTask = ref.putFile(image);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Erro ao fazer upload da imagem: $e');
    }
  }
}
