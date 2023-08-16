///
/// Internal HttpStatus reference
///
enum HttpStatus {
  /// 200
  ok(200),

  /// 201
  created(201),

  /// 202
  accepted(202),

  /// 204
  noContent(204),

  /// 400
  badRequest(400),

  /// 401
  unauthorized(401),

  /// 403
  forbidden(403),

  /// 404
  notFound(404),

  ///422
  unprocessableEntity(422),

  /// 500
  serverError(500);

  /// Returns the http status code
  final int code;

  /// Default [HttpStatus] constructor
  const HttpStatus(this.code);
}
