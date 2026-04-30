#!/bin/bash

# Exit on error, undefined variable, or pipeline failure
set -euo pipefail

echo "📦 Flutter Package Name Changer"
echo "----------------------------------------"

NEW_PACKAGE="${1:-}"

# Validate argument
if [[ -z "$NEW_PACKAGE" ]]; then
  echo "❌ Usage: $0 <new.package.name>"
  exit 1
fi

# Validate package name format (basic)
if ! [[ "$NEW_PACKAGE" =~ ^[a-zA-Z_][a-zA-Z0-9_]*(\.[a-zA-Z0-9_]+)+$ ]]; then
  echo "❌ Invalid package name format. Example: com.example.app"
  exit 1
fi

# Check Flutter is installed
if ! command -v flutter &> /dev/null; then
  echo "❌ Flutter is not installed or not in PATH."
  exit 1
fi

# Check pubspec.yaml exists
if [[ ! -f "pubspec.yaml" ]]; then
  echo "❌ pubspec.yaml not found in current directory."
  exit 1
fi

# Step 1: Add dependency if not already added
echo "🔍 Checking for 'change_app_package_name' package..."

if ! flutter pub deps | grep -q 'change_app_package_name'; then
  echo "➕ Adding 'change_app_package_name' to pubspec.yaml..."
  flutter pub add change_app_package_name
  sed -i '' -E "s/^([[:space:]]*change_app_package_name:[[:space:]]*)\^/\1/" pubspec.yaml
else
  echo "✅ 'change_app_package_name' already exists."
fi

# Step 2: Use package to restructure package
echo "🔄 Changing Dart package structure to: $NEW_PACKAGE..."
flutter pub run change_app_package_name:main "$NEW_PACKAGE"

# Step 3: Clean up package
echo "🧹 Removing 'change_app_package_name' from pubspec.yaml..."
sed -i '' '/change_app_package_name:/d' pubspec.yaml
flutter pub get

# Step 4: Change Android applicationId in build.gradle
echo "🛠 Updating Android applicationId..."
APP_BUILD_GRADLE="android/app/build.gradle"
if grep -q "applicationId" "$APP_BUILD_GRADLE"; then
  sed -i '' -E "s/applicationId \"[^\"]+\"/applicationId \"$NEW_PACKAGE\"/" "$APP_BUILD_GRADLE"
else
  echo "⚠️ applicationId not found in $APP_BUILD_GRADLE. Please check manually."
fi

# Step 5: Change iOS bundle identifier
echo "🛠 Updating iOS bundle identifier..."
IOS_PBXPROJ="ios/Runner.xcodeproj/project.pbxproj"
if grep -q "PRODUCT_BUNDLE_IDENTIFIER" "$IOS_PBXPROJ"; then
  sed -i '' -E "s/PRODUCT_BUNDLE_IDENTIFIER = [^;]+;/PRODUCT_BUNDLE_IDENTIFIER = $NEW_PACKAGE;/" "$IOS_PBXPROJ"
else
  echo "⚠️ PRODUCT_BUNDLE_IDENTIFIER not found in $IOS_PBXPROJ. Please check manually."
fi

# Step 6: Reminder for iOS capabilities
echo "📱 iOS Reminder: If your app uses capabilities like push notifications or Firebase, you may also need to update:"
echo "   - Xcode project settings"
echo "   - Apple developer portal (bundle ID)"
echo "   - Info.plist values (if required)"

# Step 7: Done
echo ""
echo "✅ All done! Package name updated to: $NEW_PACKAGE"
echo "📦 Android `applicationId` and iOS `PRODUCT_BUNDLE_IDENTIFIER` updated."