# 🎭 3D Animation & Effects Guide

> Complete guide to the 3D animations and visual effects in the Personal Branding Website

---

## 📋 Table of Contents

- [Overview](#overview)
- [3D Animation Components](#3d-animation-components)
- [Usage Examples](#usage-examples)
- [Customization](#customization)
- [Performance Tips](#performance-tips)
- [Troubleshooting](#troubleshooting)

---

## Overview

This project includes several custom 3D animation widgets that create premium, interactive experiences:

1. **Animated3DCard** - Tilt effect that follows mouse movement
2. **FloatingAnimation** - Gentle up/down floating motion
3. **Rotating3D** - Continuous rotation effect
4. **MagneticButton** - Cursor attraction effect
5. **GlassContainer** - Glassmorphism UI element
6. **ParallaxLayer** - Scroll-based depth effects

---

## 3D Animation Components

### 1. Animated3DCard

**Purpose**: Creates an interactive card that tilts based on mouse position

**Features**:
- 3D perspective transform
- Mouse-following tilt effect
- Hover lift animation
- Customizable tilt intensity

**Location**: `lib/widgets/animations/3d_animations.dart`

**Properties**:
```dart
Animated3DCard(
  child: Widget,                    // Content to display
  width: double,                     // Card width
  height: double,                    // Card height
  borderRadius: BorderRadius?,       // Corner radius
  shadows: List<BoxShadow>?,        // Shadow effects
  backgroundColor: Color?,           // Background color
  maxTilt: double,                   // Max tilt angle (default: 10°)
  enableTilt: bool,                  // Enable/disable tilt (default: true)
)
```

**How it Works**:
1. Tracks mouse position relative to card center
2. Calculates tilt angles (rotateX, rotateY)
3. Applies Matrix4 transform for 3D perspective
4. Animates smoothly with 200ms duration

**Example**:
```dart
Animated3DCard(
  width: 300,
  height: 200,
  maxTilt: 15, // More dramatic tilt
  child: Container(
    padding: EdgeInsets.all(24),
    child: Text('Hover over me!'),
  ),
)
```

---

### 2. FloatingAnimation

**Purpose**: Creates gentle up-and-down floating motion

**Features**:
- Continuous animation loop
- Customizable range and duration
- Smooth easing curves

**Properties**:
```dart
FloatingAnimation(
  child: Widget,                     // Widget to animate
  range: double,                     // Float distance (default: 10px)
  duration: Duration,                // Animation duration (default: 3s)
  curve: Curve,                      // Easing curve (default: easeInOut)
)
```

**Example**:
```dart
FloatingAnimation(
  range: 20,  // Float up/down 20px
  duration: Duration(seconds: 4),
  child: Image.asset('assets/profile.png'),
)
```

---

### 3. Rotating3D

**Purpose**: Continuous 3D rotation animation

**Features**:
- Rotates on X or Y axis
- Infinite loop
- Smooth rotation

**Properties**:
```dart
Rotating3D(
  child: Widget,                     // Widget to rotate
  duration: Duration,                // Rotation speed (default: 20s)
  axis: Axis,                        // Rotation axis (vertical/horizontal)
)
```

**Example**:
```dart
Rotating3D(
  duration: Duration(seconds: 10),
  axis: Axis.vertical,  // Rotates around Y-axis
  child: Container(
    width: 100,
    height: 100,
    color: Colors.blue,
  ),
)
```

---

### 4. MagneticButton

**Purpose**: Button that "pulls" toward cursor on hover

**Features**:
- Cursor attraction effect
- Smooth magnetic motion
- Customizable strength

**Properties**:
```dart
MagneticButton(
  child: Widget,                     // Button content
  onPressed: VoidCallback,           // Tap handler
  magneticStrength: double,          // Pull strength (default: 0.3)
)
```

**How it Works**:
1. Mouse position tracked relative to button center
2. Offset calculated: `delta * magneticStrength`
3. Button translates toward cursor
4. Returns to center when mouse exits

**Example**:
```dart
MagneticButton(
  magneticStrength: 0.5,  // Stronger pull
  onPressed: () => print('Clicked!'),
  child: CustomButton(
    text: 'Magnetic!',
    type: ButtonType.primary,
  ),
)
```

---

### 5. GlassContainer

**Purpose**: Modern glassmorphism effect

**Features**:
- Frosted glass appearance
- Blur and transparency
- Border glow effect

**Properties**:
```dart
GlassContainer(
  child: Widget,                     // Content
  width: double?,                    // Optional width
  height: double?,                   // Optional height
  padding: EdgeInsetsGeometry?,      // Inner padding
  margin: EdgeInsetsGeometry?,       // Outer margin
  borderRadius: BorderRadius?,       // Corner radius
  backgroundColor: Color?,           // Tint color
  blur: double,                      // Blur amount (default: 20)
  border: Border?,                   // Border style
)
```

**Example**:
```dart
GlassContainer(
  padding: EdgeInsets.all(32),
  backgroundColor: Colors.white.withOpacity(0.7),
  blur: 30,
  child: Column(
    children: [
      Text('Glassmorphism'),
      Text('Modern UI Effect'),
    ],
  ),
)
```

---

### 6. ParallaxLayer

**Purpose**: Different scroll speeds for depth perception

**Features**:
- Scroll-based animation
- Variable speed multiplier
- Creates depth illusion

**Properties**:
```dart
ParallaxLayer(
  child: Widget,                     // Layer content
  speed: double,                     // Scroll speed multiplier
  scrollController: ScrollController?, // Scroll controller
)
```

**Speed Guide**:
- `speed < 1.0`: Slower than normal scroll (background)
- `speed = 1.0`: Normal scroll speed
- `speed > 1.0`: Faster than normal scroll (foreground)

**Example**:
```dart
// Background layer (slower)
ParallaxLayer(
  speed: 0.5,  // Moves at half scroll speed
  scrollController: _scrollController,
  child: Image.asset('background.png'),
)

// Foreground layer (faster)
ParallaxLayer(
  speed: 1.5,  // Moves 1.5x scroll speed
  scrollController: _scrollController,
  child: Icon(Icons.star, size: 100),
)
```

---

## Usage Examples

### Example 1: Animated Stats Card
```dart
Animated3DCard(
  width: double.infinity,
  height: 180,
  child: Padding(
    padding: EdgeInsets.all(32),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.star, size: 48, color: Colors.blue),
        SizedBox(height: 16),
        Text('5+', style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
        Text('Years Experience'),
      ],
    ),
  ),
)
```

### Example 2: Floating Profile Image
```dart
FloatingAnimation(
  range: 15,
  duration: Duration(seconds: 4),
  child: Animated3DCard(
    width: 400,
    height: 500,
    child: Image.asset('profile.jpg', fit: BoxFit.cover),
  ),
)
```

### Example 3: Glass CTA Section
```dart
GlassContainer(
  padding: EdgeInsets.all(48),
  backgroundColor: Colors.white.withOpacity(0.8),
  blur: 25,
  child: Column(
    children: [
      Text('Ready to collaborate?', style: TextStyle(fontSize: 32)),
      SizedBox(height: 24),
      MagneticButton(
        onPressed: () => print('Contact clicked'),
        child: CustomButton(text: 'Get in Touch'),
      ),
    ],
  ),
)
```

### Example 4: Parallax Hero Section
```dart
SingleChildScrollView(
  controller: _scrollController,
  child: Stack(
    children: [
      // Background (slow)
      ParallaxLayer(
        speed: 0.3,
        scrollController: _scrollController,
        child: Container(
          height: 800,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [blue, purple]),
          ),
        ),
      ),
      
      // Content (normal speed)
      ParallaxLayer(
        speed: 1.0,
        scrollController: _scrollController,
        child: HeroContent(),
      ),
      
      // Floating elements (fast)
      ParallaxLayer(
        speed: 1.5,
        scrollController: _scrollController,
        child: FloatingIcons(),
      ),
    ],
  ),
)
```

---

## Customization

### Adjusting Animation Speeds

Edit `lib/config/constants.dart`:
```dart
// Animation durations (ms)
static const int durationFast = 200;      // Quick animations
static const int durationNormal = 300;    // Standard animations
static const int durationSlow = 500;      // Slow animations
static const int durationSlower = 700;    // Very slow animations
```

### Changing 3D Tilt Sensitivity

In `Animated3DCard` widget:
```dart
// Less sensitive (subtle tilt)
maxTilt: 5

// Default
maxTilt: 10

// More dramatic
maxTilt: 20
```

### Adjusting Floating Range

In `FloatingAnimation`:
```dart
// Subtle float
range: 5

// Default
range: 10

// Dramatic float
range: 20
```

---

## Performance Tips

### 1. **Limit Simultaneous Animations**
- Don't animate too many elements at once
- Use `VisibilityDetector` to animate only visible widgets

### 2. **Use Transform Instead of Layout Properties**
- ✅ **Good**: `Transform.translate`, `Transform.rotate`, `Transform.scale`
- ❌ **Bad**: Animating `width`, `height`, `top`, `left`

### 3. **Optimize for Web**
```dart
// Check if on web, reduce animation complexity
if (kIsWeb) {
  maxTilt = 5;  // Less tilt on web
}
```

### 4. **Respect User Preferences**
```dart
// Disable animations if user prefers reduced motion
final mediaQuery = MediaQuery.of(context);
final reduceMotion = mediaQuery.disableAnimations;

if (!reduceMotion) {
  return FloatingAnimation(child: widget);
}
return widget;  // No animation
```

### 5. **Debounce Mouse Events**
For better performance with `Animated3DCard`:
```dart
Timer? _debounce;

void _handlePointerMove(PointerEvent event, Size size) {
  if (_debounce?.isActive ?? false) _debounce!.cancel();
  _debounce = Timer(Duration(milliseconds: 10), () {
    // Update tilt
  });
}
```

---

## Troubleshooting

### Animation Not Working
**Issue**: Widget doesn't animate
**Solutions**:
1. Check if `AnimationController` is initialized
2. Verify `vsync` is implemented (`SingleTickerProviderStateMixin`)
3. Ensure `dispose()` is called to clean up

### Choppy Animations
**Issue**: Animations stutter or lag
**Solutions**:
1. Reduce number of simultaneous animations
2. Use `RepaintBoundary` to isolate animated widgets
3. Check device/browser performance
4. Reduce `maxTilt` or `range` values

### Mouse Events Not Triggering
**Issue**: 3D tilt not working on hover
**Solutions**:
1. Ensure `MouseRegion` is wrapping the widget
2. Check if widget has a valid size (not zero)
3. Verify `Listener` is receiving events

### Excessive Renders
**Issue**: App rebuilding too often
**Solutions**:
1. Wrap animations in `RepaintBoundary`
2. Use `const` widgets where possible
3. Implement `shouldRebuild` in custom widgets

---

## Best Practices

### 1. **Composition Over Custom Painting**
Use built-in widgets and transforms instead of custom painters for better performance.

### 2. **Layer Animations**
Combine multiple simple animations for complex effects:
```dart
FloatingAnimation(
  child: Rotating3D(
    child: Animated3DCard(
      child: YourContent(),
    ),
  ),
)
```

### 3. **Graceful Degradation**
Always have a fallback for devices that don't support animations:
```dart
Widget buildAnimated() {
  try {
    return Animated3DCard(...);
  } catch (e) {
    return SimplerCard(...);
  }
}
```

### 4. **Test on Multiple Devices**
- Desktop browsers (Chrome, Firefox, Safari)
- Mobile browsers (iOS Safari, Chrome Mobile)
- Different screen sizes

---

## Animation Code Reference

All animation widgets are in:
```
lib/widgets/animations/3d_animations.dart
```

Key files using animations:
- `lib/widgets/sections/hero_section.dart` - FloatingAnimation + Animated3DCard
- `lib/widgets/cards/cards.dart` - StatCard with Animated3DCard
- `lib/widgets/common/custom_button.dart` - MagneticButton

---

## Further Reading

- **Flutter Animations**: https://docs.flutter.dev/development/ui/animations
- **Transform Matrix4**: https://api.flutter.dev/flutter/vector_math_64/Matrix4-class.html
- **Performance Best Practices**: https://docs.flutter.dev/perf/best-practices

---

*Last Updated: January 21, 2025*
