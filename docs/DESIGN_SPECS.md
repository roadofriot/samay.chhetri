# 🎨 Design Specifications

> Complete visual design guide for the Personal Branding Website

---

## 📐 Layout & Grid System

### Breakpoints
```dart
// Responsive breakpoints
mobile: 0 - 767px
tablet: 768px - 1023px
desktop: 1024px - 1439px
wide: 1440px+

// Container max-widths
mobile: 100% (with 16px padding)
tablet: 720px
desktop: 960px
wide: 1200px
```

### Grid Columns
- **Mobile**: 4 columns
- **Tablet**: 8 columns
- **Desktop**: 12 columns

### Spacing Scale
```dart
xs: 4px
sm: 8px
md: 16px
lg: 24px
xl: 32px
2xl: 48px
3xl: 64px
4xl: 96px
```

---

## 🎨 Color System

### Daylight Theme Palette

#### Primary Colors
```dart
// Brand Colors
primary_50: #EEF2FF   // Lightest
primary_100: #E0E7FF
primary_200: #C7D2FE
primary_300: #A5B4FC
primary_400: #818CF8
primary_500: #6366F1   // Main Primary
primary_600: #4F46E5
primary_700: #4338CA
primary_800: #3730A3
primary_900: #312E81   // Darkest

// Secondary Colors (Purple)
secondary_50: #FAF5FF
secondary_100: #F3E8FF
secondary_200: #E9D5FF
secondary_300: #D8B4FE
secondary_400: #C084FC
secondary_500: #A855F7  // Main Secondary
secondary_600: #9333EA
secondary_700: #7E22CE
secondary_800: #6B21A8
secondary_900: #581C87

// Accent Colors (Pink)
accent_50: #FDF2F8
accent_100: #FCE7F3
accent_200: #FBCFE8
accent_300: #F9A8D4
accent_400: #F472B6
accent_500: #EC4899    // Main Accent
accent_600: #DB2777
accent_700: #BE185D
accent_800: #9D174D
accent_900: #831843
```

#### Neutral Colors
```dart
// Grayscale
gray_50: #FAFAFA      // Background
gray_100: #F5F5F5     // Surface Light
gray_200: #E5E5E5     // Border Light
gray_300: #D4D4D4
gray_400: #A3A3A3
gray_500: #737373     // Text Muted
gray_600: #525252
gray_700: #404040
gray_800: #262626
gray_900: #171717     // Text Primary
```

#### Semantic Colors
```dart
// Success
success_light: #D1FAE5
success: #10B981
success_dark: #059669

// Warning
warning_light: #FEF3C7
warning: #F59E0B
warning_dark: #D97706

// Error
error_light: #FEE2E2
error: #EF4444
error_dark: #DC2626

// Info
info_light: #DBEAFE
info: #3B82F6
info_dark: #2563EB
```

### Color Usage Guidelines

| Element | Color | Usage |
|---------|-------|-------|
| **Background** | `gray_50` | Main page background |
| **Surface** | `white` | Cards, modals, containers |
| **Primary Text** | `gray_900` | Headlines, body text |
| **Secondary Text** | `gray_600` | Supporting text, captions |
| **Interactive** | `primary_500` | Buttons, links, active states |
| **Borders** | `gray_200` | Card outlines, dividers |
| **Shadows** | `rgba(0,0,0,0.1)` | Subtle depth |

---

## 📝 Typography

### Font Families
```dart
// Headings
headingFont: 'Outfit', sans-serif
// Body
bodyFont: 'Inter', sans-serif
// Monospace (code)
monoFont: 'JetBrains Mono', monospace
```

### Type Scale

#### Desktop
```dart
// Headings
h1: 72px / 1.1 / 700 (Outfit)    // Hero headline
h2: 48px / 1.2 / 700 (Outfit)    // Section titles
h3: 36px / 1.3 / 600 (Outfit)    // Subsection titles
h4: 24px / 1.4 / 600 (Outfit)    // Card titles
h5: 20px / 1.5 / 600 (Outfit)    // Small titles
h6: 16px / 1.5 / 600 (Outfit)    // Overlines

// Body
body_xl: 20px / 1.7 / 400 (Inter)  // Large paragraphs
body_lg: 18px / 1.7 / 400 (Inter)  // Default body
body_md: 16px / 1.6 / 400 (Inter)  // Small body
body_sm: 14px / 1.5 / 400 (Inter)  // Captions

// Special
button: 16px / 1.5 / 600 (Inter)   // Button text
label: 14px / 1.4 / 500 (Inter)    // Form labels
caption: 12px / 1.4 / 400 (Inter)  // Metadata
```

