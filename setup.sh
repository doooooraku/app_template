#!/usr/bin/env bash
# setup.sh — Initialize this template for a new app
#
# Usage: bash setup.sh
#
# This script replaces all {{PLACEHOLDER}} values in the codebase with
# your app-specific values, then cleans up the template scaffolding.

set -euo pipefail

echo "========================================"
echo "  App Factory Template Setup"
echo "========================================"
echo ""

# --- Collect input ---
read -rp "App display name (e.g. MyApp): " APP_NAME
read -rp "App slug (URL-safe, e.g. myapp): " APP_SLUG
read -rp "Android package (e.g. com.yourcompany.myapp): " ANDROID_PACKAGE
read -rp "iOS bundle identifier (e.g. com.yourcompany.myapp): " IOS_BUNDLE_IDENTIFIER
read -rp "Deep link scheme (e.g. myapp): " APP_SCHEME
read -rp "One-line description: " DESCRIPTION
read -rp "EAS project ID (leave empty to skip): " EAS_PROJECT_ID

echo ""
echo "--- Confirming ---"
echo "  APP_NAME:               $APP_NAME"
echo "  APP_SLUG:               $APP_SLUG"
echo "  ANDROID_PACKAGE:        $ANDROID_PACKAGE"
echo "  IOS_BUNDLE_IDENTIFIER:  $IOS_BUNDLE_IDENTIFIER"
echo "  APP_SCHEME:             $APP_SCHEME"
echo "  DESCRIPTION:            $DESCRIPTION"
echo "  EAS_PROJECT_ID:         ${EAS_PROJECT_ID:-"(skipped)"}"
echo ""
read -rp "Proceed? (y/N): " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
  echo "Aborted."
  exit 1
fi

echo ""
echo "=== Replacing placeholders ==="

# --- Replace in source files ---
# Using find + sed for cross-platform compatibility
replace_placeholder() {
  local placeholder="$1"
  local value="$2"
  echo "  Replacing $placeholder → $value"

  # Escape special characters for sed
  local escaped_value
  escaped_value=$(printf '%s\n' "$value" | sed -e 's/[\/&]/\\&/g')

  find . -type f \
    \( -name "*.ts" -o -name "*.tsx" -o -name "*.js" -o -name "*.mjs" \
       -o -name "*.json" -o -name "*.md" -o -name "*.yml" -o -name "*.yaml" \
       -o -name "*.sh" -o -name "*.env*" -o -name ".env.example" \
       -o -name "app.config.ts" -o -name "app.json" \) \
    -not -path "*/node_modules/*" \
    -not -path "*/.git/*" \
    -not -path "*/dist/*" \
    -not -name "setup.sh" \
    -exec sed -i "s/${placeholder}/${escaped_value}/g" {} +
}

replace_placeholder "{{APP_NAME}}" "$APP_NAME"
replace_placeholder "{{APP_SLUG}}" "$APP_SLUG"
replace_placeholder "{{ANDROID_PACKAGE}}" "$ANDROID_PACKAGE"
replace_placeholder "{{IOS_BUNDLE_IDENTIFIER}}" "$IOS_BUNDLE_IDENTIFIER"
replace_placeholder "{{APP_SCHEME}}" "$APP_SCHEME"
replace_placeholder "{{DESCRIPTION}}" "$DESCRIPTION"

if [[ -n "$EAS_PROJECT_ID" ]]; then
  replace_placeholder "{{EAS_PROJECT_ID}}" "$EAS_PROJECT_ID"
fi

# --- Update .env.example ---
echo ""
echo "=== Updating .env.example ==="
sed -i "s/^APP_NAME=.*/APP_NAME=$APP_NAME/" .env.example
sed -i "s/^APP_SLUG=.*/APP_SLUG=$APP_SLUG/" .env.example
sed -i "s/^ANDROID_PACKAGE=.*/ANDROID_PACKAGE=$ANDROID_PACKAGE/" .env.example
sed -i "s/^IOS_BUNDLE_IDENTIFIER=.*/IOS_BUNDLE_IDENTIFIER=$IOS_BUNDLE_IDENTIFIER/" .env.example

# --- Copy .env.example to .env ---
cp .env.example .env
echo "  Created .env from .env.example"

# --- Update app.json ---
echo ""
echo "=== Updating app.json ==="
node -e "
  const fs = require('fs');
  const json = JSON.parse(fs.readFileSync('app.json', 'utf8'));
  const expo = json.expo || json;
  expo.name = '$APP_NAME';
  expo.slug = '$APP_SLUG';
  expo.scheme = '$APP_SCHEME';
  if (expo.description !== undefined || '$DESCRIPTION') {
    expo.description = '$DESCRIPTION';
  }
  fs.writeFileSync('app.json', JSON.stringify(json, null, 2) + '\n');
"
echo "  Updated app.json"

# --- Update package.json name ---
echo ""
echo "=== Updating package.json ==="
node -e "
  const fs = require('fs');
  const json = JSON.parse(fs.readFileSync('package.json', 'utf8'));
  json.name = '$APP_SLUG';
  fs.writeFileSync('package.json', JSON.stringify(json, null, 2) + '\n');
"
echo "  Updated package.json name"

# --- Clean up template files ---
echo ""
echo "=== Cleaning up template scaffolding ==="
rm -f TEMPLATE_README.md
echo "  Removed TEMPLATE_README.md"

# --- Install dependencies ---
echo ""
echo "=== Installing dependencies ==="
pnpm install

# --- Verify ---
echo ""
echo "=== Running verification ==="
pnpm verify || echo "WARN: verify had issues — check output above"

echo ""
echo "========================================"
echo "  Setup complete!"
echo ""
echo "  Next steps:"
echo "    1. Review .env and fill in API keys"
echo "    2. Run: pnpm dev"
echo "    3. Read TEMPLATE_README.md (if kept) for more info"
echo "========================================"
