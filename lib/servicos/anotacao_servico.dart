import 'package:appdiario/models/anotacoes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AnotacaoServico {
  String userID;

  AnotacaoServico() : userID = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> adicionarTarefa(Anotacoes anotacao) async {
    await _firestore
        .collection('Usuarios Teste')
        .doc(userID)
        .collection('anotacoesTeste')
        .doc(anotacao.id)
        .set(anotacao.toMap());
  }

  Future<void> editarAnotacao(Anotacoes anotacao) async {
    await _firestore
        .collection('Usuarios Teste')
        .doc(userID)
        .collection('anotacoesTeste')
        .doc(anotacao.id)
        .update(anotacao.toMap());
  }

  Future<void> excluirAnotacao(Anotacoes anotacao) async {
    await _firestore
        .collection('Usuarios Teste')
        .doc(userID)
        .collection('anotacoesTeste')
        .doc(anotacao.id)
        .delete();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> conectarStreamTarefas() {
    return _firestore
        .collection('Usuarios Teste')
        .doc(userID)
        .collection('anotacoesTeste')
        .snapshots();
  }
}
