import 'package:equatable/equatable.dart';

import 'http_method.dart';

/// Represents the options for an HTTP request.
class HttpOptions extends Equatable {
  /// Creates a new instance of [HttpOptions].
  const HttpOptions({
    required this.path,
    required this.method,
    this.query,
  });

  /// The endpoint path of the request.
  final String path;

  /// The HTTP method for the request.
  final HttpMethod method;

  /// The query parameters to be included with the request.
  final Map<String, dynamic>? query;

  @override
  List<Object?> get props => [path, method, query];
}
