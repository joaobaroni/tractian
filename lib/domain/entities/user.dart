import 'package:equatable/equatable.dart';

/// Class representing a user.
class User extends Equatable {
  /// Creates a new instance of [User].
  const User({
    required this.name,
    required this.id,
    required this.email,
  });

  /// The unique identifier of the user.
  final int id;

  /// The name of the user.
  final String name;

  /// The email address of the user.
  final String email;

  User copyWith({int? id, String? name, String? email}) {
    return User(
      email: email ?? this.email,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [id, name, email];
}
