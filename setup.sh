#!/usr/bin/env bash
# setup.sh — テンプレートを新しいアプリ用に初期化するスクリプト
#
# 使い方: bash setup.sh
#
# このスクリプトは、コードベース内の {{PLACEHOLDER}} を
# あなたのアプリ固有の値に置き換え、テンプレートの雛形を整理します。

set -euo pipefail

echo "========================================"
echo "  App Factory テンプレート セットアップ"
echo "========================================"
echo ""

# --- 入力を収集 ---
read -rp "アプリ表示名（例: MyApp）: " APP_NAME
read -rp "アプリスラッグ（URL用、例: myapp）: " APP_SLUG
read -rp "Android パッケージ名（例: com.yourcompany.myapp）: " ANDROID_PACKAGE
read -rp "iOS バンドルID（例: com.yourcompany.myapp）: " IOS_BUNDLE_IDENTIFIER
read -rp "ディープリンクスキーム（例: myapp）: " APP_SCHEME
read -rp "アプリの一行説明: " DESCRIPTION
read -rp "EAS プロジェクトID（不明な場合は空欄でOK）: " EAS_PROJECT_ID

echo ""
echo "--- 入力内容の確認 ---"
echo "  APP_NAME:               $APP_NAME"
echo "  APP_SLUG:               $APP_SLUG"
echo "  ANDROID_PACKAGE:        $ANDROID_PACKAGE"
echo "  IOS_BUNDLE_IDENTIFIER:  $IOS_BUNDLE_IDENTIFIER"
echo "  APP_SCHEME:             $APP_SCHEME"
echo "  DESCRIPTION:            $DESCRIPTION"
echo "  EAS_PROJECT_ID:         ${EAS_PROJECT_ID:-"（スキップ）"}"
echo ""
read -rp "この内容で進めますか？ (y/N): " CONFIRM
if [[ "$CONFIRM" != "y" && "$CONFIRM" != "Y" ]]; then
  echo "中断しました。"
  exit 1
fi

echo ""
echo "=== プレースホルダーを置換中 ==="

# --- ソースファイル内のプレースホルダーを置換 ---
replace_placeholder() {
  local placeholder="$1"
  local value="$2"
  echo "  $placeholder → $value"

  # sed用に特殊文字をエスケープ
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

# --- .env.example を更新 ---
echo ""
echo "=== .env.example を更新中 ==="
sed -i "s/^APP_NAME=.*/APP_NAME=$APP_NAME/" .env.example
sed -i "s/^APP_SLUG=.*/APP_SLUG=$APP_SLUG/" .env.example
sed -i "s/^ANDROID_PACKAGE=.*/ANDROID_PACKAGE=$ANDROID_PACKAGE/" .env.example
sed -i "s/^IOS_BUNDLE_IDENTIFIER=.*/IOS_BUNDLE_IDENTIFIER=$IOS_BUNDLE_IDENTIFIER/" .env.example

# --- .env.example から .env をコピー ---
cp .env.example .env
echo "  .env.example から .env を作成しました"

# --- app.json を更新 ---
echo ""
echo "=== app.json を更新中 ==="
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
echo "  app.json を更新しました"

# --- package.json の name を更新 ---
echo ""
echo "=== package.json を更新中 ==="
node -e "
  const fs = require('fs');
  const json = JSON.parse(fs.readFileSync('package.json', 'utf8'));
  json.name = '$APP_SLUG';
  fs.writeFileSync('package.json', JSON.stringify(json, null, 2) + '\n');
"
echo "  package.json の name を更新しました"

# --- テンプレートファイルの整理 ---
echo ""
echo "=== テンプレートファイルを整理中 ==="
rm -f TEMPLATE_README.md
echo "  TEMPLATE_README.md を削除しました"

# --- 依存関係のインストール ---
echo ""
echo "=== 依存関係をインストール中 ==="
pnpm install

# --- 検証 ---
echo ""
echo "=== 検証を実行中 ==="
pnpm verify || echo "警告: 検証で問題がありました — 上の出力を確認してください"

echo ""
echo "========================================"
echo "  セットアップ完了！"
echo ""
echo "  次のステップ:"
echo "    1. .env を確認してAPIキーを設定する"
echo "    2. pnpm dev で開発を開始する"
echo "    3. docs/ 内のドキュメントを参照してカスタマイズする"
echo "========================================"
