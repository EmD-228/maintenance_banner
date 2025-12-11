import 'package:flutter/material.dart';
import 'maintenance_banner_widget.dart';

class MaintenanceWrapper extends StatelessWidget {
  const MaintenanceWrapper({
    super.key,
    required this.isUnderMaintenance,
    required this.child,
    this.message,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.icon,
    required this.banner,
    this.topPadding,
  });

  final bool  isUnderMaintenance;
  final Widget child;
  final Widget banner;
  final String? message;
  final Color? backgroundColor;
  final Color? textColor;
  final double? height;
  final String? icon;
  final double? topPadding;

  @override
  Widget build(BuildContext context) {
   
    return isUnderMaintenance==true
        ? MaintenanceBannerWidget(
            banner: banner,
            message: message,
            backgroundColor: backgroundColor,
            textColor: textColor,
            height: height,
            icon: icon,
            child: child,
            topPadding: topPadding,
          )
        : child;
  }
}
