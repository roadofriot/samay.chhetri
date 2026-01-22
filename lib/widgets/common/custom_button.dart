import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme.dart';

/// Custom Button with multiple styles
/// - Primary: Filled button with gradient
/// - Secondary: Outlined button
/// - Ghost: Transparent button
enum ButtonType { primary, secondary, ghost }

class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final EdgeInsetsGeometry? padding;
  final Color? foregroundColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = false,
    this.padding,
    this.foregroundColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onPressed();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.translationValues(0, _isHovered ? -2 : 0, 0),
          child: ScaleTransition(scale: _scaleAnimation, child: _buildButton()),
        ),
      ),
    );
  }

  Widget _buildButton() {
    switch (widget.type) {
      case ButtonType.primary:
        return _buildPrimaryButton();
      case ButtonType.secondary:
        return _buildSecondaryButton();
      case ButtonType.ghost:
        return _buildGhostButton();
    }
  }

  Widget _buildPrimaryButton() {
    return Container(
      width: widget.isFullWidth ? double.infinity : null,
      padding:
          widget.padding ??
          const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: _isHovered
            ? AppTheme.shadowPrimaryLg
            : AppTheme.shadowPrimary,
      ),
      child: _buildButtonContent(widget.foregroundColor ?? Colors.white),
    );
  }

  Widget _buildSecondaryButton() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Default colors based on theme if no override provided
    final defaultColor = isDark ? AppTheme.primary300 : AppTheme.primary600;
    final color = widget.foregroundColor ?? defaultColor;

    // Calculate hover background color
    final hoverBgColor = widget.foregroundColor != null
        ? widget.foregroundColor!.withValues(alpha: 0.1)
        : (isDark
              ? AppTheme.primary500.withValues(alpha: 0.2)
              : AppTheme.primary50);

    return Container(
      width: widget.isFullWidth ? double.infinity : null,
      padding:
          widget.padding ??
          const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      decoration: BoxDecoration(
        color: _isHovered ? hoverBgColor : Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        border: Border.all(
          color: _isHovered ? color.withValues(alpha: 0.8) : color,
          width: 2,
        ),
      ),
      child: _buildButtonContent(color),
    );
  }

  Widget _buildGhostButton() {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Default text colors
    final defaultTextColor = isDark ? AppTheme.gray300 : AppTheme.gray700;
    final hoverTextColor = isDark ? Colors.white : AppTheme.gray900;

    final textColor =
        widget.foregroundColor ??
        (_isHovered ? hoverTextColor : defaultTextColor);

    // Hover background
    final hoverBg = isDark ? AppTheme.gray800 : AppTheme.gray100;

    return Container(
      width: widget.isFullWidth ? double.infinity : null,
      padding:
          widget.padding ??
          const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: _isHovered ? hoverBg : Colors.transparent,
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
      ),
      child: _buildButtonContent(textColor),
    );
  }

  Widget _buildButtonContent(Color textColor) {
    if (widget.isLoading) {
      return SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(textColor),
        ),
      );
    }

    final content = <Widget>[];

    if (widget.icon != null) {
      content.add(Icon(widget.icon, size: 20, color: textColor));
      content.add(const SizedBox(width: 8));
    }

    content.add(
      Text(
        widget.text,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: content,
    );
  }
}

/// Magnetic Button with cursor attraction effect
class MagneticButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double magneticStrength;

  const MagneticButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.magneticStrength = 0.3,
  });

  @override
  State<MagneticButton> createState() => _MagneticButtonState();
}

class _MagneticButtonState extends State<MagneticButton> {
  Offset _offset = Offset.zero;
  bool _isHovered = false;

  void _handlePointerMove(PointerEvent event, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final delta = event.localPosition - center;

    setState(() {
      _offset = delta * widget.magneticStrength;
    });
  }

  void _handlePointerExit(PointerEvent event) {
    setState(() {
      _offset = Offset.zero;
      _isHovered = false;
    });
  }

  void _handlePointerEnter(PointerEvent event) {
    setState(() {
      _isHovered = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: _handlePointerEnter,
      onExit: _handlePointerExit,
      child: Listener(
        onPointerMove: (event) {
          final renderBox = context.findRenderObject() as RenderBox?;
          if (renderBox != null) {
            _handlePointerMove(event, renderBox.size);
          }
        },
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            transform: Matrix4.translationValues(
              _offset.dx,
              _offset.dy + (_isHovered ? -2 : 0),
              0,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
