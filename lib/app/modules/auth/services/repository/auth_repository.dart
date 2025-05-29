// lib/repositories/register_repository.dart
// import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_unloucker/app/modules/auth/services/model/auth_model.dart';
// import 'package:projeto_unloucker/app/modules/auth/services/model/auth_model.dart';
// import 'package:projeto_unloucker/app/utils/utils.dart';

abstract class AbstractAuthRepository {
  // Future<bool> register(RegisterModel registerModel);
}

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  User? getCurrentUser() => _auth.currentUser;

  Future<void> signUp(AuthModel data) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: data.email, password: data.password);
    } on FirebaseAuthException catch (e) {
      throw Exception('Erro ao registrar: ${e.message}');
    }
  }

  Future<void> signIn(AuthModel data) async {
    try {
      await _auth.signInWithEmailAndPassword(email: data.email, password: data.password);
    } on FirebaseAuthException catch (e) {
      throw Exception('Erro de login: ${e.message}');
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

// class RegisterRepository implements AbstractRegisterRepository {
//   final Dio _dio = Utils.dioIstance;

//   @override
//   Future<bool> register(RegisterModel registerModel) async{
//     bool response = false;
//      await _dio.post(
//         '/user/create',
//         data: registerModel.toMap(),
//       ).then((value) {
//         response = true;
//       });
//       return response;
//   }
