import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:projeto_unloucker/app/modules/auth/services/model/auth_model.dart';
import 'package:projeto_unloucker/app/modules/auth/services/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit({required AuthRepository authRepository}) : _authRepository = authRepository, super(AuthInitial());

  Future<void> performSignUp(AuthModel data) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUp(data);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> performSignIn(AuthModel data) async {
    emit(AuthLoading());
    try {
      await _authRepository.signIn(data);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Nenhuma conta encontrada para este e-mail.';
          break;
        case 'wrong-password':
        case 'invalid-credential':
          errorMessage = 'E-mail ou senha incorretos.';
          break;
        case 'invalid-email':
          errorMessage = 'O formato do e-mail é inválido.';
          break;
        case 'user-disabled':
          errorMessage = 'Esta conta foi desativada.';
          break;
        default:
          errorMessage = 'Ocorreu um erro de autenticação. Tente novamente.';
      }
      emit(AuthFailure(errorMessage));
    } catch (e) {
      emit(AuthFailure('Ocorreu um erro inesperado. Por favor, contate o suporte.'));
    }
  }

  Future<void> performSignOut() async {
    emit(AuthLoading());
    try {
      await _authRepository.signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
