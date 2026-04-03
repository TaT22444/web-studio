# 💻 本番実装 コーディング規約（Claude内部参照用）

> このファイルはClaudeが Phase 4 を進めるための内部ガイドです。
> Phase 4の成果物は `{project-name}/src/` 以下に書き出します。

ビジュアルデザイン（Phase 3）が承認された後にのみ実行する。

---

## 実装開始前の必須確認

Phase 4を開始する前に、必ず以下を確認する。

1. **DESIGN.md（v2+）の読み込みと Tailwind 設定への反映**: `{project}/docs/DESIGN.md` は 8 セクション構成の確定版（v2.x の追記更新がある場合は最新版を使う）。デザインシステムの Single Source of Truth として以下の通り反映する:

   | DESIGN.md v2+ セクション | Tailwind 設定への反映先 |
   |---|---|
   | Section 2: カラーパレット | `theme.extend.colors` — セマンティック名でカスタムカラーを定義 |
   | Section 3: タイポグラフィ | `theme.extend.fontFamily` + `theme.extend.fontSize`（サイズ・ウェイト・字間をプリセット化） |
   | Section 5: レイアウト・スペーシング | `theme.extend.spacing` + `theme.extend.maxWidth`（必要に応じて） |
   | Section 6: 深度・エレベーション | `theme.extend.boxShadow` + `theme.extend.borderRadius` |

   Section 4（コンポーネント）は `components/ui/` の基本コンポーネント設計に反映する。
   Section 8（レスポンシブ・アニメーション）はブレークポイント設計とアニメーション実装の参照とする。

2. **デザイントークンの照合**: `design-draft.html`（複数ページの場合は `design-draft/` 以下のファイル群）の冒頭コメント（DESIGN TOKENS）と `DESIGN.md`（v2+）の値が一致していることを確認する
3. **セクション構成の把握**: 各 `design-draft` ファイルのセクション（`id`属性）を確認し、ページ構成とコンポーネント構成を決める
4. **アニメーション・インタラクションの引き継ぎ**: `design-draft` の `<script>` と DESIGN.md v2 Section 8（レスポンシブ・アニメーション）を読み込み、同等の動きを実装する。CDN で実装していたライブラリは npm パッケージに切り替える
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

## ディレクトリ構成（Astro デフォルト）

```
src/
├── pages/
│   ├── index.astro          # トップページ
│   ├── about.astro          # サブページ（例）
│   └── works/
│       └── [slug].astro     # 動的ルート（作品詳細等）
├── layouts/
│   └── Base.astro           # 共通レイアウト（head・ナビ・フッター）
├── components/
│   ├── ui/                  # 汎用UIコンポーネント（Button, Card等）
│   │   ├── Button.astro
│   │   └── Card.astro
│   └── sections/            # ページセクションコンポーネント
│       ├── Hero.astro
│       ├── About.astro
│       └── ...
├── content/                 # コンテンツコレクション（MD / MDX）
│   └── works/
│       ├── project-01.md
│       └── project-02.md
├── styles/
│   └── global.css           # グローバルスタイル（Tailwind ディレクティブ）
└── lib/
    └── utils.ts             # ユーティリティ関数
```

---

## コンポーネント設計ルール

### 基本方針
- **1ファイル = 1コンポーネント**
- セクション単位でコンポーネントを分割する（Hero, About, Services...）
- Props には TypeScript の `Props` インターフェースを定義する

### コンポーネントテンプレート（Astro）
```astro
---
// src/components/sections/Hero.astro
interface Props {
  title: string
  subtitle?: string
  ctaLabel: string
  ctaHref: string
}

const { title, subtitle, ctaLabel, ctaHref } = Astro.props
---

<section class="relative w-full min-h-screen flex items-center justify-center bg-gray-50">
  <div class="container mx-auto px-4 sm:px-6 lg:px-8 text-center">
    <h1 class="text-4xl md:text-6xl font-bold text-gray-900 leading-tight">
      {title}
    </h1>
    {subtitle && (
      <p class="mt-6 text-lg md:text-xl text-gray-600 max-w-2xl mx-auto">
        {subtitle}
      </p>
    )}
    <a
      href={ctaHref}
      class="mt-10 inline-flex items-center px-8 py-4 bg-blue-600 text-white font-semibold rounded-lg hover:bg-blue-700 transition-colors duration-200"
    >
      {ctaLabel}
    </a>
  </div>
</section>
```

