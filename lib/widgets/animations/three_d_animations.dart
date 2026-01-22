import 'dart:math' as math;
import 'dart:ui'; // Added for ImageFilter
import 'package:flutter/material.dart';
import '../../config/theme.dart';

/// Animated 3D Card with tilt effect on hover
class Animated3DCard extends StatefulWidget {
  final Widget child;
  final double width;
  final double? height;
  final BorderRadius? borderRadius;
  final List<BoxShadow>? shadows;
  final Color? backgroundColor;
  final double maxTilt;
  final bool enableTilt;

  const Animated3DCard({
    super.key,
    required this.child,
    required this.width,
    this.height,
    this.borderRadius,
    this.shadows,
    this.backgroundColor,
    this.maxTilt = 10,
    this.enableTilt = true,
  });

  @override
  State<Animated3DCard> createState() => _Animated3DCardState();
}

class _Animated3DCardState extends State<Animated3DCard>
    with SingleTickerProviderStateMixin {
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  bool _isHovered = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handlePointerMove(PointerEvent event, Size size) {
    if (!widget.enableTilt) return;

    final x = event.localPosition.dx;
    final y = event.localPosition.dy;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    final percentX = (x - centerX) / centerX;
    final percentY = (y - centerY) / centerY;

    setState(() {
      _rotateY = percentX * widget.maxTilt;
      _rotateX = -percentY * widget.maxTilt;
    });
  }

  void _handlePointerExit(PointerEvent event) {
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
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
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001) // perspective
            ..rotateX(_rotateX * math.pi / 180)
            ..rotateY(_rotateY * math.pi / 180)
            ..setTranslationRaw(0.0, _isHovered ? -4.0 : 0.0, 0.0),
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: widget.backgroundColor ?? Colors.white,
              borderRadius:
                  widget.borderRadius ??
                  BorderRadius.circular(AppTheme.radius2xl),
              boxShadow: _isHovered
                  ? (widget.shadows ?? AppTheme.shadowLg)
                  : (widget.shadows ?? AppTheme.shadowMd),
              border: Border.all(color: AppTheme.gray200, width: 1),
            ),
            child: ClipRRect(
              borderRadius:
                  widget.borderRadius ??
                  BorderRadius.circular(AppTheme.radius2xl),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}

/// Floating Animation Widget
/// Creates a gentle up/down floating effect
class FloatingAnimation extends StatefulWidget {
  final Widget child;
  final double range;
  final Duration duration;
  final Curve curve;

  const FloatingAnimation({
    super.key,
    required this.child,
    this.range = 10.0,
    this.duration = const Duration(seconds: 3),
    this.curve = Curves.easeInOut,
  });

  @override
  State<FloatingAnimation> createState() => _FloatingAnimationState();
}

class _FloatingAnimationState extends State<FloatingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -widget.range / 2,
      end: widget.range / 2,
    ).animate(CurvedAnimation(parent: _controller, curve: widget.curve));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Rotating 3D Element
/// Continuous rotation animation
class Rotating3D extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Axis axis;

  const Rotating3D({
    super.key,
    required this.child,
    this.duration = const Duration(seconds: 20),
    this.axis = Axis.vertical,
  });

  @override
  State<Rotating3D> createState() => _Rotating3DState();
}

class _Rotating3DState extends State<Rotating3D>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final angle = _controller.value * 2 * math.pi;
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001); // perspective

        if (widget.axis == Axis.vertical) {
          transform.rotateY(angle);
        } else {
          transform.rotateX(angle);
        }

        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Parallax Layer
/// Creates depth through scroll-based parallax effect
class ParallaxLayer extends StatelessWidget {
  final Widget child;
  final double speed;
  final ScrollController? scrollController;

  const ParallaxLayer({
    super.key,
    required this.child,
    this.speed = 0.5,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (scrollController == null) {
      return child;
    }

    return AnimatedBuilder(
      animation: scrollController!,
      builder: (context, child) {
        final offset = scrollController!.offset * speed;
        return Transform.translate(offset: Offset(0, -offset), child: child);
      },
      child: child,
    );
  }
}

/// Glass Container with Glassmorphism Effect
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final Color? backgroundColor;
  final double blur;
  final Border? border;

  const GlassContainer({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.backgroundColor,
    this.blur = 20.0,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white.withValues(alpha: 0.7),
        borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.radius2xl),
        border:
            border ??
            Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1),
        boxShadow: AppTheme.shadowMd,
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(AppTheme.radius2xl),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppTheme.spaceLg),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Shimmer Loading Effect
class ShimmerLoading extends StatefulWidget {
  final Widget child;
  final Color baseColor;
  final Color highlightColor;
  final Duration duration;

  const ShimmerLoading({
    super.key,
    required this.child,
    this.baseColor = const Color(0xFFE0E0E0),
    this.highlightColor = const Color(0xFFF5F5F5),
    this.duration = const Duration(milliseconds: 1500),
  });

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: widget.duration, vsync: this)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: [
                _controller.value - 0.3,
                _controller.value,
                _controller.value + 0.3,
              ].map((e) => e.clamp(0.0, 1.0)).toList(),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
