import 'package:framework_sos/framework_sos.dart';

abstract class BaseUsecase<Params, Result> {
  Future<BaseWhich<BaseFailure, Result>> call(Params params);
}
