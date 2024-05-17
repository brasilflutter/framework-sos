import 'package:flutter/material.dart';

abstract class Env {
  final String baseUrl;

  final bool devMode;

  final bool enableWatermark;
  final bool hasResearch;
  final bool enableBanner;
  final Color? bannerColor;
  final bool useMocks;

  const Env({required this.baseUrl, this.devMode = false, this.enableWatermark = true, this.hasResearch = false, this.enableBanner = false, this.useMocks = false, this.bannerColor});
}

class DevEnv extends Env {
  @override
  bool get enableWatermark => true;

  @override
  bool get enableBanner => true;

  const DevEnv({required super.baseUrl, super.devMode = true, super.hasResearch = false, super.useMocks = false, super.bannerColor = Colors.blue});
}

class ProdEnv extends Env {
  @override
  bool get devMode => true;
  @override
  bool get enableWatermark => false;
  @override
  bool get hasResearch => false;
  @override
  bool get enableBanner => false;

  const ProdEnv({required super.baseUrl});
}
