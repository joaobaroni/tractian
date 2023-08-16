import 'package:equatable/equatable.dart';

import 'http_status.dart';

///
/// Default response for Http requests.
///
///
class HttpResponse extends Equatable {
  ///
  /// Http staus code
  ///
  final HttpStatus status;

  ///
  /// Response data
  ///
  final dynamic data;

  ///
  /// Creates a new [HttpResponse]
  ///
  const HttpResponse({
    required this.status,
    this.data,
  });

  ///
  /// Creates a [HttpStatus.ok] response with data
  ///
  factory HttpResponse.success(
    Object? data, {
    HttpStatus status = HttpStatus.ok,
  }) {
    return HttpResponse(status: status, data: data);
  }

  ///
  /// Creates an empty response with given status code
  ///
  factory HttpResponse.empty({HttpStatus status = HttpStatus.noContent}) {
    return HttpResponse(status: status);
  }

  @override
  List<Object?> get props => [status, data];
}
