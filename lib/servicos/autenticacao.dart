import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AutenticacaoServicos {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<String?> cadastrarUsuarios({
    required String nome,
    required String senha,
    required String email,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: senha,
      );

      if (userCredential.user != null) {
        await userCredential.user!.updateDisplayName(nome);
      }
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return "O e-mail já está em uso. Por favor, tente outro.";
      } else if (e.code == 'weak-password') {
        return "A senha fornecida é muito fraca. Escolha uma senha mais forte.";
      } else if (e.code == 'invalid-email') {
        return "O e-mail fornecido é inválido. Verifique e tente novamente.";
      } else {
        return "Erro ao cadastrar: ${e.message}";
      }
    } catch (e) {
      return "Erro inesperado: $e";
    }
  }

  Future<String?> logar_usuario({
    required String email,
    required String senha,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: senha);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<String?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        return 'Login cancelado pelo usuário.';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);

      return null;
    } catch (e) {
      return 'erro ao fazer login $e';
    }
  }

  Future<void> deslogar() async {
    return _firebaseAuth.signOut(); // Deslogar do Firebase
  }
}
