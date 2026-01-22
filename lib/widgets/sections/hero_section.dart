import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme.dart';
import '../../config/constants.dart';
import '../../utils/responsive.dart';
import 'package:provider/provider.dart';
import '../../providers/stats_provider.dart';
import '../common/custom_button.dart';
import '../animations/three_d_animations.dart';

/// Hero Section
/// Main landing section with headline, tagline, image, and CTAs
class HeroSection extends StatelessWidget {
  final VoidCallback onExplorePressed;
  final VoidCallback onDownloadCVPressed;

  const HeroSection({
    super.key,
    required this.onExplorePressed,
    required this.onDownloadCVPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.verticalPadding(context),
      ),
      child: ResponsiveRowColumn(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        reverseOnMobile: true,
        children: [
          // Left: Text Content
          if (isMobile)
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildGreeting(context),
                SizedBox(height: Responsive.elementSpacing(context)),
                _buildHeadline(context, isMobile),
                SizedBox(height: Responsive.elementSpacing(context)),
                _buildSubtitle(context, isMobile),
                SizedBox(height: Responsive.elementSpacing(context) * 1.5),
                _buildCTAs(context, isMobile),
              ],
            )
          else
            Expanded(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildGreeting(context),
                  SizedBox(height: Responsive.elementSpacing(context)),
                  _buildHeadline(context, isMobile),
                  SizedBox(height: Responsive.elementSpacing(context)),
                  _buildSubtitle(context, isMobile),
                  SizedBox(height: Responsive.elementSpacing(context) * 1.5),
                  _buildCTAs(context, isMobile),
                ],
              ),
            ),

          if (!isMobile) SizedBox(width: Responsive.elementSpacing(context)),
          if (isMobile) SizedBox(height: Responsive.elementSpacing(context)),

          // Right: Profile Image
          if (isMobile)
            _buildProfileImage()
          else
            Expanded(flex: 2, child: _buildProfileImage()),
        ],
      ),
    );
  }

  Widget _buildGreeting(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spaceMd,
        vertical: AppTheme.spaceSm,
      ),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.primaryContainer.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppTheme.radiusLg),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('👋', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 8),
          Text(
            AppConstants.greeting,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeadline(BuildContext context, bool isMobile) {
    final fontSize = Responsive.heroFontSize(context);

    return Column(
      crossAxisAlignment: isMobile
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        // Role Chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
          children: [
            _buildRoleChip(context, AppConstants.rolePrimary, true),
            _buildRoleChip(context, AppConstants.roleSecondary, false),
            _buildRoleChip(context, AppConstants.roleTertiary, false),
            _buildRoleChip(context, AppConstants.roleQuaternary, false),
          ],
        ),
        SizedBox(height: Responsive.elementSpacing(context)),

        // Main Headline
        Text(
          AppConstants.tagline,
          textAlign: isMobile ? TextAlign.center : TextAlign.left,
          style: GoogleFonts.outfit(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            height: 1.1,
            color: Theme.of(context).textTheme.displayLarge?.color,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleChip(BuildContext context, String label, bool isPrimary) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isPrimary
            ? Theme.of(context).colorScheme.primaryContainer
            : Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: isPrimary
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context, bool isMobile) {
    return Text(
      AppConstants.subtitle,
      style: GoogleFonts.inter(
        fontSize: Responsive.bodyFontSize(context),
        fontWeight: FontWeight.w400,
        color: Theme.of(context).textTheme.bodyLarge?.color,
        height: 1.7,
      ),
      textAlign: isMobile ? TextAlign.center : TextAlign.left,
    );
  }

  Widget _buildCTAs(BuildContext context, bool isMobile) {
    final buttons = [
      CustomButton(
        text: AppConstants.btnExploreWork,
        onPressed: onExplorePressed,
        type: ButtonType.primary,
        icon: Icons.arrow_forward,
      ),
      const SizedBox(width: 16, height: 16),
      CustomButton(
        text: AppConstants.btnDownloadCV,
        onPressed: onDownloadCVPressed,
        type: ButtonType.secondary,
        icon: Icons.download,
      ),
      Consumer<StatsProvider>(
        builder: (context, stats, child) {
          return Container(
            height: 48, // Match button height
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppTheme.radiusFull),
              border: Border.all(
                color: Theme.of(context).dividerColor.withValues(alpha: 0.5),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.download_done_rounded,
                  size: 16,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  "${(stats.cvDownloadCount / 1000).toStringAsFixed(1)}k",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    ];

    // Use Wrap to prevent overflow on smaller screens
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      children: buttons,
    );
  }

  Widget _buildProfileImage() {
    return FloatingAnimation(
      range: 15,
      duration: const Duration(seconds: 4),
      child: Animated3DCard(
        width: double.infinity,
        height: 500,
        maxTilt: 5,
        child: Stack(
          children: [
            // Profile Image (using the screen.png from assets)
            Image.asset(
              AppConstants.profileImagePath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                return _buildPlaceholder();
              },
            ),

            // Gradient Overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spaceLg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.3),
                    ],
                  ),
                ),
                child: Text(
                  AppConstants.fullName,
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primary100, AppTheme.secondary100],
        ),
      ),
      child: Center(
        child: Icon(Icons.person, size: 120, color: AppTheme.primary300),
      ),
    );
  }
}
