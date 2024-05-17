import 'package:framework_sos/framework_sos.dart';

abstract class BaseRepository {
  BaseRepository();

  Future<BaseWhich<BaseFailure, S>> tryExecute<S>(
    Future<S> Function() exec, {
    BaseFailure Function(NoConnectionException e)? onNoConnectionException,
    BaseFailure Function(DataPersistenceException e)? onDataPersistenceException,
    BaseFailure Function(ServerException e)? onServerException,
    BaseFailure Function(Exception e)? onOtherException,
  }) async {
    try {
      S result = await exec();
      return IsResult(result);
    } on NoConnectionException catch (e) {
      if (onNoConnectionException != null) return IsError(onNoConnectionException(e));
      return IsError(NoConnectionFailure(stackTrace: StackTrace.current));
    } on DataPersistenceException catch (e) {
      if (onDataPersistenceException != null) return IsError(onDataPersistenceException(e));
      return IsError(CastFailure(stackTrace: StackTrace.current));
    } on ServerException catch (e) {
      if (onServerException != null) return IsError(onServerException(e));
      return IsError(ServerFailure(message: '${e.codeMessage} ${e.dataMessage}', stackTrace: StackTrace.current, serverException: e));
    } on Exception catch (e) {
      if (onOtherException != null) return IsError(onOtherException(e));
      return IsError(CastFailure(stackTrace: StackTrace.current));
    }
  }
}
