#!/bin/bash

# setup_github.sh
# Automates the process of linking to GitHub

echo "🚀 Starting GitHub Setup..."

# 1. Ask for repository URL
echo ""
echo "Please create a new EMPTY repository on GitHub."
echo "Go to: https://github.com/new"
echo "Name it: personal-branding (or similar)"
echo "Do NOT initialize with README, .gitignore, or license."
echo ""
read -p "Enter your new Repository URL (e.g., https://github.com/yourname/repo.git): " REPO_URL

if [ -z "$REPO_URL" ]; then
    echo "❌ Error: Repository URL is required."
    exit 1
fi

# 2. Add Remote
echo "🔗 Linking to GitHub..."
git remote add origin "$REPO_URL"
# If origin already exists, try to set url
if [ $? -ne 0 ]; then
    echo "Remote 'origin' might already exist. Updating URL..."
    git remote set-url origin "$REPO_URL"
fi

# 3. Rename branch to main (common practice)
git branch -m main

# 4. Push code
echo "⬆️ Pushing code to GitHub..."
git push -u origin main

echo ""
echo "✅ Project successfully pushed to GitHub!"
