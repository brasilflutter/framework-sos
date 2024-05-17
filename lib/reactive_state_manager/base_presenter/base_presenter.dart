import 'package:flutter/material.dart';
import 'package:framework_sos/framework_sos.dart';

abstract class BasePresenter<C extends BaseController> extends StatefulWidget {
  const BasePresenter({super.key});

  C createController(BaseDependencies dependencies);

  LoadingBaseView buildLoading(BuildContext context, LoadingBaseState state);

  ErrorBaseView buildError(BuildContext context, ErrorBaseState state);

  SuccessBaseView buildSuccess(BuildContext context, SuccessBaseState state);

  @override
  BasePresenterState createState() => BasePresenterState<C>();
}

class BasePresenterState<C extends BaseController> extends State<BasePresenter<C>> {
  C? _controller;
  C get controller => _controller ??= widget.createController(BaseDependencies.instance);

  @override
  dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, state, child) {
        if (state is LoadingBaseState) return widget.buildLoading(context, state);
        if (state is ErrorBaseState) return widget.buildError(context, state);
        if (state is SuccessBaseState) return widget.buildSuccess(context, state);
        throw Exception('Unknown state: $state');
      },
    );
  }
}
