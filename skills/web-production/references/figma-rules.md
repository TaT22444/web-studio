# 🎨 Figma納品用HTML 出力ルール（Claude内部参照用）

> このファイルはClaudeが Phase 2 を進めるための内部ガイドです。
> Phase 2の成果物は `{project-name}/design-draft.html` に書き出します。

FigmaプラグインにHTMLを読み込んでデザインデータとして納品するための仕様。

---

## デザイントークン記録（必須）

HTMLの冒頭コメントに、クライアントが決定したデザインの根拠を記録する。
これがPhase 3での実装の基準となる。

```html
<!--
  DESIGN TOKENS: [サイト名]

  ブランドの意図:
  - （このデザインが体現する価値観・感情）

  Colors:
  - Primary: #XXXXXX（根拠: ブランドカラー / ○○を表現）
  - Background: #XXXXXX（根拠: ○○の印象を出すため）
  - Accent: #XXXXXX（根拠: CTAの視認性確保）

  Typography:
  - Heading: [フォント名]（根拠: ○○の印象）
  - Body: [フォント名]
  - Scale: Hero=64px, H2=36px, H3=20px, Body=16px

  Spacing: 8pxグリッド（8/16/24/32/48/64/80/120px）
  Max-width: 1200px
-->
```

---

## 絶対ルール（違反禁止）

| # | ルール |
|---|---|
| 1 | **CSSは全てインライン記述**（`style=""`属性のみ）。`<style>`タグ・外部CSSファイル禁止 |
| 2 | **単一HTMLファイルで完結**。複数ファイル分割禁止 |
| 3 | **外部リソース読み込み禁止**。CDN・Google Fonts・外部画像URL禁止 |
| 4 | **JavaScriptは原則禁止**。動的UIはFigmaで表現不可のため静的で表現する |
| 5 | **`<link>`タグ禁止**（faviconも含む） |
| 6 | **`<script>`タグ禁止** |
| 7 | ファイル名は `design-draft.html` とする |

---

## HTML構造ルール

### 基本テンプレート
```html
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[サイト名] - デザインドラフト</title>
</head>
<body style="margin: 0; padding: 0; font-family: 'Hiragino Sans', 'Hiragino Kaku Gothic ProN', 'Noto Sans JP', sans-serif; background-color: #ffffff;">
  <!-- セクションを順番に配置 -->
</body>
</html>
```

### セクション構造
- 各セクションは `<section>` タグで囲む
- セクションごとに `style=""` でレイアウトを完結させる
- ネストは最大4階層まで（可読性のため）

---

## フォントルール

### 使用可能なシステムフォント（日本語）
```css
font-family: 'Hiragino Sans', 'Hiragino Kaku Gothic ProN', 'Noto Sans JP', 'Yu Gothic', sans-serif;
```

### 使用可能なシステムフォント（英語・数字）
```css
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Helvetica, Arial, sans-serif;
```

### フォントサイズの基準
| 用途 | サイズ |
|------|--------|
| ヒーローキャッチ | 48px〜72px |
| H1（ページタイトル） | 36px〜48px |
| H2（セクションタイトル） | 28px〜36px |
| H3（サブタイトル） | 20px〜24px |
| 本文 | 16px（最小14px） |
| キャプション・注釈 | 12px〜13px |

---

## レイアウトルール

### 幅の基準
- **最大コンテンツ幅:** `max-width: 1200px; margin: 0 auto;`
- **セクションパディング:** `padding: 80px 40px;`（PCビュー基準）
- **グリッドはFlexboxで表現:**
  ```html
  <div style="display: flex; gap: 32px; flex-wrap: wrap;">
  ```

### スペーシング（8の倍数系）
`8px / 16px / 24px / 32px / 48px / 64px / 80px / 120px`

---

## 画像・アイコンルール

### 画像プレースホルダー
外部画像URL禁止のため、以下の方法で表現する。

**背景色で代替:**
```html
<div style="width: 100%; height: 400px; background-color: #E8E8E8; display: flex; align-items: center; justify-content: center;">
  <span style="color: #999; font-size: 14px;">画像: ヒーロービジュアル (1440×800)</span>
</div>
```

**SVGでシンプルな図形:**
```html
<svg width="48" height="48" viewBox="0 0 48 48" style="display: block;">
  <rect width="48" height="48" rx="8" fill="#3B82F6"/>
  <path d="M16 24h16M24 16v16" stroke="white" stroke-width="2.5" stroke-linecap="round"/>
</svg>
```

### アイコン
- シンプルなSVGで直接記述する
- 外部アイコンフォント（Font Awesome等）禁止

---

## カラールール

### カラー定義
- 要件定義で決定したブランドカラーをインラインで使用
- カラー変数（CSS Variables）は使用しない（インライン必須のため）
- **透明度はRGBA形式:** `rgba(59, 130, 246, 0.1)`

### ボタン・CTAのスタイル例
```html
<a href="#" style="display: inline-block; padding: 16px 40px; background-color: #3B82F6; color: #ffffff; text-decoration: none; border-radius: 8px; font-size: 16px; font-weight: 600; letter-spacing: 0.05em;">
  お問い合わせ
</a>
```

---

## Figmaプラグイン読み込み時の注意

- **html.to.design** を使用する場合、ページ全体が1アートボードになる
- セクションの `id` 属性を付けておくと、Figma上でのナビゲーションに役立つ
  ```html
  <section id="hero" style="...">
  <section id="about" style="...">
  ```
- フォントはシステムフォントを使用するため、Figmaでのフォント置換が発生する場合がある

---

## 出力チェックリスト

出力前に以下を必ず確認する。

- [ ] `<style>`タグが存在しないか
- [ ] `<link>`タグが存在しないか
- [ ] `<script>`タグが存在しないか
- [ ] 外部URLが含まれていないか（`http://`、`https://` で始まるURLがないか）
- [ ] 全てのCSSが `style=""` 属性で記述されているか
- [ ] 単一ファイルで完結しているか
- [ ] ファイル名が `design-draft.html` になっているか