#### Mobile
```dart
h1: 48px / 1.2 / 700
h2: 36px / 1.3 / 700
h3: 28px / 1.4 / 600
h4: 20px / 1.5 / 600
h5: 18px / 1.5 / 600
body_lg: 16px / 1.7 / 400
body_md: 14px / 1.6 / 400
```

### Font Loading Strategy
```html
<!-- Preconnect for faster font loading -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

<!-- Critical fonts (loaded immediately) -->
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@600;700;800&display=swap" rel="stylesheet">
```

---

## 🔘 Component Specifications

### Buttons

#### Primary Button
```dart
background: Linear Gradient (primary_500 → primary_600)
text: white
padding: 12px 32px (mobile) | 16px 40px (desktop)
borderRadius: 12px
fontSize: 16px
fontWeight: 600
shadow: 0 4px 12px rgba(99, 102, 241, 0.25)

// Hover State
background: Linear Gradient (primary_600 → primary_700)
shadow: 0 6px 16px rgba(99, 102, 241, 0.35)
transform: translateY(-2px)

// Active State
background: primary_700
shadow: 0 2px 8px rgba(99, 102, 241, 0.3)
transform: translateY(0)
```

#### Secondary Button
```dart
background: transparent
text: primary_600
padding: 12px 32px
borderRadius: 12px
border: 2px solid primary_500
fontSize: 16px
fontWeight: 600

// Hover State
background: primary_50
border: 2px solid primary_600
```

#### Ghost Button
```dart
background: transparent
text: gray_700
padding: 12px 24px
borderRadius: 8px
fontSize: 14px
fontWeight: 500

// Hover State
background: gray_100
text: gray_900
```

### Cards

#### Stat Card
```dart
background: white
padding: 32px
borderRadius: 24px
border: 1px solid gray_200
shadow: 0 1px 3px rgba(0, 0, 0, 0.05)

// Hover State
shadow: 0 8px 24px rgba(0, 0, 0, 0.12)
transform: translateY(-4px)
border: 1px solid primary_200

// Contents
icon: 48px (primary_500)
value: h2 (primary_600)
label: body_sm (gray_600)
```

#### Project Card
```dart
background: white
borderRadius: 20px
overflow: hidden
shadow: 0 2px 8px rgba(0, 0, 0, 0.08)

// Image Container
aspectRatio: 16:9
objectFit: cover
overlay: Linear Gradient (transparent → rgba(0,0,0,0.4)) on hover

// Content Area
padding: 24px
title: h4 (gray_900)
description: body_md (gray_600)
tags: body_sm (primary_600 on primary_50 background)
```

#### Glass Container (Glassmorphism)
```dart
background: rgba(255, 255, 255, 0.7)
backdropFilter: blur(20px) saturate(180%)
border: 1px solid rgba(255, 255, 255, 0.3)
borderRadius: 24px
padding: 48px
shadow: 0 8px 32px rgba(0, 0, 0, 0.08)
```

### Forms

#### Input Field
```dart
background: white
padding: 14px 20px
borderRadius: 12px
border: 2px solid gray_200
fontSize: 16px
color: gray_900

// Focus State
border: 2px solid primary_500
shadow: 0 0 0 4px rgba(99, 102, 241, 0.1)

// Error State
border: 2px solid error
shadow: 0 0 0 4px rgba(239, 68, 68, 0.1)
```

#### Label
```dart
fontSize: 14px
fontWeight: 500
color: gray_700
marginBottom: 8px
```

---

## 🎭 Animations & Motion

### Timing Functions
```dart
// Easing
easeInOut: cubic-bezier(0.4, 0, 0.2, 1)
easeOut: cubic-bezier(0.0, 0, 0.2, 1)
easeIn: cubic-bezier(0.4, 0, 1, 1)
spring: cubic-bezier(0.175, 0.885, 0.32, 1.275)

// Durations
instant: 100ms
fast: 200ms
normal: 300ms
slow: 500ms
slower: 700ms
```

### Animation Types

#### Fade In
```dart
duration: 500ms
from: opacity 0
to: opacity 1
easing: easeOut
```

#### Slide Up
```dart
duration: 600ms
from: translateY(40px), opacity 0
to: translateY(0), opacity 1
easing: easeOut
```

#### Scale In
```dart
duration: 400ms
from: scale(0.95), opacity 0
to: scale(1), opacity 1
easing: spring
```

#### Hover Lift
```dart
duration: 200ms
from: translateY(0)
to: translateY(-4px)
easing: easeOut
```

#### 3D Rotation (continuous)
```dart
duration: 20s
from: rotateY(0deg)
to: rotateY(360deg)
easing: linear
iteration: infinite
```

