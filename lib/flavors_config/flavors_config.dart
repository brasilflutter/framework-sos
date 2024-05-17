import 'package:framework_sos/env/prod_env.dart';

class FlavorConfig {
  final String? name;

  Map<String, dynamic> _variables;

  Map<String, dynamic> get variables => _variables;

  void addRuntimeVariables(Map<String, dynamic> vars) {
    _variables.addAll(vars);
  }

  final Env env;

  FlavorConfig._internal(this.name, this._variables, this.env);

  static late FlavorConfig _instance;

  static FlavorConfig get instance {
    return _instance;
  }

  factory FlavorConfig({String? name, Map<String, dynamic> variables = const {}, required Env env}) {
    _instance = FlavorConfig._internal(name, variables, env);

    return _instance;
  }
}
