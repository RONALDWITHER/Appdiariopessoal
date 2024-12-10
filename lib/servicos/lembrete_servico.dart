import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class LembreteServico {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  Future<void> adicionarLembrete(
      String horario, String anotacao, DateTime dataSelecionada) async {
    if (user != null) {
      final String dataFormatada =
          '${dataSelecionada.day.toString().padLeft(2, '0')}/${dataSelecionada.month.toString().padLeft(2, '0')}/${dataSelecionada.year}';
      final String id = const Uuid().v1();

      await _firestore
          .collection('usuarios')
          .doc(user!.uid)
          .collection('Lembretes')
          .doc(id)
          .set({
        'id': id,
        'horario': horario,
        'anotacao': anotacao,
        'data': dataFormatada,
      });
    }
  }

  Future<void> deletarLembrete(String id) async {
    if (user != null) {
      await _firestore
          .collection('usuarios')
          .doc(user!.uid)
          .collection('Lembretes')
          .doc(id)
          .delete();
    }
  }

  Stream<QuerySnapshot> carregarLembretes(DateTime dataSelecionada) {
    final String dataFormatada =
        '${dataSelecionada.day.toString().padLeft(2, '0')}/${dataSelecionada.month.toString().padLeft(2, '0')}/${dataSelecionada.year}';

    return _firestore
        .collection('usuarios')
        .doc(user!.uid)
        .collection('Lembretes')
        .where('data', isEqualTo: dataFormatada)
        .snapshots();
  }
}
