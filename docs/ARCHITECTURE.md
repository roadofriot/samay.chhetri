# 🏗️ Architecture Document

> System architecture and code organization for the Personal Branding Website

---

## Table of Contents

- [Overview](#overview)
- [Architecture Pattern](#architecture-pattern)
- [Project Structure](#project-structure)
- [Data Flow](#data-flow)
- [Component Hierarchy](#component-hierarchy)
- [State Management](#state-management)
- [Routing Strategy](#routing-strategy)
- [Design Decisions](#design-decisions)

---

## Overview

This is a **Flutter Web** application built with a **component-based architecture** focusing on:

- **Separation of Concerns**: Config, UI, Logic separated
- **Reusability**: Modular, composable widgets
- **Responsive Design**: Mobile-first approach
- **Performance**: Optimized animations and rendering
- **Maintainability**: Clear folder structure and naming

---

## Architecture Pattern

### Pattern: **Component-Based Architecture with Utility-First Theming**

```
┌─────────────────────────────────────────┐
│            main.dart                     │
│         (Entry Point)                    │
└────────────────┬────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────┐
│            app.dart                      │
│      (Root MaterialApp)                  │
│    - Theme Configuration                 │
│    - Routing Setup                       │
└────────────────┬────────────────────────┘
                 │
                 ▼
┌─────────────────────────────────────────┐
│         HomeScreen                       │
│      (Main Page Layout)                  │
│  - Navigation Bar                        │
│  - Scrollable Sections                   │
│  - Footer                                │
└────────────────┬────────────────────────┘
                 │
        ┌────────┴────────┐
        ▼                 ▼
   ┌─────────┐       ┌─────────┐
   │ Sections │       │ Widgets │
   │ - Hero   │       │ - Cards │
   │ - Stats  │       │ - Buttons│
   │ - CTA    │       │ - Anims │
   └─────────┘       └─────────┘
```

### Key Principles

1. **Single Responsibility**: Each widget has one clear purpose
2. **Composition**: Build complex UIs from simple widgets
3. **Configurability**: Use constants for easy customization
4. **Type Safety**: Strong typing with Dart
5. **Declarative UI**: Flutter's reactive paradigm

---

## Project Structure

### Directory Organization

```
lib/
├── config/              # Configuration & Constants
│   ├── theme.dart       # App theme, colors, typography
│   └── constants.dart   # Static data, breakpoints, durations
│
├── screens/             # Full-page views
│   └── home_screen.dart # Main landing page
│
├── widgets/             # Reusable UI components
│   ├── navigation/      # Nav bar, menus
│   ├── sections/        # Page sections (Hero, Stats, etc.)
│   ├── cards/           # Card components
│   ├── animations/      # 3D effects, animations
│   └── common/          # Shared components (buttons, etc.)
│
├── utils/               # Helper functions & utilities
│   └── responsive.dart  # Responsive breakpoint helpers
│
└── main.dart            # App entry point
    app.dart             # Root app widget
```

### Design Philosophy

| Layer | Purpose | Examples |
|-------|---------|----------|
| **Config** | Static configuration | Theme, constants, routes |
| **Screens** | Page-level views | HomeScreen, AboutScreen |
| **Sections** | Major page sections | HeroSection, StatsSection |
| **Widgets** | Reusable components | CustomButton, StatCard |
| **Utils** | Helper functions | Responsive, validators |

---

## Data Flow

### Unidirectional Data Flow (Simplified)

```
Constants (config/constants.dart)
    │
    ▼
HomeScreen (builds UI with data)
    │
    ├─▶ HeroSection (displays personal info)
    │       │
    │       └─▶ CustomButton (user interaction)
    │               │
    │               └─▶ onPressed() → HomeScreen method
    │                       │
    │                       └─▶ External action (email, scroll, etc.)
    │
    ├─▶ StatsSection (displays metrics)
    │       └─▶ StatCard (individual stat)
    │
    └─▶ CTASection (call-to-action)
            └─▶ Buttons → HomeScreen callbacks
```

### Data Sources

1. **Static Data**: `lib/config/constants.dart`
   - Personal information
   - Stats, skills, navigation items
   - URLs, labels

2. **Theme Data**: `lib/config/theme.dart`
   - Colors, typography
   - Spacing, shadows
   - Component styles

3. **Asset Data**: `pubspec.yaml`
   - Images, fonts
   - Animations

---

## Component Hierarchy

### Page Structure

```
HomeScreen
├── Column
│   ├── TopNavBar
│   │   ├── Logo
│   │   ├── NavItems (Desktop)
│   │   │   └── _NavItem × N
│   │   ├── ContactButton
│   │   └── MobileMenuButton
│   │
│   └── SingleChildScrollView
│       ├── HeroSection
│       │   ├── ResponsiveRowColumn
│       │   │   ├── Column (Text Content)
│       │   │   │   ├── Greeting Badge
│       │   │   │   ├── Headline
│       │   │   │   ├── Subtitle
│       │   │   │   └── CTA Buttons
│       │   │   │       ├── CustomButton (Explore)
│       │   │   │       └── CustomButton (CV)
│       │   │   │
│       │   │   └── FloatingAnimation
│       │   │       └── Animated3DCard
│       │   │           └── Profile Image
│       │
│       ├── StatsSection
│       │   └── GridView
│       │       └── StatCard × 4
│       │           └── Animated3DCard
│       │
│       ├── NarrativeSection
│       │   ├── Title Badge
│       │   ├── Skill Badges
│       │   ├── Description
│       │   └── CTA + Avatars
│       │
│       ├── CTASection
│       │   ├── Title
│       │   ├── Subtitle
│       │   └── Buttons
│       │
│       └── Footer
│           ├── Social Links
│           └── Copyright
```

---

## State Management

### Current: **StatefulWidget with setState()**

For this MVP, we use Flutter's built-in state management:

```dart
class _HomeScreenState extends State<HomeScreen> {
  // Local state
  final ScrollController _scrollController = ScrollController();
  
  // Event handlers
  void _handleExplore() {
    setState(() {
      // Update state if needed
    });
    // Perform action
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopNavBar(onExplore: _handleExplore),
          // ... sections
        ],
      ),
    );
  }
}
```

### When to Scale

Consider adding **Provider** or **Riverpod** if you need:
- Global app state (user authentication, cart, etc.)
- State shared across multiple screens
- Complex business logic

**Current scope**: Simple callbacks are sufficient

---

## Routing Strategy

### Current: **Single Page with Scroll Navigation**

The app uses **scroll-based section navigation** instead of multi-page routing:

```dart
void _handleNavigation(String route) {
  switch (route) {
    case '/about':
      _scrollToSection(2);  // Scroll to About section
      break;
    case '/portfolio':
      _handleExploreWork();  // Navigate or show modal
      break;
    // ...
  }
}

void _scrollToSection(int sectionIndex) {
  _scrollController.animateTo(
    position,
    duration: Duration(milliseconds: 800),
    curve: Curves.easeInOut,
  );
}
```

### Future: Multi-Page Routing

If you expand to multiple pages:

```dart
MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => HomeScreen(),
    '/portfolio': (context) => PortfolioScreen(),
    '/contact': (context) => ContactScreen(),
  },
  onGenerateRoute: (settings) {
    // Dynamic routing
    if (settings.name == '/project') {
      return MaterialPageRoute(
        builder: (context) => ProjectDetailScreen(
          project: settings.arguments as Project,
        ),
      );
    }
  },
)
```

---

## Design Decisions

### 1. **Why Flutter Web?**

✅ **Pros**:
- Single codebase for web, mobile, desktop
- Rich animations and 3D effects
- Strong typing with Dart
- Hot reload for fast development
- Good performance with CanvasKit

❌ **Cons**:
- Larger initial load size vs. pure HTML/CSS
- SEO requires additional setup
- Not ideal for content-heavy sites

**Decision**: Flutter Web is perfect for this **interactive portfolio** with heavy animations.

### 2. **Why Component-Based Architecture?**

- **Modularity**: Easy to test and reuse components
- **Scalability**: Add new sections without touching existing code
- **Maintainability**: Clear separation of concerns
- **Team-friendly**: Multiple developers can work on different components

### 3. **Why Daylight Theme Instead of Dark?**

Reference screenshot showed dark theme, but requirements specified **daylight theme**:

- **Accessibility**: Better contrast for most users
- **Professional**: Clean, corporate feel
- **Flexibility**: Easier to add dark mode toggle later
- **Readability**: Text-heavy content reads better on light backgrounds

### 4. **Why Google Fonts Over Custom Fonts?**

- **Performance**: Fonts served from Google CDN
- **Caching**: Users likely have fonts cached
- **Ease**: No need to bundle font files
- **Variety**: Easy to switch fonts by changing one line

### 5. **Why StatefulWidget Over StatelessWidget?**

Used `StatefulWidget` for:
- Hover states (buttons, cards)
- Scroll position tracking
- Animation controllers

Used `StatelessWidget` for:
- Pure presentation (text, images)
- Config-driven components

### 6. **Why No Backend/Database?**

This is a **static portfolio site**:
- All content is hardcoded in `constants.dart`
- No user accounts or dynamic data
- Contact via `mailto` links
- CV served as static file

**When to add backend**:
- Blog posts or dynamic content
- Contact form with email service
- Analytics dashboard
- Content management system (CMS)

---

## Performance Optimizations

### 1. **Lazy Loading**
```dart
// Only load images when visible
if (isVisible) {
  Image.asset('profile.jpg')
} else {
  SizedBox() // Placeholder
}
```

### 2. **Const Constructors**
```dart
// Immutable widgets marked as const
const SizedBox(height: 16)
const Icon(Icons.star)
```

### 3. **RepaintBoundary**
```dart
// Isolate frequently updating widgets
RepaintBoundary(
  child: Animated3DCard(...)
)
```

### 4. **Image Optimization**
- **Format**: WebP for smaller file size
- **Resolution**: Serve appropriate sizes (1x, 2x, 3x)
- **Compression**: 85% quality for balance

---

## Security Considerations

### Current Implementation

1. **URL Validation**:
   ```dart
   await canLaunchUrl(uri)  // Validates before opening
   ```

2. **Email Links**:
   ```dart
   mailto: links  // Safe, opens user's client
   ```

3. **No User Input**:
   - No forms storing data
   - No authentication
   - No database

### Future Additions

If you add a contact form:
- Validate inputs client-side
- Sanitize data before sending
- Use reCAPTCHA to prevent spam
- Send via secure API (HTTPS)

---

## Testing Strategy

### Unit Tests
Test individual functions:
```dart
test('Responsive.isMobile returns true for mobile width', () {
  // Mock MediaQuery
  expect(Responsive.isMobile(context), true);
});
```

### Widget Tests
Test UI components:
```dart
testWidgets('CustomButton displays text', (tester) async {
  await tester.pumpWidget(
    CustomButton(text: 'Test', onPressed: () {}),
  );
  expect(find.text('Test'), findsOneWidget);
});
```

### Integration Tests
Test full user flows:
```dart
testWidgets('Clicking Explore scrolls to portfolio', (tester) async {
  await tester.pumpWidget(MyBrandingApp());
  await tester.tap(find.text('Explore My Work'));
  await tester.pumpAndSettle();
  // Verify scroll position changed
});
```

---

## Deployment Architecture

```
┌─────────────────┐
│  Source Code    │
│  (Flutter Web)  │
└────────┬────────┘
         │
         ▼
   flutter build web
         │
         ▼
┌─────────────────┐
│   build/web/    │
│  (Static Files) │
└────────┬────────┘
         │
         ├─▶ Firebase Hosting
         ├─▶ Vercel
         ├─▶ Netlify
         └─▶ GitHub Pages
              │
              ▼
      ┌─────────────────┐
      │   CDN (Global)  │
      │ - Fast delivery │
      │ - SSL/HTTPS     │
      │ - Caching       │
      └─────────────────┘
```

---

## Future Enhancements

### Phase 2: Content Expansion
- [ ] Portfolio page with project gallery
- [ ] Blog section with posts
- [ ] Testimonials section
- [ ] Skills with progress bars

### Phase 3: Interactivity
- [ ] Contact form with backend
- [ ] Newsletter signup
- [ ] Download CV analytics
- [ ] Social share buttons

### Phase 4: Advanced Features
- [ ] Dark mode toggle
- [ ] Multilingual support (i18n)
- [ ] Admin dashboard
- [ ] Content Management System

### Phase 5: Mobile Apps
- [ ] Compile to iOS app
- [ ] Compile to Android app
- [ ] App Store deployment

---

## Code Style Guide

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Files | `snake_case.dart` | `home_screen.dart` |
| Classes | `PascalCase` | `CustomButton` |
| Variables | `camelCase` | `isHovered` |
| Constants | `camelCase` | `primaryColor` |
| Private | `_prefixed` | `_buildButton()` |

### Folder Organization

- **Flat is better than nested**: Max 2-3 levels deep
- **Group by feature**: Keep related files together
- **Separate concerns**: Config ≠ UI ≠ Logic

### Comments

```dart
/// Public API documentation (triple slash)
/// Used for classes, methods

// Inline explanation (double slash)
// Used for complex logic

// TODO: Future enhancement
// FIXME: Known issue
```

---

## Glossary

| Term | Definition |
|------|------------|
| **StatelessWidget** | Widget that doesn't change over time |
| **StatefulWidget** | Widget with mutable state |
| **BuildContext** | Handle to widget's location in tree |
| **MaterialApp** | Root widget for Material Design apps |
| **Scaffold** | Basic page structure with app bar, body, etc. |
| **MediaQuery** | Access device screen size and settings |
| **Theme** | App-wide styling configuration |
| **Provider** | State management solution (not used in MVP) |

---

## Resources

- **Flutter Docs**: https://docs.flutter.dev
- **Dart Docs**: https://dart.dev/guides
- **Material Design**: https://material.io/design
- **Flutter Web**: https://docs.flutter.dev/get-started/web

---

*Last Updated: January 21, 2025*
