
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/auth_cubit.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';

void main() {
	runApp(MyApp());
}

class MyApp extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return BlocProvider(
			create: (_) => AuthCubit(),
			child: MaterialApp(
				title: 'Simple Cubit App',
				initialRoute: '/',
				routes: {
					'/': (context) => LoginScreen(),
					'/home': (context) => HomeScreen(),
				},
			),
		);
	}
}
