import 'package:flutter/material.dart';

/// A widget that displays a maintenance banner at the top of the screen
/// while allowing the child content to be displayed below it.
///
/// The banner is positioned using a [Stack] and automatically handles
/// safe area insets to avoid overlapping with system UI elements.
class MaintenanceBannerWidget extends StatelessWidget {
  /// Creates a maintenance banner widget.
  ///
  /// The [banner] and [child] parameters are required.
  ///
  /// The [topPadding] parameter allows customizing the top padding.
  /// If null, it uses the safe area padding minus 8 pixels.
  ///
  /// The [animationDuration] parameter controls the animation speed
  /// when the banner appears or disappears.
  const MaintenanceBannerWidget({
    super.key,
    required this.child,
    required this.banner,
    this.topPadding,
    this.animationDuration = const Duration(milliseconds: 300),
    this.onBannerShown,
    this.onBannerHidden,
  });

  /// The widget below this banner in the tree.
  ///
  /// This is the main content of your application that will be displayed
  /// below the maintenance banner.
  final Widget child;

  /// The banner widget to display at the top of the screen.
  ///
  /// This widget will be shown above the [child] content when the banner
  /// is active. You can customize it with any Flutter widget, such as
  /// a [Container] with custom styling, colors, and content.
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
  /// the banner is fully visible. Useful for analytics or logging.
  final VoidCallback? onBannerShown;

  /// Callback function called when the banner is hidden.
  ///
  /// This is triggered when the banner is removed from the widget tree.
  /// Useful for analytics or logging.
  final VoidCallback? onBannerHidden;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding.top;
    // Calculate safe spacing (padding - 8, clamped to prevent negative values)
    final safeSpacing = (padding - 8).clamp(0.0, double.infinity);
    // Calculate banner height, ensuring it's never negative
    final calculatedBannerHeight = topPadding ?? safeSpacing;
    final bannerHeight = calculatedBannerHeight.clamp(0.0, double.infinity);

    // Trigger callbacks after animation completes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(animationDuration, () {
        onBannerShown?.call();
      });
    });

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: bannerHeight),
          child: child,
        ),
        Material(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (safeSpacing > 0) SizedBox(height: safeSpacing),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: animationDuration,
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, -20 * (1 - value)),
                      child: banner,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
