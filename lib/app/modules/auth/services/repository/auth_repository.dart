import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_unloucker/app/modules/auth/exceptions/auth_exceptions.dart';
import 'package:projeto_unloucker/app/modules/auth/services/model/auth_model.dart';
import 'package:projeto_unloucker/app/modules/profile/services/repository/profile_repository.dart';

abstract class AbstractAuthRepository {
  Stream<User?> get authStateChanges;
  User? getCurrentUser();
  Future<void> signUp(AuthModel data);
  Future<UserCredential> signIn(AuthModel data);
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  Future<void> deleteUserAccount();
}

class AuthRepository implements AbstractAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final AbstractProfileRepository _profileRepository;

  AuthRepository({FirebaseAuth? firebaseAuth, required AbstractProfileRepository profileRepository})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
      _profileRepository = profileRepository;

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  User? getCurrentUser() => _firebaseAuth.currentUser;

  @override
  Future<void> signUp(AuthModel data) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: data.email.trim(), password: data.password);

      if (userCredential.user != null) {
        await _profileRepository.createProfile(userCredential.user!);
      }
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weak-password') {
        throw AuthCredentialsException('A senha fornecida é muito fraca.', code: err.code);
      } else if (err.code == 'email-already-in-use') {
        throw AuthCredentialsException('Este e-mail já está em uso por outra conta.', code: err.code);
      } else if (err.code == 'invalid-email') {
        throw AuthCredentialsException('O formato do e-mail é inválido.', code: err.code);
      }
      throw AuthGenericException('Erro ao registrar: ${err.message ?? "Ocorreu um problema."}');
    } catch (e) {
      throw AuthGenericException('Ocorreu um erro desconhecido durante o registro.');
    }
  }

  @override
  Future<UserCredential> signIn(AuthModel data) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: data.email.trim(), password: data.password);

      if (userCredential.user == null) {
        throw AuthGenericException('Falha ao obter informações do usuário após o login.');
      }

      return userCredential;
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        throw AuthCredentialsException('Nenhum usuário encontrado com este e-mail.', code: err.code);
      } else if (err.code == 'wrong-password' || err.code == 'invalid-credential') {
        throw AuthCredentialsException('E-mail ou senha incorretos.', code: err.code);
      } else if (err.code == 'user-disabled') {
        throw AuthCredentialsException('Esta conta de usuário foi desabilitada.', code: err.code);
      } else if (err.code == 'invalid-email') {
        throw AuthCredentialsException('O formato do e-mail é inválido.', code: err.code);
      }
      throw AuthGenericException('Erro ao fazer login: ${err.message ?? "Ocorreu um problema."}');
    } catch (err) {
      throw AuthGenericException('Ocorreu um erro desconhecido durante o login.');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AuthGenericException('Erro ao fazer logout: ${e.toString()}');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (err) {
      if (err.code == 'user-not-found') {
        throw AuthCredentialsException('Nenhum usuário encontrado com este e-mail.', code: err.code);
      } else if (err.code == 'invalid-email') {
        throw AuthCredentialsException('O formato do e-mail é inválido.', code: err.code);
      }
      throw AuthGenericException('Erro ao enviar e-mail de redefinição de senha: ${err.message}');
    } catch (e) {
      throw AuthGenericException('Ocorreu um erro desconhecido.');
    }
  }

  @override
  Future<void> deleteUserAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        await _profileRepository.deleteProfile(user.uid);
        await user.delete();
      } else {
        throw AuthGenericException('Nenhum usuário logado para deletar.');
      }
    } catch (err) {
      if (err is FirebaseAuthException && err.code == 'requires-recent-login') {
        throw AuthGenericException('Esta operação é sensível e requer autenticação recente. Por favor, faça login novamente e tente de novo.');
      }
      throw AuthGenericException('Erro ao deletar conta: ${err.toString()}');
    }
  }
}
