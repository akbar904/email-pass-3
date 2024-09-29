
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:com.example.simple_cubit_app/cubits/auth_state.dart';

void main() {
	group('AuthState', () {
		test('AuthInitial is a valid AuthState', () {
			expect(AuthInitial(), isA<AuthState>());
		});

		test('Authenticated is a valid AuthState', () {
			var user = User(id: '1', email: 'test@example.com');
			expect(Authenticated(user), isA<AuthState>());
		});

		test('Authenticated state has correct user', () {
			var user = User(id: '1', email: 'test@example.com');
			var state = Authenticated(user);
			expect(state.user, user);
		});

		test('Unauthenticated is a valid AuthState', () {
			expect(Unauthenticated(), isA<AuthState>());
		});
	});
}
