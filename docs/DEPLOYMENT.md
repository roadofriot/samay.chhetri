# 🚀 Deployment Guide

> Step-by-step instructions for deploying the Personal Branding Website to various platforms

---

## Table of Contents

- [Prerequisites](#prerequisites)
- [Build for Production](#build-for-production)
- [Deploy to Firebase Hosting](#deploy-to-firebase-hosting)
- [Deploy to Vercel](#deploy-to-vercel)
- [Deploy to Netlify](#deploy-to-netlify)
- [Deploy to GitHub Pages](#deploy-to-github-pages)
- [Custom Domain Setup](#custom-domain-setup)
- [SEO Optimization](#seo-optimization)
- [Performance Monitoring](#performance-monitoring)

---

## Prerequisites

Before deploying, ensure you have:

- ✅ Flutter SDK 3.27+ installed
- ✅ Dart SDK 3.6+ installed
- ✅ Git installed and configured
- ✅ Project tested locally (`flutter run -d chrome`)
- ✅ All assets optimized (images compressed, etc.)

---

## Build for Production

### 1. Clean Previous Builds
```bash
flutter clean
flutter pub get
```

### 2. Build for Web (CanvasKit Renderer - Recommended)
```bash
flutter build web --release --web-renderer canvaskit
```

**CanvasKit** provides better performance and more consistent rendering across browsers.

### 3. Build for Web (HTML Renderer - Alternative)
```bash
flutter build web --release --web-renderer html
```

**HTML** renderer is lighter (smaller download) but may have rendering inconsistencies.

### 4. Verify Build
The output will be in `build/web/` directory:
```
build/web/
├── assets/
├── canvaskit/
├── favicon.png
├── flutter.js
├── flutter_service_worker.js
├── index.html
├── main.dart.js
├── manifest.json
└── version.json
```

---

## Deploy to Firebase Hosting

Firebase Hosting is **recommended** for Flutter web apps due to its excellent performance and free SSL.

### Step 1: Install Firebase CLI
```bash
npm install -g firebase-tools
```

### Step 2: Login to Firebase
```bash
firebase login
```

### Step 3: Initialize Firebase in Your Project
```bash
cd /home/strategy/Install/Projects/PersonalBrand/MyBranding
firebase init hosting
```

**Configuration:**
- Select "Use an existing project" or "Create a new project"
- Set public directory: `build/web`
- Configure as single-page app: **Yes**
- Set up automatic builds with GitHub: **Optional**

### Step 4: Build the Project
```bash
flutter build web --release --web-renderer canvaskit
```

### Step 5: Deploy to Firebase
```bash
firebase deploy --only hosting
```

### Step 6: View Your Site
After deployment, Firebase will provide a URL:
```
✔  Deploy complete!

Project Console: https://console.firebase.google.com/project/YOUR_PROJECT_ID/overview
Hosting URL: https://YOUR_PROJECT_ID.web.app
```

### Custom Domain (Optional)
```bash
firebase hosting:channel:deploy production --expires 30d
```

---

## Deploy to Vercel

Vercel offers fast deployments with automatic SSL and CDN.

### Step 1: Install Vercel CLI
```bash
npm install -g vercel
```

### Step 2: Login to Vercel
```bash
vercel login
```

### Step 3: Build the Project
```bash
flutter build web --release --web-renderer canvaskit
```

### Step 4: Deploy
```bash
cd build/web
vercel --prod
```

### Step 5: Configure Project (First Time)
- Set project name
- Select framework: **Other**
- Set build command: *Leave empty*
- Set output directory: `.`

### Step 6: Access Your Site
Vercel will provide a URL like:
```
https://your-project.vercel.app
```

---

## Deploy to Netlify

Netlify provides simple drag-and-drop deployment with continuous deployment option.

### Option 1: Netlify CLI

#### Step 1: Install Netlify CLI
```bash
npm install -g netlify-cli
```

#### Step 2: Login
```bash
netlify login
```

#### Step 3: Build
```bash
flutter build web --release --web-renderer canvaskit
```

#### Step 4: Deploy
```bash
netlify deploy --dir=build/web --prod
```

### Option 2: Drag & Drop (Easiest)

1. Build the project:
   ```bash
   flutter build web --release
   ```

2. Go to [Netlify Drop](https://app.netlify.com/drop)

3. Drag the `build/web` folder onto the page

4. Your site will be live at `https://random-name.netlify.app`

---

## Deploy to GitHub Pages

Host your site for free on GitHub.

### Step 1: Build with Base Href
```bash
flutter build web --release --base-href "/your-repository-name/"
```

⚠️ Replace `your-repository-name` with your actual GitHub repository name.

### Step 2: Copy Build to Docs Folder
```bash
cp -r build/web docs/
```

Or create a `gh-pages` branch:
```bash
git checkout -b gh-pages
cp -r build/web/* .
git add .
git commit -m "Deploy to GitHub Pages"
git push origin gh-pages
```

### Step 3: Enable GitHub Pages
1. Go to repository Settings
2. Scroll to "Pages" section
3. Source: Select `gh-pages` branch or `docs` folder
4. Click "Save"

### Step 4: Access Your Site
Site will be available at:
```
https://your-username.github.io/your-repository-name/
```

---

## Custom Domain Setup

### Firebase Hosting

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project
3. Go to **Hosting** → **Add custom domain**
4. Follow the verification steps
5. Add DNS records provided by Firebase

### Vercel

1. Go to your project in Vercel dashboard
2. **Settings** → **Domains**
3. Add your custom domain
4. Update DNS records:
   - **A Record:** `76.76.21.21`
   - **CNAME Record:** `cname.vercel-dns.com`

### Netlify

1. **Site settings** → **Domain management**
2. **Add custom domain**
3. Update DNS:
   - **CNAME Record:** `YOUR_SITE.netlify.app`

---

## SEO Optimization

### 1. Update `web/index.html`

Add proper meta tags:

```html
<!DOCTYPE html>
<html>
<head>
  <base href="$FLUTTER_BASE_HREF">
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  
  <!-- SEO Meta Tags -->
  <title>Sammy B.C. - Business Development Consultant & Full-Stack Developer</title>
  <meta name="description" content="Explore the portfolio of Sammy Budhathoki Chhetri, combining business development expertise with full-stack development skills.">
  <meta name="keywords" content="Business Development, Full-Stack Developer, React, JavaScript, AR, Blockchain, Nepal">
  <meta name="author" content="Sammy Budhathoki Chhetri">
  
  <!-- Open Graph (Social Media) -->
  <meta property="og:title" content="Sammy B.C. - The Fusion of Business & Code">
  <meta property="og:description" content="A unique dual expertise combining business strategy with technical development.">
  <meta property="og:image" content="https://yourdomain.com/social-preview.png">
  <meta property="og:url" content="https://yourdomain.com">
  <meta property="og:type" content="website">
  
  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="Sammy B.C. - The Fusion of Business & Code">
  <meta name="twitter:description" content="Business Development Consultant & Full-Stack Developer">
  <meta name="twitter:image" content="https://yourdomain.com/social-preview.png">
  
  <!-- Favicon -->
  <link rel="icon" type="image/png" href="favicon.png"/>
  <link rel="apple-touch-icon" href="icons/Icon-192.png">
  
  <!-- Manifest -->
  <link rel="manifest" href="manifest.json">
</head>
<body>
  <script src="flutter.js" defer></script>
</body>
</html>
```

### 2. Add `robots.txt`

Create `web/robots.txt`:
```
User-agent: *
Allow: /

Sitemap: https://yourdomain.com/sitemap.xml
```

### 3. Create `sitemap.xml`

Create `web/sitemap.xml`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://yourdomain.com/</loc>
    <lastmod>2025-01-21</lastmod>
    <priority>1.0</priority>
  </url>
  <url>
    <loc>https://yourdomain.com/about</loc>
    <lastmod>2025-01-21</lastmod>
    <priority>0.8</priority>
  </url>
  <url>
    <loc>https://yourdomain.com/portfolio</loc>
    <lastmod>2025-01-21</lastmod>
    <priority>0.8</priority>
  </url>
</urlset>
```

---

## Performance Monitoring

### Google Analytics (Optional)

Add to `web/index.html`:
```html
<!-- Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=GA_MEASUREMENT_ID"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'GA_MEASUREMENT_ID');
</script>
```

### Performance Monitoring

1. Use [Lighthouse](https://developers.google.com/web/tools/lighthouse) in Chrome DevTools
2. Aim for scores:
   - Performance: > 90
   - Accessibility: > 90
   - Best Practices: > 90
   - SEO: > 90

Run Lighthouse:
```bash
lighthouse https://yourdomain.com --view
```

---

## Post-Deployment Checklist

- [ ] All pages load correctly
- [ ] All buttons and links function properly
- [ ] Images load and display correctly
- [ ] Responsive design works on mobile, tablet, desktop
- [ ] 3D animations run smoothly (60fps)
- [ ] Contact form sends emails/submissions
- [ ] CV download works
- [ ] Social links open correctly
- [ ] SSL certificate is active (HTTPS)
- [ ] Custom domain is configured (if applicable)
- [ ] SEO meta tags are present
- [ ] Google Analytics is tracking (if configured)
- [ ] Lighthouse score > 90 for all categories

---

## Troubleshooting

### Issue: Blank white screen after deployment

**Solution:**
- Check browser console for errors
- Ensure `--base-href` is set correctly (especially for GitHub Pages)
- Verify all assets are in the `build/web` directory

### Issue: Assets not loading (404 errors)

**Solution:**
- Rebuild with correct `--base-href`
- Check that `pubspec.yaml` assets are correctly declared
- Verify asset paths in code

### Issue: Slow load times

**Solution:**
- Use `--web-renderer canvaskit` for better performance
- Compress images (WebP format recommended)
- Enable CDN on hosting platform
- Implement lazy loading for images

---

## Updates & Redeployment

When you make changes:

1. **Update code**
2. **Test locally:** `flutter run -d chrome`
3. **Build:** `flutter build web --release`
4. **Deploy:** Run deployment command for your platform

---

**🎉 Congratulations! Your Personal Branding Website is now live!**

For support or questions, refer to the [README.md](../README.md) or contact documentation.
