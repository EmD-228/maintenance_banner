/// A Flutter package for displaying customizable maintenance banners
/// at the top of your application.
///
/// This package provides widgets to easily show maintenance banners
/// when your app is under maintenance, with smooth animations and
/// customizable appearance.
///
/// ## Usage
///
/// ```dart
/// import 'package:maintenance_banner/maintenance_banner.dart';
///
/// MaintenanceWrapper(
///   isUnderMaintenance: true,
///   banner: MyCustomBanner(),
///   child: MyApp(),
/// )
/// ```
///
/// See the [MaintenanceWrapper] widget for more details.
library maintenance_banner;

export 'src/maintenance_banner_widget.dart';
export 'src/maintenance_wrapper.dart';
