# 🚀 Quick Start Guide

> Get your Personal Branding Website up and running in minutes!

---

## ⚡ Super Quick Start (TL;DR)

```bash
cd /home/strategy/Install/Projects/PersonalBrand/MyBranding

# 1. Run the app
flutter run -d chrome

# 2. Customize your info
# Edit: lib/config/constants.dart

# 3. Add your photo
# Replace: screen.png with your profile image

# 4. Build for production
flutter build web --release

# 5. Deploy
firebase deploy --only hosting
```

**Done!** 🎉 Your site is live!

---

## 📋 Prerequisites

Before you start, make sure you have:

- ✅ Flutter SDK 3.27+
- ✅ Dart SDK 3.6+
- ✅ Chrome browser
- ✅ Code editor (VS Code recommended)

### Check Your Setup

```bash
flutter --version
dart --version
```

If not installed, visit: https://docs.flutter.dev/get-started/install

---

## 🎯 Step-by-Step Setup

### Step 1: Navigate to Project

```bash
cd /home/strategy/Install/Projects/PersonalBrand/MyBranding
```

### Step 2: Get Dependencies

```bash
flutter pub get
```

**Expected output**: `Got dependencies!`

### Step 3: Run the App

```bash
flutter run -d chrome
```

**What happens**:
- Chrome opens automatically
- App compiles (first time: 30-60 seconds)
- Hot reload enabled (press `r` to reload)

**App URL**: http://localhost:PORT (random port)

### Step 4: Verify Everything Works

You should see:
- ✅ Navigation bar at top
- ✅ Hero section with "The Fusion of Business & Code"
- ✅ Stats cards (5+ Years, 2nd Place, 50+ Projects, 99%)
- ✅ Strategic Narrative section
- ✅ CTA section with buttons
- ✅ Footer with social links

---

## ✏️ Customize Your Site

### 1. Update Personal Information

**File**: `lib/config/constants.dart`

```dart
class AppConstants {
  // YOUR INFORMATION
  static const String name = "Your Name";  // ← Change this
  static const String fullName = "Your Full Name";  // ← Change this
  static const String email = "your@email.com";  // ← Change this
  
  // SOCIAL LINKS
  static const String linkedIn = "https://linkedin.com/in/yourprofile";  // ← Change
  static const String github = "https://github.com/yourusername";  // ← Change
  
  // STATS
  static const String yearsExperience = "5+";  // ← Update your numbers
  static const String projectsCompleted = "50+";  // ← Update
  static const String clientSuccessRate = "99%";  // ← Update
  
  // ABOUT YOU
  static const String narrativeText = "Write your story here...";  // ← Tell your story
}
```

**Save**, then press `r` in the terminal to hot reload.

### 2. Add Your Profile Photo

**Option A**: Replace `screen.png`
```bash
# Replace the existing file
cp /path/to/your/photo.jpg screen.png
```

**Option B**: Use assets folder
```bash
# 1. Copy your photo
cp /path/to/your/photo.jpg assets/images/profile.jpg

# 2. Update lib/config/constants.dart
static const String profileImagePath = "assets/images/profile.jpg";
```

### 3. Update Colors (Optional)

**File**: `lib/config/theme.dart`

```dart
// Change primary color
static const Color primary500 = Color(0xFF6366F1);  // ← Your brand color

// Change secondary color
static const Color secondary500 = Color(0xFFA855F7);  // ← Complementary color
```

### 4. Add Your CV File

```bash
# 1. Create CV folder
mkdir -p assets/cv

# 2. Add your CV
cp /path/to/your_cv.pdf assets/cv/sammy_cv.pdf

# 3. Update pubspec.yaml (already done)
# 4. Update download link in home_screen.dart
```

**File**: `lib/screens/home_screen.dart`

Find `_handleDownloadCV()` and update:
```dart
final cvUrl = 'https://yourdomain.com/cv.pdf';  // ← Your CV URL
```

---

## 🎨 Customization Tips

### Change Font

**File**: `lib/config/theme.dart`

```dart
import 'package:google_fonts/google_fonts.dart';

// Replace Outfit with your choice
GoogleFonts.poppins(...)  // ← Poppins, Montserrat, Raleway, etc.
```

View fonts: https://fonts.google.com

### Add More Skills

**File**: `lib/config/constants.dart`

