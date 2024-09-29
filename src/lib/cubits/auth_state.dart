
import 'package:equatable/equatable.dart';
import 'package:com.example.simple_cubit_app/models/user.dart';

abstract class AuthState extends Equatable {
	const AuthState();

	@override
	List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class Authenticated extends AuthState {
	final User user;

	const Authenticated(this.user);

	@override
	List<Object> get props => [user];
}

class Unauthenticated extends AuthState {}
