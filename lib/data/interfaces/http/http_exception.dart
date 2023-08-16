import 'package:equatable/equatable.dart';

///
/// Http base exception
///
abstract class IHttpException extends Equatable {
  ///
  /// Http status code
  ///
  final int? status;

  ///
  /// Error message
  ///
  final String message;

  ///
  /// Optional data
  ///
  final dynamic data;

  ///
  /// Creates a new [IHttpException]
  ///
  const IHttpException(
    this.status, {
    this.data,
    this.message = '',
  });

  @override
  List<Object?> get props => [status, data, message];
}

class GenericHttpException extends IHttpException {
  const GenericHttpException(super.status, {super.data, super.message});
}
