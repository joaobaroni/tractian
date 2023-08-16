import 'dart:convert';

import '../../data/data.dart';
import 'package:dio/dio.dart';

class HttpAdapter implements IHttpClient {
  HttpAdapter({required this.baseUrl, this.headers = _defaultHeaders});

  static const _defaultHeaders = {
    'content-type': 'application/json; charset=utf-8',
    'accept': 'application/json',
  };

  final String baseUrl;

  ///
  /// Headers that will be applied to all requests.
  ///
  final Map<String, String>? headers;

  @override
  Future<HttpResponse> get(
    String path, {
    Map<String, dynamic> queryParameters = const {},
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) async {
    return _requestFactory(
        HttpOptions(path: path, method: HttpMethod.get),
        _parseDio(
          connectTimeout: connectTimeout,
          headers: headers,
          receiveTimeout: receiveTimeout,
          sendTimeout: sendTimeout,
        ));
  }

  @override
  Future<HttpResponse> post(
    String path, {
    dynamic data = const {},
    Map<String, dynamic> queryParameters = const {},
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) async {
    return _requestFactory(
        HttpOptions(path: path, method: HttpMethod.post),
        _parseDio(
          connectTimeout: connectTimeout,
          headers: headers,
          receiveTimeout: receiveTimeout,
          sendTimeout: sendTimeout,
        ));
  }

  @override
  Future<HttpResponse> delete(
    String path, {
    dynamic data = const {},
    Map<String, dynamic> queryParameters = const {},
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) async {
    return _requestFactory(
        HttpOptions(path: path, method: HttpMethod.delete),
        _parseDio(
          connectTimeout: connectTimeout,
          headers: headers,
          receiveTimeout: receiveTimeout,
          sendTimeout: sendTimeout,
        ));
  }

  @override
  Future<HttpResponse> patch(
    String path, {
    dynamic data = const {},
    Map<String, dynamic> queryParameters = const {},
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) async {
    return _requestFactory(
        HttpOptions(path: path, method: HttpMethod.patch),
        _parseDio(
          connectTimeout: connectTimeout,
          headers: headers,
          receiveTimeout: receiveTimeout,
          sendTimeout: sendTimeout,
        ));
  }

  @override
  Future<HttpResponse> put(
    String path, {
    dynamic data = const {},
    Map<String, dynamic> queryParameters = const {},
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) async {
    return _requestFactory(
        HttpOptions(path: path, method: HttpMethod.put),
        _parseDio(
          connectTimeout: connectTimeout,
          headers: headers,
          receiveTimeout: receiveTimeout,
          sendTimeout: sendTimeout,
        ));
  }

  BaseOptions get _baseOptions => BaseOptions(
        responseDecoder: (response, _, responseBody) => responseBody.statusCode >= 400 ? '' : utf8.decode(response),
        validateStatus: (statusCode) => statusCode! < 500,
        baseUrl: baseUrl,
        headers: headers,
        receiveTimeout: const Duration(seconds: 5),
        sendTimeout: const Duration(seconds: 3),
      );

  Dio _parseDio({
    Map<String, String>? headers,
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    final Dio client = Dio(_baseOptions);
    if (headers != null) client.options.headers = headers;
    if (connectTimeout != null) client.options.connectTimeout = connectTimeout;
    if (receiveTimeout != null) client.options.receiveTimeout = receiveTimeout;
    if (sendTimeout != null) client.options.sendTimeout = sendTimeout;
    return client;
  }

  Future<HttpResponse> _requestFactory(HttpOptions options, Dio client) async {
    final httpMethod = options.method;

    late final Response response;
    switch (httpMethod) {
      case HttpMethod.delete:
        response = await client.delete(options.path);
      case HttpMethod.get:
        response = await client.get(options.path);
      case HttpMethod.post:
        response = await client.post(options.path);
      case HttpMethod.patch:
        response = await client.patch(options.path);
      case HttpMethod.put:
        response = await client.put(options.path);
    }

    return _handleResponse(response);
  }

  HttpResponse _handleResponse(Response response) {
    final statusCode = response.statusCode;

    if (statusCode! >= 200 && statusCode <= 299) {
      switch (statusCode) {
        case 200:
          return HttpResponse(data: response.data, status: HttpStatus.ok);
        case 201:
          return HttpResponse(data: response.data, status: HttpStatus.created);
        case 202:
          return HttpResponse.empty(status: HttpStatus.accepted);
        default:
          return HttpResponse.empty();
      }
    }

    ///
    /// Should handle all possibles exceptions.
    ///
    throw GenericHttpException(response.statusCode, data: response.data, message: '');
  }
}
