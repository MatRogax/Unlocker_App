import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_unloucker/app/modules/auth/exceptions/auth_exceptions.dart';
import 'package:projeto_unloucker/app/modules/auth/services/model/auth_model.dart';
import 'package:projeto_unloucker/app/modules/auth/services/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthController extends Cubit<AuthState> {
  final AbstractAuthRepository _authRepository;
  StreamSubscription<User?>? _userSubscription;

  AuthController({required AbstractAuthRepository authRepository}) : _authRepository = authRepository, super(AuthInitial()) {
    _monitorAuthStateChanges();
  }

  void _monitorAuthStateChanges() {
    _userSubscription = _authRepository.authStateChanges.listen((firebaseUser) {
      if (firebaseUser != null) {
        emit(Authenticated(firebaseUser));
      } else {
        emit(Unauthenticated());
      }
    });
  }

  Future<void> performSignUp(AuthModel data) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUp(data);
    } on AuthCredentialsException catch (e) {
      emit(AuthFailure(e.message));
    } on AuthGenericException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure("Ocorreu um erro inesperado durante o cadastro."));
    }
  }

  Future<void> performSignIn(AuthModel data) async {
    emit(AuthLoading());
    try {
      await _authRepository.signIn(data);
    } on AuthCredentialsException catch (err) {
      emit(AuthFailure(err.message));
    } on AuthGenericException catch (err) {
      emit(AuthFailure(err.message));
    } catch (err) {
      emit(AuthFailure("Ocorreu um erro inesperado durante o login."));
    }
  }

  Future<void> performSignOut() async {
    try {
      await _authRepository.signOut();
    } on AuthGenericException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure("Ocorreu um erro inesperado ao tentar sair."));
    }
  }

  Future<void> requestPasswordReset(String email) async {
    emit(AuthLoading());
    try {
      await _authRepository.sendPasswordResetEmail(email);
      final currentUser = _authRepository.getCurrentUser();
      if (currentUser == null) {
        emit(Unauthenticated());
      } else {
        emit(Authenticated(currentUser));
      }
    } on AuthCredentialsException catch (e) {
      emit(AuthFailure(e.message));
    } on AuthGenericException catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure("Ocorreu um erro inesperado ao solicitar a redefinição de senha."));
    }
  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}
