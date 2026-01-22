import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import '../providers/stats_provider.dart';
import '../config/theme.dart';
import '../config/constants.dart';
import '../widgets/navigation/top_nav_bar.dart';
import '../widgets/sections/hero_section.dart';
import '../widgets/sections/content_sections.dart';

/// Home Screen
/// Main landing page with all sections
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  // GlobalKeys for sections
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _educationKey = GlobalKey();
  final GlobalKey _focusKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    // Increment profile visit count on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StatsProvider>().incrementProfileVisit();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          // Top Navigation Bar
          TopNavBar(
            onContactPressed: _handleContactPressed,
            onNavItemPressed: _handleNavigation,
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  // Hero Section
                  HeroSection(
                    onExplorePressed: _handleExploreWork,
                    onDownloadCVPressed: _handleDownloadCV,
                  ),

                  // About Section
                  AboutSection(key: _aboutKey),

                  // Experience Section
                  ExperienceSection(key: _experienceKey),

                  // Education Section
                  EducationSection(key: _educationKey),

                  // Tech Edge Section
                  const TechEdgeSection(),

                  // Skills Section
                  const SkillsSection(),

                  // Achievements Section
                  const AchievementsSection(),

                  // Current Focus
                  FocusSection(key: _focusKey),

                  // Interests
                  const InterestsSection(),

                  // References
                  const ReferencesSection(),

                  // CTA Section
                  CTASection(
                    key: _contactKey,
                    onDownloadCVPressed: _handleDownloadCV,
                    onGetStartedPressed: _handleGetStarted,
                  ),

                  // Footer
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===========================
  // BUTTON HANDLERS
  // ===========================

  /// Handle Explore My Work button
  void _handleExploreWork() {
    _scrollToKey(_experienceKey); // Experience is a good proxy for work
  }

  /// Handle Download CV button
  void _handleDownloadCV() async {
    // Increment download count
    context.read<StatsProvider>().incrementCvDownload();

    // TODO: Replace with actual CV file URL
    final cvUrl = 'https://example.com/sammy_cv.pdf';

    final uri = Uri.parse(cvUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('CV download link not configured yet'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  /// Handle Get Started button
  void _handleGetStarted() async {
    // Open email client
    final emailUri = Uri(
      scheme: 'mailto',
      path: AppConstants.email,
      query: 'subject=Project Inquiry&body=Hello Samay,\n\n',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      if (mounted) {
        // Fallback: Show contact info in dialog
        _showContactDialog();
      }
    }
  }

  /// Handle Contact button (Navigation)
  void _handleContactPressed() {
    _scrollToKey(_contactKey);
  }

  /// Handle Navigation Menu Items
  void _handleNavigation(String route) {
    // Map routes to actions
    switch (route) {
      case '/about':
        _scrollToKey(_aboutKey);
        break;
      case '/experience':
        _scrollToKey(_experienceKey);
        break;
      case '/education':
        _scrollToKey(_educationKey);
        break;
      case '/focus':
        _scrollToKey(_focusKey);
        break;
      case '/contact':
        _scrollToKey(_contactKey);
        break;
      default:
        debugPrint('Unknown route: $route');
    }
  }

  /// Scroll to specific section using GlobalKey
  void _scrollToKey(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.1, // Aligns to top with slight offset
      );
    } else {
      debugPrint('Context for key not found');
    }
  }

  /// Show contact information dialog
  void _showContactDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radius2xl),
        ),
        title: Text(
          'Contact Information',
          style: TextStyle(
            color: Theme.of(context).textTheme.titleLarge?.color,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactItem(Icons.email, 'Email', AppConstants.email),
            const SizedBox(height: 16),
            _buildContactItem(Icons.phone, 'Phone', AppConstants.phone),
            const SizedBox(height: 16),
            _buildContactItem(
              Icons.location_on,
              'Location',
              AppConstants.location,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppTheme.primary500),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 12, color: AppTheme.gray500),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================
  // FOOTER
  // ===========================

  Widget _buildFooter() {
    return Container(
      color: AppTheme.gray900,
      padding: const EdgeInsets.symmetric(
        vertical: AppTheme.space2xl,
        horizontal: AppTheme.spaceXl,
      ),
      child: Column(
        children: [
          // Social Links
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSocialButton(
                icon: FontAwesomeIcons.facebookF,
                url: AppConstants.facebook,
                label: 'Facebook',
                color: const Color(0xFF1877F2),
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                icon: FontAwesomeIcons.whatsapp,
                url: AppConstants.whatsApp,
                label: 'WhatsApp',
                color: const Color(0xFF25D366),
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                icon: FontAwesomeIcons.linkedinIn,
                url: AppConstants.linkedIn,
                label: 'LinkedIn',
                color: const Color(0xFF0A66C2),
              ),
              const SizedBox(width: 16),
              _buildSocialButton(
                icon: FontAwesomeIcons.google,
                url: 'mailto:${AppConstants.email}',
                label: 'Gmail',
                color: const Color(0xFFEA4335),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spaceLg),

          // Profile Visits
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: AppTheme.gray800,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.visibility_outlined,
                  size: 16,
                  color: AppTheme.gray400,
                ),
                const SizedBox(width: 8),
                Consumer<StatsProvider>(
                  builder: (context, stats, _) {
                    return Text(
                      "Profile Visits: ${(stats.profileVisitCount / 1000).toStringAsFixed(1)}k",
                      style: TextStyle(
                        fontSize: 14,
                        color: AppTheme.gray400,
                        fontWeight: FontWeight.w500,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: AppTheme.spaceMd),

          // Copyright
          Text(
            '© ${DateTime.now().year} ${AppConstants.fullName}. All rights reserved.',
            style: TextStyle(fontSize: 14, color: AppTheme.gray400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required String url,
    required String label,
    required Color color,
  }) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      borderRadius: BorderRadius.circular(AppTheme.radiusFull),
      child: Container(
        width: 44, // Fixed size for consistency
        height: 44,
        decoration: BoxDecoration(
          color: color, // Brand color background
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Center(child: FaIcon(icon, size: 20, color: Colors.white)),
      ),
    );
  }
}
