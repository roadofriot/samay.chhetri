import 'package:flutter/material.dart';
import '../config/constants.dart';

/// Responsive Utility Class
/// Helper methods for building responsive layouts
class Responsive {
  // ===========================
  // DEVICE TYPE DETECTION
  // ===========================

  /// Returns true if screen width is mobile size
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < AppConstants.breakpointMobile;
  }

  /// Returns true if screen width is tablet size
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= AppConstants.breakpointMobile &&
        width < AppConstants.breakpointTablet;
  }

  /// Returns true if screen width is desktop size
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.breakpointTablet;
  }

  /// Returns true if screen width is wide desktop
  static bool isWide(BuildContext context) {
    return MediaQuery.of(context).size.width >= AppConstants.breakpointDesktop;
  }

  // ===========================
  // VALUE GETTERS
  // ===========================

  /// Get screen width
  static double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// Get screen height
  static double height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// Get responsive value based on screen size
  /// Usage: Responsive.value(context, mobile: 16, tablet: 20, desktop: 24)
  static T value<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    }
    return mobile;
  }

  /// Get max container width based on screen size
  static double maxWidth(BuildContext context) {
    if (isWide(context)) {
      return AppConstants.maxWidthWide;
    } else if (isDesktop(context)) {
      return AppConstants.maxWidthDesktop;
    } else if (isTablet(context)) {
      return AppConstants.maxWidthTablet;
    }
    return AppConstants.maxWidthMobile;
  }

  /// Get horizontal padding based on screen size
  static double horizontalPadding(BuildContext context) {
    if (isDesktop(context)) {
      return 48.0;
    } else if (isTablet(context)) {
      return 32.0;
    }
    return 16.0;
  }

  /// Get vertical padding based on screen size
  static double verticalPadding(BuildContext context) {
    if (isDesktop(context)) {
      return 64.0;
    } else if (isTablet(context)) {
      return 48.0;
    }
    return 32.0;
  }

  // ===========================
  // RESPONSIVE WIDGETS
  // ===========================

  /// Returns different widgets based on screen size
  static Widget responsive({
    required BuildContext context,
    required Widget mobile,
    Widget? tablet,
    Widget? desktop,
  }) {
    if (isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile;
    }
    return mobile;
  }

  // ===========================
  // GRID COLUMNS
  // ===========================

  /// Get number of grid columns based on screen size
  static int gridCrossAxisCount(BuildContext context, {int? maxColumns}) {
    final defaultColumns = isDesktop(context)
        ? 3
        : isTablet(context)
        ? 2
        : 1;

    if (maxColumns != null && defaultColumns > maxColumns) {
      return maxColumns;
    }

    return defaultColumns;
  }

  /// Get grid spacing based on screen size
  static double gridSpacing(BuildContext context) {
    if (isDesktop(context)) {
      return 24.0;
    } else if (isTablet(context)) {
      return 16.0;
    }
    return 16.0;
  }

  // ===========================
  // FONT SIZES
  // ===========================

  /// Get responsive font size for hero headline
  static double heroFontSize(BuildContext context) {
    if (isDesktop(context)) {
      return 72.0;
    } else if (isTablet(context)) {
      return 48.0;
    }
    return 36.0;
  }

  /// Get responsive font size for section titles
  static double titleFontSize(BuildContext context) {
    if (isDesktop(context)) {
      return 48.0;
    } else if (isTablet(context)) {
      return 36.0;
    }
    return 28.0;
  }

  /// Get responsive font size for body text
  static double bodyFontSize(BuildContext context) {
    if (isDesktop(context)) {
      return 18.0;
    } else if (isTablet(context)) {
      return 16.0;
    }
    return 14.0;
  }

  // ===========================
  // SPACING
  // ===========================

  /// Get responsive section spacing
  static double sectionSpacing(BuildContext context) {
    if (isDesktop(context)) {
      return 96.0;
    } else if (isTablet(context)) {
      return 64.0;
    }
    return 48.0;
  }

  /// Get responsive element spacing
  static double elementSpacing(BuildContext context) {
    if (isDesktop(context)) {
      return 32.0;
    } else if (isTablet(context)) {
      return 24.0;
    }
    return 16.0;
  }
}

/// Responsive Container Widget
/// Automatically adds max width and horizontal padding
class ResponsiveContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? color;

  const ResponsiveContainer({
    super.key,
    required this.child,
    this.padding,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: double.infinity,
      padding:
          padding ??
          EdgeInsets.symmetric(
            horizontal: Responsive.horizontalPadding(context),
          ),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
          child: child,
        ),
      ),
    );
  }
}

/// Responsive Row/Column Widget
/// Switches between Row and Column based on screen size
class ResponsiveRowColumn extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisSize mainAxisSize;
  final bool reverseOnMobile;

  const ResponsiveRowColumn({
    super.key,
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisSize = MainAxisSize.max,
    this.reverseOnMobile = false,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    if (isMobile) {
      return Column(
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment == CrossAxisAlignment.center
            ? CrossAxisAlignment.center
            : crossAxisAlignment == CrossAxisAlignment.start
            ? CrossAxisAlignment.stretch
            : CrossAxisAlignment.stretch,
        mainAxisSize: mainAxisSize,
        children: reverseOnMobile ? children.reversed.toList() : children,
      );
    }

    return Row(
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      children: children,
    );
  }
}

/// Responsive Spacing Widget
/// Adds vertical or horizontal spacing based on orientation
class ResponsiveSpacing extends StatelessWidget {
  final double? mobile;
  final double? tablet;
  final double? desktop;

  const ResponsiveSpacing({super.key, this.mobile, this.tablet, this.desktop});

  @override
  Widget build(BuildContext context) {
    final spacing = Responsive.value<double>(
      context: context,
      mobile: mobile ?? 16.0,
      tablet: tablet ?? 24.0,
      desktop: desktop ?? 32.0,
    );

    if (Responsive.isMobile(context)) {
      return SizedBox(height: spacing);
    }

    return SizedBox(width: spacing);
  }
}
