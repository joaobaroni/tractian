import 'package:tractian/domain/domain.dart';

/// A utility class for converting JSON data to a User object.
abstract class UserMapper {
  /// Converts JSON data to a User object.
  static fromJson(Map<String, dynamic> json) {
    return User(name: json['name'], id: json['id'], email: json['email']);
  }
}
