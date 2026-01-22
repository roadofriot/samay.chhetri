import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme.dart';
import '../animations/three_d_animations.dart';

/// Stat Card Widget
/// Displays a statistic with icon, value, and label
class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color? iconColor;
  final Color? valueColor;

  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    this.iconColor,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Animated3DCard(
      width: double.infinity,
      height: 180,
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spaceXl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Icon
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: (iconColor ?? AppTheme.primary500).withValues(
                  alpha: 0.1,
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusMd),
              ),
              child: Icon(
                icon,
                size: 32,
                color: iconColor ?? AppTheme.primary500,
              ),
            ),

            // Value and Label
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style: GoogleFonts.outfit(
                    fontSize: 36,
                    fontWeight: FontWeight.w700,
                    color: valueColor ?? AppTheme.primary600,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: AppTheme.gray600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Skill Badge Widget
/// Displays a skill with icon and name
class SkillBadge extends StatefulWidget {
  final String icon;
  final String name;
  final String? description;

  const SkillBadge({
    super.key,
    required this.icon,
    required this.name,
    this.description,
  });

  @override
  State<SkillBadge> createState() => _SkillBadgeState();
}

class _SkillBadgeState extends State<SkillBadge> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppTheme.spaceMd,
          vertical: AppTheme.spaceSm,
        ),
        decoration: BoxDecoration(
          color: _isHovered ? AppTheme.primary50 : AppTheme.gray100,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: _isHovered ? AppTheme.primary200 : AppTheme.gray200,
            width: 1.5,
          ),
        ),
        transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(widget.icon, style: const TextStyle(fontSize: 20)),
            const SizedBox(width: 8),
            Text(
              widget.name,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _isHovered ? AppTheme.primary700 : AppTheme.gray700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Project Card Widget
/// Displays a project with image, title, and description
class ProjectCard extends StatelessWidget {
  final String title;
  final String description;
  final String? imageUrl;
  final List<String> tags;
  final VoidCallback? onTap;

  const ProjectCard({
    super.key,
    required this.title,
    required this.description,
    this.imageUrl,
    this.tags = const [],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Animated3DCard(
        width: double.infinity,
        height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Project Image
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppTheme.primary100, AppTheme.secondary100],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: imageUrl != null
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildPlaceholder();
                        },
                      )
                    : _buildPlaceholder(),
              ),
            ),

            // Project Info
            Padding(
              padding: const EdgeInsets.all(AppTheme.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.gray900,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppTheme.gray600,
                      height: 1.5,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (tags.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: tags.map((tag) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primary50,
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusSm,
                            ),
                          ),
                          child: Text(
                            tag,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: AppTheme.primary600,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Icon(Icons.code, size: 64, color: AppTheme.primary300),
    );
  }
}

/// Section Header Widget
/// Consistent header for each section
class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final TextAlign textAlign;
  final Color? titleColor;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.textAlign = TextAlign.left,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: textAlign == TextAlign.center
          ? CrossAxisAlignment.center
          : CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.outfit(
            fontSize: 48,
            fontWeight: FontWeight.w700,
            color: titleColor ?? AppTheme.gray900,
            height: 1.2,
          ),
          textAlign: textAlign,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 16),
          Text(
            subtitle!,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: AppTheme.gray600,
              height: 1.6,
            ),
            textAlign: textAlign,
          ),
        ],
      ],
    );
  }
}
