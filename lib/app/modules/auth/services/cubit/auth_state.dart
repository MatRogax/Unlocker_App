part of 'auth_controller.dart'; 

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {} 

class AuthLoading extends AuthState {} 

class Authenticated extends AuthState { 
  final User user;
  const Authenticated(this.user);
  @override
  List<Object?> get props => [user];
}

class Unauthenticated extends AuthState {} 

class AuthFailure extends AuthState { 
  final String error;
  const AuthFailure(this.error);
  @override
  List<Object?> get props => [error];
}

