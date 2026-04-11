---
name: new-feature
description: Implement a new feature following the project's vertical slice pattern
---

# /new-feature — 新機能実装

ユーザーが「新機能を作って」「Issue #N を実装して」と言ったらこの手順に従う。

## 入力

- Issue 番号 or 機能の説明
- 関連する仕様書（`docs/reference/`）

## 手順

1. **関連 Issue を確認** — `gh issue view <番号>` で受け入れ条件を読む
2. **既存コードを読む** — 同じ機能領域のファイルを 3〜5 個読み、設計パターンを把握
   - 親子関係パターンの参考: `src/db/exampleRepository.ts`
   - 画面の参考: `src/features/example/ExampleScreen.tsx`
   - i18n の参考: `src/core/i18n/locales/en.ts`
3. **テストを先に作成** — `__tests__/<feature>.test.ts` で受け入れ条件を Jest テスト化
4. **実装** — `src/features/<feature>/` に垂直スライスで配置
   - Screen → components/ → hooks/ → utils/
   - i18n キーは追加と同時に **全 19 言語ファイル**に明示的に追加（baseEn フォールバック禁止）
5. **品質チェック** — `pnpm verify` 全パスを確認
6. **PR 作成** — `gh pr create` で PR 説明（What / Why / How to test）

## 制約

- iOS / Android 両方で動作すること
- 1 つの PR に 1 つの機能（スコープを小さく保つ）
- ファイルパス（写真等）は **必ず相対パス** で保存（`src/db/filePathUtils.ts` 経由）
- API キーは `.env` から（コード直書き禁止）
- 不要な依存パッケージを追加しない

## 完了基準

- [ ] `pnpm verify` 全パス
- [ ] PR が作成済み
- [ ] 受け入れ条件をテストでカバー