```dart
static const List<Map<String, String>> skills = [
  {'icon': '⚛️', 'name': 'React/JS'},
  {'icon': '📈', 'name': 'Market Expansion'},
  {'icon': '🔮', 'name': 'AR & BLOCKCHAIN'},
  {'icon': '🎨', 'name': 'UI/UX Design'},  // ← Add more
];
```

### Adjust 3D Animation Strength

**File**: `lib/widgets/sections/hero_section.dart`

```dart
Animated3DCard(
  maxTilt: 5,  // ← Less tilt (subtle)
  // maxTilt: 15,  ← More tilt (dramatic)
  ...
)
```

---

## 🐛 Troubleshooting

### Problem: "flutter command not found"

**Solution**:
```bash
export PATH="$PATH:/home/strategy/flutter/bin"
# Or wherever Flutter is installed
```

### Problem: Dependencies not installing

**Solution**:
```bash
flutter clean
flutter pub get
```

### Problem: Chrome not opening

**Solution**:
```bash
# Manually specify Chrome
flutter run -d web-server --web-port=8080
# Then open http://localhost:8080 in browser
```

### Problem: Hot reload not working

**Solution**:
Press `R` (capital R) for hot restart instead of `r`

### Problem: Layout overflow warning

**Solution**: This is minor and cosmetic. Ignore for now or see `PROJECT_SUMMARY.md` for fix.

---

## 📦 Build for Production

### 1. Build Command

```bash
flutter build web --release --web-renderer canvaskit
```

**Output**: `build/web/` folder

### 2. Test Production Build

```bash
cd build/web
python -m http.server 8000
# Open http://localhost:8000
```

### 3. Deploy

**Firebase Hosting** (recommended):
```bash
firebase login
firebase init hosting
firebase deploy --only hosting
```

**Vercel**:
```bash
cd build/web
vercel --prod
```

**Netlify**:
```bash
netlify deploy --dir=build/web --prod
```

See `docs/DEPLOYMENT.md` for detailed instructions.

---

## 🎓 Learn More

### Documentation

- **README.md** - Project overview
- **docs/DESIGN_SPECS.md** - Design system
- **docs/ARCHITECTURE.md** - Code structure
- **docs/ANIMATION_GUIDE.md** - 3D effects guide
- **docs/DEPLOYMENT.md** - Deployment instructions
- **PROJECT_SUMMARY.md** - Setup summary

### Keyboard Shortcuts (While Running)

| Key | Action |
|-----|--------|
| `r` | Hot reload (fast) |
| `R` | Hot restart (full reload) |
| `h` | Help (show all commands) |
| `q` | Quit |
| `c` | Clear screen |

---

## ✅ Pre-Launch Checklist

Before going live, verify:

- [ ] Updated all personal information in `constants.dart`
- [ ] Added your profile photo
- [ ] Updated social media links
- [ ] Added CV file or download link
- [ ] Tested all buttons (Explore, Download CV, Contact)
- [ ] Checked on mobile (resize browser)
- [ ] Verified email links work
- [ ] Tested on Chrome, Firefox, Safari
- [ ] Built production version
- [ ] Deployed to hosting platform
- [ ] Configured custom domain (optional)
- [ ] Added Google Analytics (optional)
- [ ] Ran Lighthouse audit (aim for 90+)

---

## 🆘 Need Help?

### Common Questions

**Q: Can I use this code commercially?**
A: Yes, it's your personal branding site. Customize and deploy freely!

**Q: How do I add a blog section?**
A: See `docs/ARCHITECTURE.md` → Future Enhancements

**Q: Can I change to dark mode?**
A: Yes! Modify colors in lib/config/theme.dart or add a theme toggle.

**Q: How do I add Google Analytics?**
A: See `docs/DEPLOYMENT.md` → Performance Monitoring

**Q: Where do I host this?**
A: Firebase (free, recommended), Vercel, Netlify, or GitHub Pages

### Resources

- **Flutter Documentation**: https://docs.flutter.dev
- **Stack Overflow**: https://stackoverflow.com/questions/tagged/flutter
- **Flutter Community**: https://flutter.dev/community

---

## 🎉 You're Ready!

Your personal branding website is set up and ready to customize!

**Next steps**:
1. ✏️ Update `lib/config/constants.dart` with your info
2. 📸 Add your profile photo
3. 🎨 Customize colors (optional)
4. 🚀 Deploy to the web

**Good luck!** 🚀

---

*Last Updated: January 21, 2025*
