# 💻 本番実装 コーディング規約（Claude内部参照用）

> このファイルはClaudeが Phase 4 を進めるための内部ガイドです。
> Phase 4の成果物は `{project-name}/src/` 以下に書き出します。

ビジュアルデザイン（Phase 3）が承認された後にのみ実行する。

---

## 実装開始前の必須確認

Phase 4を開始する前に、必ず以下を確認する。

1. **DESIGN.md（v2）の読み込み**: `{project}/docs/DESIGN.md` の確定値（カラーパレット・タイポグラフィ・スペーシング）を読み取り、`tailwind.config.ts` に反映する。DESIGN.md がデザインシステムの Single Source of Truth
2. **デザイントークンの照合**: `design-draft.html`（複数ページの場合は `design-draft/` 以下のファイル群）の冒頭コメント（DESIGN TOKENS）と `DESIGN.md`（v2）の値が一致していることを確認する
3. **セクション構成の把握**: 各 `design-draft` ファイルのセクション（`id`属性）を確認し、ページ構成とコンポーネント構成を決める
4. **アニメーション・インタラクションの引き継ぎ**: `design-draft` の `<script>` と DESIGN TOKENS コメントの「Animation」欄を読み込み、同等の動きを実装する。CDN で実装していたライブラリは npm パッケージに切り替える
5. **「人間が決めたこと」の保持**: 要件定義書の「🔒 ブランドの本質」セクションに記載のブランド価値観・トーン・CTAは、実装で変更しない

---

## 技術スタック

ユーザーが明示的に指定した場合はその指示を優先する。
指定がない場合のデフォルトは **Astro** とする。

### デフォルト構成（Astro）

| カテゴリ | 採用技術 |
|----------|----------|
| フレームワーク | **Astro 4+** |
| スタイリング | **Tailwind CSS v3+**（`@astrojs/tailwind`） |
| 言語 | TypeScript |
| パッケージマネージャー | pnpm（なければ npm） |
| フォント | `@fontsource/*` または Astro の `<Font>` コンポーネント |
| 画像最適化 | `astro:assets`（`<Image>` コンポーネント） |
| アイコン | `astro-icon` または インラインSVG |
| アニメーション | design-draft の実装方式を引き継ぐ（GSAP / CSS / Vanilla JS） |

Astro を選ぶ理由:
- コンテンツ中心のサイト（LP・コーポレート・ポートフォリオ）に最適
- デフォルトでゼロJS（必要なところだけハイドレーション）
- Tailwind との相性が良い
- `.astro` ファイルで HTML + CSS + JS をコンポーネントとして管理できる

### 代替構成（ユーザー指定時）

| 指定 | 構成 |
|---|---|
| Next.js | Next.js 14+（App Router）+ Tailwind CSS + TypeScript + `next/image` + `next/font` |
| React SPA | Vite + React + Tailwind CSS + TypeScript |
| Vue | Nuxt 3 または Vite + Vue 3 + Tailwind CSS |
| 静的HTML | HTML + CSS + JS（Vite でバンドル）|

---

## ディレクトリ構成

```
src/
├── app/
│   ├── layout.tsx         # ルートレイアウト（フォント・メタ情報）
│   ├── page.tsx           # トップページ
│   └── globals.css        # グローバルスタイル（Tailwindのみ）
├── components/
│   ├── ui/                # 汎用UIコンポーネント（Button, Card等）
│   └── sections/          # ページセクションコンポーネント
│       ├── Hero.tsx
│       ├── About.tsx
│       └── ...
└── lib/
    └── utils.ts           # ユーティリティ関数
```

---

## コンポーネント設計ルール

### 基本方針
- **1ファイル = 1コンポーネント**
- セクション単位でコンポーネントを分割する（Hero, About, Services...）
- propsには必ずTypeScriptの型を定義する

### コンポーネントテンプレート
```tsx
// src/components/sections/Hero.tsx
import type { FC } from 'react'

type HeroProps = {
  title: string
  subtitle?: string
  ctaLabel: string
  ctaHref: string
}

const Hero: FC<HeroProps> = ({ title, subtitle, ctaLabel, ctaHref }) => {
  return (
    <section className="relative w-full min-h-screen flex items-center justify-center bg-gray-50">
      <div className="container mx-auto px-4 sm:px-6 lg:px-8 text-center">
        <h1 className="text-4xl md:text-6xl font-bold text-gray-900 leading-tight">
          {title}
        </h1>
        {subtitle && (
          <p className="mt-6 text-lg md:text-xl text-gray-600 max-w-2xl mx-auto">
            {subtitle}
          </p>
        )}
        <a
          href={ctaHref}
          className="mt-10 inline-flex items-center px-8 py-4 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors duration-200"
        >
          {ctaLabel}
        </a>
      </div>
    </section>
  )
}

export default Hero
```

