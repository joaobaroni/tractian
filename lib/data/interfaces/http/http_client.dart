import '../interfaces.dart';

/// Abstract class representing an HTTP client for making various HTTP requests.
abstract class IHttpClient {
  /// Performs an HTTP POST request.
  ///
  /// The [path] defines the endpoint for the request. Optional parameters like
  /// [data], [queryParameters], [headers], and timeouts can be provided.
  Future<HttpResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  });

  /// Performs an HTTP GET request.
  ///
  /// The [path] defines the endpoint for the request. Optional parameters like
  /// [queryParameters], [headers], and timeouts can be provided.
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic> queryParameters,
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  });

  /// Performs an HTTP DELETE request.
  ///
  /// The [path] defines the endpoint for the request. Optional parameters like
  /// [data], [queryParameters], [headers], and timeouts can be provided.
  Future<HttpResponse> delete(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  });

  /// Performs an HTTP PATCH request.
  ///
  /// The [path] defines the endpoint for the request. Optional parameters like
  /// [data], [queryParameters], [headers], and timeouts can be provided.
  Future<HttpResponse> patch(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  });

  /// Performs an HTTP PUT request.
  ///
  /// The [path] defines the endpoint for the request. Optional parameters like
  /// [data], [queryParameters], [headers], and timeouts can be provided.
  Future<HttpResponse> put(
    String path, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  });
}