### レイアウトテンプレート
```astro
---
// src/layouts/Base.astro
import '@fontsource/noto-sans-jp/400.css'
import '@fontsource/noto-sans-jp/500.css'
import '@fontsource/noto-sans-jp/700.css'
import '../styles/global.css'

interface Props {
  title: string
  description?: string
}

const { title, description = 'サイトの説明' } = Astro.props
---

<!doctype html>
<html lang="ja">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>{title}</title>
    <meta name="description" content={description} />
    <meta property="og:title" content={title} />
    <meta property="og:description" content={description} />
    <meta property="og:type" content="website" />
  </head>
  <body class="font-sans text-gray-900 bg-white">
    <slot />
  </body>
</html>
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

### カスタムカラー（tailwind.config.mjs）
ブランドカラーはTailwindの設定ファイルでカスタムカラーとして定義する。
```mjs
// tailwind.config.mjs
export default {
  content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
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
}
```

---

## Astro 実装ルール

### フォント
`@fontsource/*` パッケージを使う。レイアウトの frontmatter で import する。
```bash
pnpm add @fontsource/noto-sans-jp @fontsource/dm-sans
```

### 画像
`astro:assets` の `<Image>` コンポーネントを使う。`<img>` タグ直書きは避ける。
```astro
---
import { Image } from 'astro:assets'
import heroImage from '../assets/hero.jpg'
---

<Image
  src={heroImage}
  alt="ヒーロービジュアル"
  width={1440}
  height={800}
  loading="eager"
  class="w-full h-auto object-cover"
/>
```

### コンテンツコレクション（ブログ・作品集等）
繰り返しコンテンツは `src/content/` に Markdown で管理し、`getCollection()` で取得する。
```astro
---
// src/pages/works/[slug].astro
import { getCollection } from 'astro:content'
import Base from '../../layouts/Base.astro'

export async function getStaticPaths() {
  const works = await getCollection('works')
  return works.map((entry) => ({
    params: { slug: entry.slug },
    props: { entry },
  }))
}

const { entry } = Astro.props
const { Content } = await entry.render()
---

<Base title={entry.data.title}>
  <article>
    <Content />
  </article>
</Base>
```

### インタラクティブ要素
Astro はデフォルトでゼロ JS。インタラクションが必要な場合:
- 軽量なもの（ナビ開閉・スクロール監視）→ `<script>` タグ（Vanilla JS）
- 複雑な状態管理 → React / Vue アイランド（`client:load` / `client:visible`）

---

## 代替構成: Next.js（ユーザー指定時）

### ディレクトリ構成（Next.js）
```
src/
├── app/
│   ├── layout.tsx         # ルートレイアウト
│   ├── page.tsx           # トップページ
│   └── globals.css        # グローバルスタイル
├── components/
│   ├── ui/
│   └── sections/
│       ├── Hero.tsx
│       └── ...
└── lib/
    └── utils.ts
```

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
  alt="ヒーロービジュアル"
  width={1440}
  height={800}
  priority
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
  - LCP: ファーストビュー画像に `loading="eager"` / `priority`（Next.js）を付与
  - CLS: 画像・フォントに `width/height` を明示
  - FID/INP: 不要なJavaScriptを削減（Astro ならデフォルトでゼロ JS）
- 重いコンポーネントは遅延読み込み（Astro: `client:visible` / Next.js: `next/dynamic`）
- アニメーションは `transform` と `opacity` のみ使う（レイアウトシフト防止）

---

## SEO ルール

- 各ページの `<head>` に title, description, OGP を設定する（Astro: レイアウトの props / Next.js: `metadata`）
- 見出し階層を正しく使う（h1 はページに1つのみ）
- `<a>` タグは正しいhrefを持つ（`#` だけのリンクは避ける）
- Canonical URLを設定する
- sitemap.xml と robots.txt を生成する（Astro: `@astrojs/sitemap` / Next.js: `app/sitemap.ts`）

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
- [ ] 404ページが実装されているか（Astro: `src/pages/404.astro` / Next.js: `app/not-found.tsx`）
- [ ] 環境変数が `.env.example` に記載されているか
