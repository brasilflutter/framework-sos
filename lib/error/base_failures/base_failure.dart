import 'package:framework_sos/error/base_exceptions/exception.dart';
import 'package:logger/logger.dart';

abstract class BaseFailure {
  final String title;
  final String message;
  final Object? objectError;
  final StackTrace? stackTrace;

  BaseFailure({
    required this.title,
    required this.message,
    this.objectError,
    this.stackTrace,
  }) {
    final Logger logger = Logger();
    logger.e('$runtimeType: $title \n$message ${objectError != null ? '\nClasse: $objectError' : ''} \nStackTrace: $stackTrace');
  }
}

class ServerFailure extends BaseFailure {
  final ServerException serverException;
  ServerFailure({
    super.title = 'Erro de servidor',
    required super.message,
    required super.stackTrace,
    required this.serverException,
  });
}

class CastFailure extends BaseFailure {
  CastFailure({
    super.title = 'Erro de conversão',
    super.message = 'Parece que houve um erro de conversão de dados',
    super.objectError,
    required super.stackTrace,
  });
}

class NoConnectionFailure extends BaseFailure {
  NoConnectionFailure({
    super.title = 'Erro de conexão',
    super.message = 'Parece que você não está conectado à internet',
    required super.stackTrace,
  });
}
