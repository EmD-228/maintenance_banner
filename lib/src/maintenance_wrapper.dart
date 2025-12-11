import 'package:flutter/material.dart';

import 'maintenance_banner_widget.dart';

/// A wrapper widget that conditionally displays a maintenance banner
/// based on the [isUnderMaintenance] boolean value.
///
/// This widget provides a simple way to toggle maintenance mode
/// throughout your application. When [isUnderMaintenance] is true,
/// the banner is displayed; otherwise, only the child is shown.
///
/// Example:
/// ```dart
/// MaintenanceWrapper(
///   isUnderMaintenance: maintenanceMode,
///   banner: MyCustomBanner(),
///   child: MyApp(),
/// )
/// ```
class MaintenanceWrapper extends StatelessWidget {
  /// Creates a maintenance wrapper widget.
  ///
  /// The [isUnderMaintenance], [banner], and [child] parameters are required.
  ///
  /// The [topPadding] parameter allows customizing the top padding.
  /// If null, it uses the safe area padding minus 8 pixels.
  ///
  /// The [animationDuration] parameter controls the animation speed
  /// when the banner appears or disappears.
  const MaintenanceWrapper({
    super.key,
    required this.isUnderMaintenance,
    required this.child,
    required this.banner,
    this.topPadding,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onBannerShown,
    this.onBannerHidden,
  });

  /// Whether the app is currently under maintenance.
  ///
  /// When `true`, the [banner] is displayed above the [child] content.
  /// When `false`, only the [child] is shown without any banner.
  final bool isUnderMaintenance;

  /// The widget below this wrapper in the tree.
  ///
  /// This is typically your main application content that will be
  /// displayed below the maintenance banner when active.
  final Widget child;

  /// The banner widget to display when [isUnderMaintenance] is `true`.
  ///
  /// This widget will be shown at the top of the screen above the [child]
  /// content. You can customize it with any Flutter widget, such as
  /// a [Container] with custom styling, colors, gradients, and content.
  final Widget banner;

  /// Custom top padding for the banner.
  ///
  /// If null, uses the safe area padding minus 8 pixels.
  /// This ensures the banner doesn't overlap with system UI elements
  /// like the status bar or notch.
  final double? topPadding;

  /// Duration of the animation when the banner appears or disappears.
  ///
  /// Defaults to 300 milliseconds. The banner will animate with a
  /// fade and slide effect using this duration.
  final Duration animationDuration;

  /// Callback function called when the banner is shown.
  ///
  /// This is triggered after the banner animation completes and
  /// the banner is fully visible. Useful for analytics, logging,
  /// or triggering other actions when maintenance mode is activated.
  final VoidCallback? onBannerShown;

  /// Callback function called when the banner is hidden.
  ///
  /// This is triggered when the banner is removed from the widget tree
  /// (when [isUnderMaintenance] changes from `true` to `false`).
  /// Useful for analytics, logging, or triggering other actions
  /// when maintenance mode is deactivated.
  final VoidCallback? onBannerHidden;

  @override
  Widget build(BuildContext context) {
    if (isUnderMaintenance) {
      return MaintenanceBannerWidget(
        banner: banner,
        child: child,
        topPadding: topPadding,
        animationDuration: animationDuration,
        onBannerShown: onBannerShown,
        onBannerHidden: onBannerHidden,
      );
    }

    // Trigger hidden callback when banner is not shown
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onBannerHidden?.call();
    });

    return child;
  }
}
