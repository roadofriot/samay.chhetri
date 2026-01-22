import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../config/theme.dart';
import '../../config/constants.dart';
import '../../utils/responsive.dart';
import '../common/custom_button.dart';

/// Top Navigation Bar
/// Responsive navigation with logo, menu items, and CTA
class TopNavBar extends StatefulWidget {
  final VoidCallback onContactPressed;
  final Function(String) onNavItemPressed;

  const TopNavBar({
    super.key,
    required this.onContactPressed,
    required this.onNavItemPressed,
  });

  @override
  State<TopNavBar> createState() => _TopNavBarState();
}

class _TopNavBarState extends State<TopNavBar> {
  final bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    // Add scroll listener here if needed
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        boxShadow: _scrolled ? AppTheme.shadowSm : null,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).dividerTheme.color!,
            width: 1,
          ),
        ),
      ),
      child: ResponsiveContainer(
        child: Row(
          children: [
            // Logo
            _buildLogo(),

            const Spacer(),

            // Navigation Items (Desktop only)
            if (Responsive.isDesktop(context)) ..._buildNavItems(),

            const SizedBox(width: AppTheme.spaceLg),

            // Theme Toggle
            IconButton(
              icon: Icon(
                context.watch<ThemeProvider>().isDarkMode
                    ? Icons.light_mode_outlined
                    : Icons.dark_mode_outlined,
                color: AppTheme.gray600,
              ),
              onPressed: () {
                context.read<ThemeProvider>().toggleTheme();
              },
            ),

            const SizedBox(width: AppTheme.spaceMd),

            // CTA Button (Desktop only)
            if (Responsive.isDesktop(context))
              CustomButton(
                text: AppConstants.btnContact,
                onPressed: widget.onContactPressed,
                type: ButtonType.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),

            // Mobile Menu Button
            if (Responsive.isMobile(context))
              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  _showMobileMenu(context);
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.shadowSm,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.layers_outlined, color: Colors.white, size: 24),
          const SizedBox(width: 8),
          Text(
            'SAMAY',
            style: GoogleFonts.outfit(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildNavItems() {
    return AppConstants.navItems.map((item) {
      return _NavItem(
        label: item['label']!,
        onPressed: () => widget.onNavItemPressed(item['route']!),
      );
    }).toList();
  }

  void _showMobileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppTheme.radius2xl),
        ),
      ),
      builder: (context) => MobileMenu(
        onNavItemPressed: widget.onNavItemPressed,
        onContactPressed: widget.onContactPressed,
      ),
    );
  }
}

/// Navigation Item Widget
class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onPressed;

  const _NavItem({required this.label, required this.onPressed});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: _isHovered ? FontWeight.w600 : FontWeight.w500,
                  color: _isHovered
                      ? AppTheme.primary500
                      : Theme.of(context).textTheme.labelLarge?.color,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _isHovered ? 20 : 0,
                decoration: BoxDecoration(
                  color: AppTheme.primary500,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Mobile Menu
/// Bottom sheet navigation for mobile devices
class MobileMenu extends StatelessWidget {
  final Function(String) onNavItemPressed;
  final VoidCallback onContactPressed;

  const MobileMenu({
    super.key,
    required this.onNavItemPressed,
    required this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spaceXl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppTheme.gray300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          const SizedBox(height: AppTheme.spaceLg),

          // Navigation items
          ...AppConstants.navItems.map((item) {
            return _MobileNavItem(
              label: item['label']!,
              icon: _getIconForLabel(item['label']!),
              onPressed: () {
                Navigator.pop(context);
                onNavItemPressed(item['route']!);
              },
            );
          }),

          const SizedBox(height: AppTheme.spaceLg),

          // Theme Toggle
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Appearance',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.titleLarge?.color,
                ),
              ),
              IconButton(
                icon: Icon(
                  context.watch<ThemeProvider>().isDarkMode
                      ? Icons.light_mode_outlined
                      : Icons.dark_mode_outlined,
                  color: AppTheme.gray600,
                ),
                onPressed: () {
                  context.read<ThemeProvider>().toggleTheme();
                },
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spaceLg),

          // Contact Button
          CustomButton(
            text: AppConstants.btnContact,
            onPressed: () {
              Navigator.pop(context);
              onContactPressed();
            },
            type: ButtonType.primary,
            isFullWidth: true,
          ),

          const SizedBox(height: AppTheme.spaceMd),
        ],
      ),
    );
  }

  IconData _getIconForLabel(String label) {
    switch (label.toLowerCase()) {
      case 'about':
        return Icons.person_outline;
      case 'experience':
        return Icons.work_outline;
      case 'portfolio':
        return Icons.folder_outlined;
      case 'services':
        return Icons.business_center_outlined;
      case 'contact':
        return Icons.email_outlined;
      default:
        return Icons.circle_outlined;
    }
  }
}

/// Mobile Navigation Item
class _MobileNavItem extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  const _MobileNavItem({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppTheme.spaceMd,
          horizontal: AppTheme.spaceLg,
        ),
        margin: const EdgeInsets.only(bottom: AppTheme.spaceSm),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: AppTheme.primary500),
            const SizedBox(width: AppTheme.spaceMd),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, size: 16, color: AppTheme.gray400),
          ],
        ),
      ),
    );
  }
}
