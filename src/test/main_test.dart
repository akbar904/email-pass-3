
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:simple_cubit_app/main.dart';

class MockAuthCubit extends Mock implements AuthCubit {}

void main() {
	group('MyApp', () {
		testWidgets('renders LoginScreen initially', (tester) async {
			await tester.pumpWidget(MyApp());

			expect(find.text('Login'), findsOneWidget);
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('AuthCubit', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		blocTest<AuthCubit, AuthState>(
			'emits [AuthInitial] when nothing is added',
			build: () => authCubit,
			expect: () => const <AuthState>[],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [Authenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('email', 'password'),
			expect: () => <AuthState>[Authenticated()],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [Unauthenticated] when logout is called',
			build: () => authCubit,
			act: (cubit) => cubit.logout(),
			expect: () => <AuthState>[Unauthenticated()],
		);
	});

	group('Main', () {
		testWidgets('initializes the app correctly', (tester) async {
			await tester.pumpWidget(MyApp());

			// Test initial route setup
			expect(find.byType(LoginScreen), findsOneWidget);
		});
	});
}
