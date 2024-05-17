abstract class LoadingBaseState {}

abstract class ErrorBaseState {}

abstract class SuccessBaseState {}

typedef VoidCallbackLoadingState<S extends LoadingBaseState> = void Function(S state);

typedef VoidCallbackErrorState<S extends ErrorBaseState> = void Function(S state);

typedef VoidCallbackSuccessState<S extends SuccessBaseState> = void Function(S state);
