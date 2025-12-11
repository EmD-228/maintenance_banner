import 'package:flutter/material.dart';

class MaintenanceBannerWidget extends StatelessWidget {
  const MaintenanceBannerWidget({
    super.key,
    required this.child,
    this.message,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.icon,
    required this.banner,
    this.topPadding,
  });

  final Widget child;
  final Widget banner;
  final double? topPadding;
  final String? message;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding.top;
    final spacing = (padding - 8).clamp(0.0, double.infinity);

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: topPadding ?? padding - 8),
          child: child,
        ),
        Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [if (spacing > 0) SizedBox(height: spacing), banner],
          ),
        ),
      ],
    );
  }
}
