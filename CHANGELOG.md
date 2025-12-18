# Changelog

All notable changes to this project will be documented in this file.

## [0.2.2] - 2024-12-11

### Changed
- Updated README to use HTML image format for better display on pub.dev
- Updated installation instructions to reflect version 0.2.1

## [0.2.1] - 2024-12-11

### Fixed
- Fixed padding calculation to prevent negative values when safe area padding is less than 8 pixels
- Fixed callback timing: `onBannerHidden` now only triggers on actual state transitions (from `true` to `false`)
- Fixed `onBannerShown` callback to fire after animation completes instead of immediately
- Improved state management by converting `MaintenanceWrapper` to `StatefulWidget` for proper callback tracking

## [0.2.0] - 2024-12-11

### Added
- Smooth slide and fade animations when banner appears/disappears
- `animationDuration` parameter to customize animation speed
- `onBannerShown` callback to track when banner is displayed
- `onBannerHidden` callback to track when banner is hidden
- Comprehensive API documentation for all public members

### Changed
- Improved code structure and removed unused parameters
- Enhanced documentation with detailed descriptions and examples
- Better animation implementation using `TweenAnimationBuilder`

### Fixed
- Code formatting issues for pub.dev static analysis
- Documentation coverage now exceeds 20% requirement

## [0.1.1] - 2024-12-11

### Changed
- Translated all content to English
- Updated documentation and examples
- Improved example app with modern UI design
- Added screenshot for pub.dev

### Fixed
- Fixed negative height constraint issue in banner widget
- Improved safe area handling

## [0.1.0] - 2024-01-01

### Added
- Initial release
- `MaintenanceBannerWidget` for displaying maintenance banners
- `MaintenanceWrapper` for reactive maintenance mode handling
- Customizable message, colors, height, and icon

