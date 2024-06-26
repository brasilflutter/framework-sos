import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

enum DeviceUtils {
  mobileSmall(0),
  mobile(400),
  tablet(797),
  desktop(1200),
  webPlatform(-1);

  final double minWidth;
  const DeviceUtils(this.minWidth);

  bool get isPlatform {
    final device = _getPlatform();
    return device == this;
  }

  bool _isResponsiveBreakPoint(BuildContext context) {
    final device = _getDevice(context);
    return device == this;
  }

  DeviceUtils _getDevice(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    if (width > DeviceUtils.desktop.minWidth) return DeviceUtils.desktop;
    if (width > DeviceUtils.tablet.minWidth) return DeviceUtils.tablet;
    if (width > DeviceUtils.mobile.minWidth) return DeviceUtils.mobile;
    return DeviceUtils.mobileSmall;
  }

  DeviceUtils _getPlatform() {
    if (kIsWeb) {
      return DeviceUtils.webPlatform;
    } else if (Platform.isAndroid || Platform.isIOS) {
      return DeviceUtils.mobile;
    } else if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      return DeviceUtils.desktop;
    }
    return DeviceUtils.webPlatform;
  }
}

class ResponsiveProvider extends InheritedWidget {
  final DeviceUtils device;
  final Size? size;
  const ResponsiveProvider({
    required this.device,
    required super.child,
    this.size,
    super.key,
  });

  @override
  bool updateShouldNotify(ResponsiveProvider oldWidget) => device != oldWidget.device;

  static Widget builder(BuildContext context, Widget? child) {
    return _BuildListener(child: child ?? Container());
  }

  bool get isMobileSmall => device == DeviceUtils.mobileSmall;
  bool get isMobile => device == DeviceUtils.mobile;
  bool get isTablet => device == DeviceUtils.tablet;
  bool get isDesktop => device == DeviceUtils.desktop;
  double? get h => size?.height;
  double? get w => size?.width;

  static void _modifyDevice(BuildContext context, void Function(DeviceUtils) deviceCallBack) {
    final provider = ResponsiveProvider.of(context);
    DeviceUtils? result;
    if (DeviceUtils.desktop._isResponsiveBreakPoint(context)) result = DeviceUtils.desktop;
    if (DeviceUtils.tablet._isResponsiveBreakPoint(context)) result = DeviceUtils.tablet;
    if (DeviceUtils.mobile._isResponsiveBreakPoint(context)) result = DeviceUtils.mobile;
    if (DeviceUtils.mobileSmall._isResponsiveBreakPoint(context)) result = DeviceUtils.mobileSmall;

    if (provider.device != result) {
      debugPrint("--Change responsive to -> ${result?.name}");
      WidgetsBinding.instance.addPostFrameCallback((_) {
        deviceCallBack(result!);
      });
    }
  }

  static void _modifySize(BuildContext context, void Function(Size) sizeCallBack) {
    final provider = ResponsiveProvider.of(context);
    final Size size = MediaQuery.sizeOf(context);
    if (provider.size != size) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        sizeCallBack(size);
      });
    }
  }

  static ResponsiveProvider of(BuildContext context) {
    final testProvider = context.dependOnInheritedWidgetOfExactType<ResponsiveProvider>();
    assert(testProvider != null, "ResponsiveProvider not exist in BuildContext");
    return testProvider!;
  }
}

class _BuildListener extends StatefulWidget {
  final Widget child;
  const _BuildListener({required this.child});

  @override
  State<_BuildListener> createState() => _BuildListenerState();
}

class _BuildListenerState extends State<_BuildListener> {
  DeviceUtils device = DeviceUtils.desktop;
  Size? size;

  @override
  void initState() {
    super.initState();
  }

  void modifyDevice(BuildContext context) {
    ResponsiveProvider._modifyDevice(context, (newDevice) => setState(() => device = newDevice));
    ResponsiveProvider._modifySize(context, (newSize) => setState(() => size = newSize));
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveProvider(
      device: device,
      size: size,
      child: Builder(builder: (context) {
        modifyDevice(context);
        return widget.child;
      }),
    );
  }
}

extension ResponsiveProviderContext on BuildContext {
  ResponsiveProvider get responsive => ResponsiveProvider.of(this);
}
