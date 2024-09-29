
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:simple_cubit_app/screens/login_screen.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';
import 'package:simple_cubit_app/cubits/auth_state.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('LoginScreen Widget Tests', () {
		testWidgets('should display email and password text fields', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));
			
			expect(find.byType(TextField), findsNWidgets(2));
			expect(find.text('Email'), findsOneWidget);
			expect(find.text('Password'), findsOneWidget);
		});

		testWidgets('should display login button', (WidgetTester tester) async {
			await tester.pumpWidget(MaterialApp(home: LoginScreen()));
			
			expect(find.byType(ElevatedButton), findsOneWidget);
			expect(find.text('Login'), findsOneWidget);
		});
	});

	group('LoginScreen Cubit Tests', () {
		late AuthCubit authCubit;

		setUp(() {
			authCubit = MockAuthCubit();
		});

		testWidgets('should call login on button press', (WidgetTester tester) async {
			when(() => authCubit.state).thenReturn(AuthInitial());

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => authCubit,
						child: LoginScreen(),
					),
				),
			);

			await tester.enterText(find.byKey(Key('emailField')), 'test@example.com');
			await tester.enterText(find.byKey(Key('passwordField')), 'password123');
			await tester.tap(find.byType(ElevatedButton));
			await tester.pump();

			verify(() => authCubit.login('test@example.com', 'password123')).called(1);
		});

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, Authenticated] when login is successful',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'password123'),
			expect: () => [AuthLoading(), Authenticated()],
		);

		blocTest<AuthCubit, AuthState>(
			'emits [AuthLoading, Unauthenticated] when login fails',
			build: () => authCubit,
			act: (cubit) => cubit.login('test@example.com', 'wrongpassword'),
			expect: () => [AuthLoading(), Unauthenticated()],
		);
	});
}
