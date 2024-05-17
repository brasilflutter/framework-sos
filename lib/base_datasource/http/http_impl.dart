import 'package:framework_sos/framework_sos.dart';

class HttpImpl implements IHttp {
  final Dio _dio;
  final Logger _logger = Logger();

  HttpImpl(this._dio, {Interceptor? interceptor}) {
    if (interceptor != null) {
      _addInterceptor(interceptor);
    }
  }

  Future<Response> _execute(Future<Response> Function() func) async {
    try {
      final response = await func();
      _logInfos(response.requestOptions.path, response.requestOptions.method,
          queryParameters: response.requestOptions.queryParameters, headers: response.requestOptions.headers, data: response.requestOptions.data);
      _logResponse(response.requestOptions.path, response.requestOptions.method, headers: response.requestOptions.headers, response: response);
      return response;
    } on DioException catch (e) {
      _logger.e("DioException: ${e.message}");
      if (e.response?.statusCode != null) {
        _logErrorResponse(e.response!);
        throw ServerException(statusCode: e.response?.statusCode ?? 0, statusMessage: e.response?.statusMessage ?? '', dataMessage: e.response?.data.toString() ?? '');
      } else {
        throw NoConnectionException();
      }
    } on TypeError {
      throw DataPersistenceException();
    } catch (e) {
      _logger.e("Unexpected error: $e");
      if (e is ServerException || e is DataPersistenceException) {
        rethrow;
      }
      throw NoConnectionException();
    }
  }

  @override
  Future<Response> get(String path, {Map<String, dynamic>? queryParameters}) async => _execute(() => _dio.get(path, queryParameters: queryParameters));

  @override
  Future<Response> post(String path, dynamic data, {Map<String, dynamic>? queryParameters}) async => _execute(() => _dio.post(path, queryParameters: queryParameters, data: data));

  @override
  Future<Response> delete(String path, {Map<String, dynamic>? queryParameters, dynamic data}) async => _execute(() => _dio.delete(path, queryParameters: queryParameters, data: data));

  @override
  Future<Response> put(String path, dynamic data, {Map<String, dynamic>? queryParameters}) async => _execute(() => _dio.put(path, queryParameters: queryParameters, data: data));

  @override
  Future<Response> patch(String path, dynamic data, {Map<String, dynamic>? queryParameters}) async => _execute(() => _dio.patch(path, queryParameters: queryParameters, data: data));

  // Adds an interceptor to Dio for request/response modifications.
  void _addInterceptor(Interceptor interceptor) => _dio.interceptors.add(interceptor);

  // Logs request information.
  void _logInfos(String path, String method, {Map<String, dynamic>? queryParameters, Map<String, dynamic>? headers, dynamic data}) {
    _logger.d('Method: $method \nPath: ${_dio.options.baseUrl}$path \nQueryParam: $queryParameters \nData: $data \nHeaders: $headers');
  }

  // Logs successful responses.
  void _logResponse(String path, String method, {Map<String, dynamic>? headers, Response? response}) {
    _logger.d('[RESPONSE]: ${response?.statusCode}\nMethod: $method \nPath: ${_dio.options.baseUrl}$path \nResponse: ${response?.data}');
  }

  // Logs error responses.
  void _logErrorResponse(Response response) {
    _logger.e('[ERROR RESPONSE]: ${response.statusCode}\nPath: ${response.requestOptions.path} \nResponse: ${response.data}');
  }
}
