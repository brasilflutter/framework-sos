import 'package:flutter/material.dart';

abstract class BaseController<S> extends ValueNotifier<S> {
  BaseController(super.state) {
    init();
  }

  init();

  emit(S state) => value = state;
}
