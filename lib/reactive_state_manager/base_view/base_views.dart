import 'package:flutter/material.dart';
import 'package:framework_sos/reactive_state_manager/base_states/base_states.dart';

abstract class BaseView<S> extends StatelessWidget {
  final S state;
  const BaseView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return buildView(context);
  }

  Widget buildView(BuildContext context);
}

abstract class LoadingBaseView<S extends LoadingBaseState> extends BaseView<S> {
  const LoadingBaseView({super.key, required super.state});
}

abstract class ErrorBaseView<S extends ErrorBaseState> extends BaseView<S> {
  const ErrorBaseView({super.key, required super.state});
}

abstract class SuccessBaseView<S extends SuccessBaseState> extends BaseView<S> {
  const SuccessBaseView({super.key, required super.state});
}