---

## Tailwind CSS ルール

### クラス記述順序（一般規則）
1. レイアウト（`flex`, `grid`, `block`）
2. 位置（`relative`, `absolute`）
3. サイズ（`w-`, `h-`, `max-w-`）
4. スペーシング（`p-`, `m-`, `gap-`）
5. テキスト（`text-`, `font-`, `leading-`）
6. 色（`bg-`, `text-`, `border-`）
7. その他（`rounded-`, `shadow-`, `transition-`）

### レスポンシブブレークポイント
```
モバイルファースト原則
sm: 640px  → スマートフォン横
md: 768px  → タブレット
lg: 1024px → デスクトップ
xl: 1280px → ワイドスクリーン
```

### カスタムカラー（tailwind.config.ts）
ブランドカラーはTailwindの設定ファイルでカスタムカラーとして定義する。
```ts
// tailwind.config.ts
theme: {
  extend: {
    colors: {
      brand: {
        primary: '#3B82F6',
        secondary: '#1E40AF',
      }
    }
  }
}
```

---

## Next.js 実装ルール

### App Router 基本構成
```tsx
// src/app/layout.tsx
import type { Metadata } from 'next'
import { Noto_Sans_JP } from 'next/font/google'
import './globals.css'

const notoSansJP = Noto_Sans_JP({
  subsets: ['latin'],
  weight: ['400', '500', '700'],
  display: 'swap',
})

export const metadata: Metadata = {
  title: 'サイト名',
  description: 'サイトの説明',
  openGraph: {
    title: 'サイト名',
    description: 'サイトの説明',
    type: 'website',
  },
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="ja">
      <body className={notoSansJP.className}>{children}</body>
    </html>
  )
}
```

### 画像は必ず next/image を使う（`<img>` タグは一切使わない）
```tsx
import Image from 'next/image'

<Image
  src="/images/hero.jpg"
  alt="ヒービジュアル"
  width={1440}
  height={800}
  priority  // ファーストビューの画像にはpriority付与
  className="w-full h-auto object-cover"
/>
```

### Serverコンポーネント優先
- デフォルトはServer Component
- インタラクション（useState, useEffect, イベント）が必要な場合のみ `'use client'` を付与
- データフェッチはServer Component内でasync/awaitを使用

---

## アクセシビリティ（a11y）ルール

- `<img>` には必ず `alt` 属性を付ける（装飾画像は `alt=""`）
- ボタン・リンクには分かりやすいテキストを入れる（「こちら」禁止）
- カラーコントラスト比 4.5:1 以上を確保（WCAG 2.1 AA）
- フォーカス可能な要素に `:focus-visible` スタイルを設定する
- `<main>`, `<header>`, `<footer>`, `<nav>` などのランドマーク要素を適切に使う
- アニメーションは `prefers-reduced-motion` を考慮する

---

## パフォーマンスルール

- **Core Web Vitals** を意識した実装
  - LCP: ファーストビュー画像に `priority` を付与
  - CLS: 画像・フォントに `width/height` を明示
  - FID/INP: 不要なJavaScriptを削減
- 重いコンポーネントは `next/dynamic` で遅延読み込み
- アニメーションは `transform` と `opacity` のみ使う（レイアウトシフト防止）

---

## SEO ルール

- 各ページに `metadata` を設定する（title, description, OGP）
- 見出し階層を正しく使う（h1 はページに1つのみ）
- `<a>` タグは正しいhrefを持つ（`#` だけのリンクは避ける）
- Canonical URLを設定する
- sitemap.xml と robots.txt を生成する（`app/sitemap.ts`, `app/robots.ts`）

---

## コード品質ルール

- **ESLint + Prettier** の設定に従う
- 関数・変数名は英語で、意味が明確なものにする
- マジックナンバーは定数化する
- コメントは「なぜそうしたか」を書く（「何をしているか」はコードから分かる）
- 不要な `console.log` は削除する

---

## 実装チェックリスト

リリース前に以下を確認する。

- [ ] TypeScriptエラーが0件（`pnpm tsc --noEmit`）
- [ ] ESLintエラーが0件（`pnpm lint`）
- [ ] 全ページがレスポンシブ対応されているか（SP/Tablet/PC）
- [ ] Lighthouseスコア: Performance 90+, Accessibility 95+, SEO 95+
- [ ] OGP画像・メタタグが設定されているか
- [ ] 画像に `alt` テキストが設定されているか
- [ ] フォームのバリデーションが動作するか
- [ ] 404ページが実装されているか（`app/not-found.tsx`）
- [ ] 環境変数が `.env.example` に記載されているか