#### Floating Effect
```dart
duration: 3s
from: translateY(0)
to: translateY(-10px)
easing: easeInOut
iteration: infinite
alternate: true
```

### Scroll-based Animations

#### Parallax Layers
```dart
// Background layer
scrollSpeed: 0.5x (moves slower)

// Midground layer
scrollSpeed: 1.0x (normal scroll)

// Foreground layer
scrollSpeed: 1.5x (moves faster)
```

#### Trigger Points
```dart
// Viewport entry
trigger: element enters bottom 20% of viewport
animation: fadeIn + slideUp
stagger: 100ms between items

// Viewport center
trigger: element reaches center of viewport
animation: scaleIn
```

---

## 🖼️ Imagery

### Profile Image
```dart
// Desktop
size: 400px × 500px
borderRadius: 24px
objectFit: cover
shadow: 0 20px 60px rgba(0, 0, 0, 0.15)

// Mobile
size: 280px × 350px
borderRadius: 16px
```

### Project Thumbnails
```dart
aspectRatio: 16:9
minWidth: 320px
maxWidth: 480px
borderRadius: 16px
objectFit: cover
```

### Icons
```dart
// Size scale
xs: 16px
sm: 20px
md: 24px
lg: 32px
xl: 48px
2xl: 64px

// Style
strokeWidth: 2px
color: primary_500 (interactive) | gray_600 (static)
```

---

## 📱 Responsive Behavior

### Hero Section

#### Desktop (> 1024px)
```dart
layout: Two-column (60% text / 40% image)
headline: 72px
spacing: 64px between elements
image: 400px width, floating right
```

#### Tablet (768px - 1023px)
```dart
layout: Two-column (50% / 50%)
headline: 48px
spacing: 48px
image: 320px width
```

#### Mobile (< 768px)
```dart
layout: Single column, stacked
headline: 36px
spacing: 32px
image: Full width, centered
order: Image → Headline → Description → CTAs
```

### Stats Section

#### Desktop
```dart
layout: 4-column grid
gap: 24px
cardHeight: auto
```

#### Tablet
```dart
layout: 2-column grid
gap: 16px
```

#### Mobile
```dart
layout: 1-column stack
gap: 16px
```

### Navigation

#### Desktop
```dart
type: Horizontal menu
position: Fixed top
links: Visible (About | Experience | Portfolio | Services | Contact)
logo: Left aligned
CTA: Right aligned
```

#### Mobile
```dart
type: Hamburger menu
position: Fixed top
menu: Slide-in from right
links: Stacked vertically
fullScreen: true
```

---

## ♿ Accessibility

### Color Contrast
- Text on white: Minimum 4.5:1 ratio
- Large text (24px+): Minimum 3:1 ratio
- Interactive elements: Minimum 3:1 ratio

### Focus States
```dart
outline: 3px solid primary_500
outlineOffset: 2px
borderRadius: inherit
```

### ARIA Labels
- All interactive elements have `aria-label`
- Images have descriptive `alt` text
- Sections have `aria-labelledby` referencing headers

### Keyboard Navigation
- Tab order follows visual hierarchy
- Skip to main content link
- All interactions accessible via keyboard
- Escape key closes modals/menus

---

## 🌐 Browser Support

### Supported Browsers
- Chrome 90+ ✅
- Firefox 88+ ✅
- Safari 14+ ✅
- Edge 90+ ✅

### Fallbacks
- 3D graphics: Graceful degradation to 2D on WebGL unsupported devices
- Animations: Respect `prefers-reduced-motion` user preference
- Fonts: System font stack as fallback

---

## 📊 Performance Guidelines

### Image Optimization
```dart
// Desktop
format: WebP (with JPEG fallback)
maxWidth: 1920px
quality: 85%

// Mobile
format: WebP
maxWidth: 768px
quality: 80%

// Lazy loading
strategy: Intersection Observer
threshold: 50px from viewport
```

### Animation Performance
- Use `transform` and `opacity` only (GPU accelerated)
- Avoid animating `width`, `height`, `top`, `left`
- Debounce scroll event listeners
- Use `requestAnimationFrame` for smooth rendering

### Asset Loading
```dart
critical: Inline in HTML
aboveTheFold: Preload
belowTheFold: Lazy load
fonts: Font-display: swap
```

---

## 🎯 Design Principles

1. **Clarity First**: Information hierarchy is obvious
2. **Consistent Spacing**: Rhythm through grid system
3. **Generous Whitespace**: Let content breathe
4. **Purposeful Animation**: Enhance, don't distract
5. **Accessible by Default**: WCAG 2.1 AA compliance
6. **Mobile-First**: Design for smallest screen, enhance upward
7. **Fast & Lightweight**: Performance is a feature

---

*Last Updated: January 2025*
