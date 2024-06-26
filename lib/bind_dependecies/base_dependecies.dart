import 'package:auto_injector/auto_injector.dart';

final _autoInjector = AutoInjector();

class BaseDependencies {
  BaseDependencies._();

  static final BaseDependencies _instance = BaseDependencies._();

  static BaseDependencies get instance => _instance;

  T get<T>() => _autoInjector.get<T>();

  T? tryGet<T>() => _autoInjector.tryGet<T?>();

  void add<T>(Function constructor) => _autoInjector.add<T>(constructor);

  void addInstance<T>(T instance) => _autoInjector.addInstance<T>(instance);

  void addSingleton<T>(Function constructor) => _autoInjector.addSingleton<T>(constructor);

  void addLazySingleton<T>(Function constructor) => _autoInjector.addLazySingleton<T>(constructor);

  void commit() => _autoInjector.commit();

  void dispose() => _autoInjector.dispose();
}