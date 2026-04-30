#!/bin/bash

echo "🚨 Firebase Removal Script for Flutter Projects"
echo "-------------------------------------------------"

# Step 1: Confirm user intention
read -rp "⚠️  Are you sure you want to remove Firebase from this Flutter project? (y/n): " confirm
[[ ! "$confirm" =~ ^[Yy]$ ]] && { echo "❌ Aborted by user."; exit 0; }

# Step 2: Validate environment
[[ ! -f "pubspec.yaml" ]] && { echo "❌ pubspec.yaml not found!"; exit 1; }
command -v flutter &>/dev/null || { echo "❌ Flutter not found in PATH."; exit 1; }

# Step 3: Remove Firebase dependencies from pubspec.yaml
echo "🧹 Removing Firebase dependencies from pubspec.yaml..."
firebase_packages=(
  "firebase_core"
  "firebase_auth"
  "cloud_firestore"
  "firebase_storage"
  "firebase_messaging"
  "firebase_crashlytics"
  "firebase_analytics"
  "firebase_remote_config"
  "firebase_dynamic_links"
)

for package in "${firebase_packages[@]}"; do
  sed -i.bak "/$package:/d" pubspec.yaml
done

echo "✅ Firebase packages removed from pubspec.yaml"
echo "📦 Running flutter pub get..."
flutter pub get

# Step 4: Remove Firebase files
echo "🧹 Removing Firebase config files..."

rm -f android/app/google-services.json
rm -f ios/Runner/GoogleService-Info.plist

echo "✅ Firebase config files removed."

# Step 5: Clean Android native Firebase setup
echo "🛠 Cleaning Android native configuration..."
sed -i.bak '/com.google.gms.google-services/d' android/app/build.gradle
sed -i.bak '/classpath "com.google.gms:google-services/d' android/build.gradle

echo "✅ Android native config cleaned."

# Step 6: Clean iOS native Firebase setup
echo "🛠 Cleaning iOS native configuration..."
sed -i.bak '/Firebase/d' ios/Runner/AppDelegate.swift
sed -i.bak '/import Firebase/d' ios/Runner/AppDelegate.swift

echo "✅ iOS native config cleaned."

# Step 7: (Optional) Remove initialization code
echo "⚠️  Reminder: Please manually remove Firebase initialization code from main.dart and other Dart files."

# Step 8: Cleanup temp files
echo "🧽 Cleaning up backup files..."
find . -type f -name "*.bak" -delete

echo "🎉 Firebase has been removed from your Flutter project."
echo "--------------------------------------------------------"
echo "🔚 Please double-check manually for any remaining import statements in Dart files like:"
echo "   - main.dart"
echo "   - any services or utils involving Firebase"