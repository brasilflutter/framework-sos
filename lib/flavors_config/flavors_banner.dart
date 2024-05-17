import 'package:flutter/material.dart';

import 'flavors_config.dart';

class FlavorBanner extends StatelessWidget {
  final Widget? child;

  final Color? color;

  final BannerLocation? location;

  const FlavorBanner({
    Key? key,
    this.child,
    this.color,
    this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: FlavorConfig.instance.env.enableBanner,
      replacement: child!,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Banner(
          color: color ?? FlavorConfig.instance.env.bannerColor ?? Theme.of(context).colorScheme.error,
          message: FlavorConfig.instance.name!,
          location: BannerLocation.topEnd,
          textStyle: TextStyle(
            color: (HSLColor.fromColor(color ?? FlavorConfig.instance.env.bannerColor ?? Theme.of(context).colorScheme.error).lightness < 0.8 ? Colors.white : Colors.black87),
            fontSize: 12.0 * 0.85,
            fontWeight: FontWeight.w900,
            height: 1.0,
          ),
          child: child,
        ),
      ),
    );
  }
}
