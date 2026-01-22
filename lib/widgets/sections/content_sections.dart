import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme.dart';
import '../../config/constants.dart';
import '../../utils/responsive.dart';
import '../common/custom_button.dart';
import '../animations/three_d_animations.dart';

/// About Section
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionSpacing(context),
      ),
      child: ResponsiveContainer(
        child: ResponsiveRowColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left: Title
            Expanded(
              flex: isMobile ? 1 : 2,
              child: Column(
                crossAxisAlignment: isMobile
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(context, AppConstants.aboutTitle),
                ],
              ),
            ),

            if (!isMobile)
              SizedBox(width: Responsive.elementSpacing(context) * 2),

            // Right: Description
            Expanded(
              flex: isMobile ? 1 : 3,
              child: Text(
                AppConstants.aboutText,
                style: GoogleFonts.inter(
                  fontSize: Responsive.bodyFontSize(context),
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  height: 1.7,
                ),
                textAlign: isMobile ? TextAlign.center : TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
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
          width: 1.5,
        ),
      ),
      child: Text(
        title,
        style: GoogleFonts.outfit(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

/// Experience Section
class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionSpacing(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Professional Experience",
            style: GoogleFonts.outfit(
              fontSize: Responsive.titleFontSize(context),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.headlineLarge?.color,
            ),
          ),
          SizedBox(height: Responsive.elementSpacing(context)),
          ...AppConstants.experience.map(
            (exp) => _buildExperienceCard(context, exp),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(BuildContext context, Map<String, dynamic> exp) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Animated3DCard(
        width: double.infinity,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Theme.of(context).cardTheme.color,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Theme.of(context).dividerTheme.color!),
            boxShadow: isDark ? [] : AppTheme.shadowSm,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      exp['role'],
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  if (exp['location'].isNotEmpty)
                    Chip(
                      label: Text(exp['location']),
                      backgroundColor: Theme.of(context).colorScheme.surface,
                    ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                exp['company'],
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              if (exp['year'] != null) ...[
                const SizedBox(height: 4),
                Text(
                  exp['year'],
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontStyle: FontStyle.italic,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                ),
              ],
              const SizedBox(height: 16),
              ...(exp['highlights'] as List).map(
                (highlight) => Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 18,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          highlight,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.color,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tech Edge Section
class TechEdgeSection extends StatelessWidget {
  const TechEdgeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionSpacing(context),
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            Text(
              "The Tech Edge",
              style: GoogleFonts.outfit(
                fontSize: Responsive.titleFontSize(context),
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.headlineLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Responsive.elementSpacing(context)),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: Responsive.gridCrossAxisCount(
                context,
                maxColumns: 3,
              ),
              mainAxisSpacing: 24,
              crossAxisSpacing: 24,
              childAspectRatio: 0.8, // Taller cards
              children: AppConstants.techEdge
                  .map((tech) => _buildTechCard(context, tech))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTechCard(BuildContext context, Map<String, String> tech) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    IconData iconData = Icons.code;
    switch (tech['icon']) {
      case 'smartphone_outlined':
        iconData = Icons.smartphone_outlined;
        break;
      case 'lightbulb_outlined':
        iconData = Icons.lightbulb_outlined;
        break;
      case 'laptop_mac_outlined':
        iconData = Icons.laptop_mac_outlined;
        break;
      case 'psychology_outlined':
        iconData = Icons.psychology_outlined;
        break;
      default:
        iconData = Icons.code;
    }

    return FloatingAnimation(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Theme.of(context).dividerTheme.color!),
          boxShadow: isDark ? [] : AppTheme.shadowMd,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 48,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              tech['title']!,
              style: GoogleFonts.outfit(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              tech['description']!,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Skills Section
class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionSpacing(context),
      ),
      child: Column(
        children: [
          Text(
            "Skills & Expertise",
            style: GoogleFonts.outfit(
              fontSize: Responsive.titleFontSize(context),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.headlineLarge?.color,
            ),
          ),
          SizedBox(height: Responsive.elementSpacing(context)),
          ResponsiveRowColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: AppConstants.skillsByCategory.entries.map((entry) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _buildSkillCategory(context, entry.key, entry.value),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCategory(
    BuildContext context,
    String title,
    List<String> skills,
  ) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: skills
                .map(
                  (skill) => Chip(
                    label: Text(skill),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    labelStyle: TextStyle(
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

/// Dynamic Focus Section
class FocusSection extends StatelessWidget {
  const FocusSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionSpacing(context),
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            Text(
              "What's Happening Now",
              style: GoogleFonts.outfit(
                fontSize: Responsive.titleFontSize(context),
                fontWeight: FontWeight.w700,
                color: Theme.of(context).textTheme.headlineLarge?.color,
              ),
            ),
            SizedBox(height: Responsive.elementSpacing(context)),
            Column(
              children: AppConstants.currentFocus
                  .map((item) => _buildFocusItem(context, item))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusItem(BuildContext context, Map<String, String> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Icon(
            Icons.arrow_right_alt,
            color: Theme.of(context).colorScheme.primary,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
                children: [
                  TextSpan(
                    text: "${item['area']}: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: item['detail']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Interests Section
class InterestsSection extends StatelessWidget {
  const InterestsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionSpacing(context),
      ),
      child: Column(
        children: [
          Text(
            "Extra-Curricular & Interests",
            style: GoogleFonts.outfit(
              fontSize: Responsive.titleFontSize(context),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.headlineLarge?.color,
            ),
          ),
          SizedBox(height: Responsive.elementSpacing(context)),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            alignment: WrapAlignment.center,
            children: AppConstants.interests
                .map((interest) => _buildInterestCard(context, interest))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildInterestCard(
    BuildContext context,
    Map<String, String> interest,
  ) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerTheme.color!),
        ),
        child: Column(
          children: [
            Text(
              interest['title']!,
              style: GoogleFonts.outfit(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Theme.of(context).colorScheme.secondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              interest['description']!,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: Theme.of(context).textTheme.bodyMedium?.color,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

/// Education Section
class EducationSection extends StatelessWidget {
  const EducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionSpacing(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Education",
            style: GoogleFonts.outfit(
              fontSize: Responsive.titleFontSize(context),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.headlineLarge?.color,
            ),
          ),
          SizedBox(height: Responsive.elementSpacing(context)),
          ...AppConstants.education.map(
            (edu) => _buildEducationCard(context, edu),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(BuildContext context, Map<String, String> edu) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Theme.of(context).dividerTheme.color!),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.school_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    edu['degree']!,
                    style: GoogleFonts.outfit(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).textTheme.titleLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    edu['institution']!,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      color: Theme.of(context).textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    edu['year']!,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).textTheme.bodyMedium?.color,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Achievements Section
class AchievementsSection extends StatelessWidget {
  const AchievementsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionSpacing(context),
      ),
      child: Column(
        children: [
          Text(
            "Honors & Achievements",
            style: GoogleFonts.outfit(
              fontSize: Responsive.titleFontSize(context),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.headlineLarge?.color,
            ),
          ),
          SizedBox(height: Responsive.elementSpacing(context)),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: Responsive.gridCrossAxisCount(
              context,
              maxColumns: 2,
            ),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 2.5,
            children: AppConstants.achievements
                .map((item) => _buildAchievementCard(context, item))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildAchievementCard(BuildContext context, Map<String, String> item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).colorScheme.secondary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.emoji_events_outlined,
            color: Theme.of(context).colorScheme.secondary,
            size: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item['title']!,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  item['description']!,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// References Section
class ReferencesSection extends StatelessWidget {
  const ReferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionSpacing(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "References",
            style: GoogleFonts.outfit(
              fontSize: Responsive.titleFontSize(context),
              fontWeight: FontWeight.w700,
              color: Theme.of(context).textTheme.headlineLarge?.color,
            ),
          ),
          SizedBox(height: Responsive.elementSpacing(context)),
          ...AppConstants.references.map(
            (ref) => _buildReferenceItem(context, ref),
          ),
        ],
      ),
    );
  }

  Widget _buildReferenceItem(BuildContext context, Map<String, String> ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(
            Icons.business,
            color: Theme.of(context).colorScheme.primary,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              "${ref['name']} (${ref['location']})",
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            ref['contact']!,
            style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// CTA Section
/// Call-to-action section at the bottom
class CTASection extends StatelessWidget {
  final VoidCallback onDownloadCVPressed;
  final VoidCallback onGetStartedPressed;

  const CTASection({
    super.key,
    required this.onDownloadCVPressed,
    required this.onGetStartedPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.primary600, AppTheme.secondary600],
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: Responsive.sectionSpacing(context),
      ),
      child: ResponsiveContainer(
        child: Column(
          children: [
            Text(
              AppConstants.ctaTitle,
              style: GoogleFonts.outfit(
                fontSize: Responsive.titleFontSize(context),
                fontWeight: FontWeight.w700,
                color: Colors.white,
                height: 1.2,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Responsive.elementSpacing(context)),
            Text(
              AppConstants.ctaSubtitle,
              style: GoogleFonts.inter(
                fontSize: Responsive.bodyFontSize(context),
                fontWeight: FontWeight.w400,
                color: Colors.white.withValues(alpha: 0.9),
                height: 1.6,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Responsive.elementSpacing(context) * 1.5),
            _buildCTAButtons(isMobile),
          ],
        ),
      ),
    );
  }

  Widget _buildCTAButtons(bool isMobile) {
    final buttons = [
      CustomButton(
        text: AppConstants.btnDownloadCV,
        onPressed: onDownloadCVPressed,
        type: ButtonType.secondary,
        icon: Icons.download,
        foregroundColor: Colors.white,
      ),
      const SizedBox(width: 16, height: 16),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onGetStartedPressed,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    AppConstants.btnGetStarted,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.primary600,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward,
                    size: 20,
                    color: AppTheme.primary600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ];

    // Use Wrap to prevent overflow on smaller screens
    return Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: buttons,
    );
  }
}
