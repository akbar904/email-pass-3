
import 'package:flutter_test/flutter_test.dart';
import 'package:simple_cubit_app/screens/home_screen.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_cubit_app/cubits/auth_cubit.dart';

class MockAuthCubit extends MockCubit<AuthState> implements AuthCubit {}

void main() {
	group('HomeScreen Widget Tests', () {
		testWidgets('displays logout button', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();

			when(() => mockAuthCubit.state).thenReturn(Authenticated());

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: HomeScreen(),
					),
				),
			);

			expect(find.text('Logout'), findsOneWidget);
		});

		testWidgets('triggers logout when button is pressed', (WidgetTester tester) async {
			final mockAuthCubit = MockAuthCubit();

			when(() => mockAuthCubit.state).thenReturn(Authenticated());
			when(() => mockAuthCubit.logout()).thenReturn(null);

			await tester.pumpWidget(
				MaterialApp(
					home: BlocProvider<AuthCubit>(
						create: (_) => mockAuthCubit,
						child: HomeScreen(),
					),
				),
			);

			await tester.tap(find.text('Logout'));
			await tester.pumpAndSettle();

			verify(() => mockAuthCubit.logout()).called(1);
		});
	});
}
