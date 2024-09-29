
import 'dart:convert';

class User {
	final String id;
	final String email;

	User({required this.id, required this.email});

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'email': email,
		};
	}

	factory User.fromJson(Map<String, dynamic> json) {
		return User(
			id: json['id'],
			email: json['email'],
		);
	}
}
