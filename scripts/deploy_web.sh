#!/bin/bash

# deploy_web.sh
# Builds and deploys the Flutter web app to GitHub Pages

echo "🚀 Starting Deployment to GitHub Pages..."

# 1. Check if remote origin is set
REMOTE_URL=$(git config --get remote.origin.url)

if [ -z "$REMOTE_URL" ]; then
    echo "❌ Error: Git remote 'origin' is not set. Run ./scripts/setup_github.sh first."
    exit 1
fi

# Extract repo name for base-href (e.g., https://github.com/user/repo.git -> /repo/)
REPO_NAME=$(basename -s .git "$REMOTE_URL")
BASE_HREF="/$REPO_NAME/"

echo "📍 Detected Repository Name: $REPO_NAME"
echo "🔗 Setting Base HREF: $BASE_HREF"

# 2. Build for Web
echo "🔨 Building project..."
flutter clean
flutter pub get
flutter build web --release --base-href "$BASE_HREF"

if [ $? -ne 0 ]; then
    echo "❌ Build failed. Aborting deployment."
    exit 1
fi

# 3. Deploy to gh-pages branch
echo "📤 Deploying to gh-pages branch..."

# Create a temporary directory for deployment
DEPLOY_DIR="deploy_temp"
rm -rf "$DEPLOY_DIR"
mkdir "$DEPLOY_DIR"

# Copy build artifacts
cp -r build/web/* "$DEPLOY_DIR/"

# Go to deploy directory
cd "$DEPLOY_DIR"

# Initialize git
git init
git add .
git commit -m "Deploy to GitHub Pages: $(date)"

# Push to gh-pages
echo "⬆️ Pushing..."
git push --force "$REMOTE_URL" master:gh-pages

# Clean up
cd ..
rm -rf "$DEPLOY_DIR"

echo ""
echo "✅ Deployment Complete!"
echo "🌍 Your website should be live in a few minutes at:"
echo "   https://$(echo "$REMOTE_URL" | sed -E 's/https?:\/\/github.com\///' | cut -d/ -f1).github.io/$REPO_NAME/"
