# 🎨 ビジュアルデザイン出力ルール（Claude内部参照用）

> Phase 3の成果物は `{project-name}/design-draft.html` に書き出します。
> ワイヤーフレーム（Phase 2）が承認された後にのみ実行する。

**このフェーズの目標: ワイヤーフレームと見比べたとき、「全く別物だ」と感じるレベルに仕上げる。**
グレースケールの骨格に、色・光・奥行き・タイポグラフィ・質感を加え、ユーザーの感情を動かすビジュアルにする。

---

## デザイン開始前の必須読み込み

1. `{project}/docs/context.md` — 事業背景・AIの判断基準
2. `{project}/docs/requirements.md` — ターゲット・CTA
3. `{project}/docs/DESIGN.md` — カラー方向性・世界観・参考サイト・Do's/Don'ts
4. `{project}/wireframe.html` — 承認済みの構造（セクション順序は維持する）

---

## ビジュアルデザインの原則

### ワイヤーフレームとの差異を意識的に作る

ワイヤーフレームは「構造の設計図」、ビジュアルデザインは「体験の完成形」。
以下の6軸で変換を行う：

| 軸 | ワイヤーフレーム | ビジュアルデザイン |
|---|---|---|
| **色** | グレースケールのみ | ブランドカラー・背景色・コントラスト |
| **タイポ** | 標準ウェイト | 太さ・字間・行間で情報の強弱を作る |
| **余白** | 均一なパディング | 密度の差でリズムと呼吸を作る |
| **背景** | 白 / 薄グレー | セクションごとに異なる背景色・グラデーション |
| **奥行き** | なし | shadow・border・gradient で層を作る |
| **質感** | なし | 微妙なノイズ・グラデーション・accent要素 |

---

## ビジュアル変換の技法カタログ

> ⚠ 以下のコード例は「技法のデモ」です。色・フォント・レイアウトの具体値は必ず DESIGN.md と context.md から導く。例の色（インディゴ等）をそのまま流用しない。

### 技法 1: ダーク背景 Hero（信頼感・高級感・テック系に有効）

```html
<!-- 色は DESIGN.md の Primary/Background から置き換えること -->
<section id="hero" style="background-color: [DESIGN.md の背景色]; min-height: 90vh;
  display: flex; align-items: center; padding: 0 40px; position: relative; overflow: hidden;">

  <!-- 背景装飾: ブランドカラーの淡いグラデーション -->
  <div style="position: absolute; top: 0; right: 0; width: 60%; height: 100%;
    background: linear-gradient(135deg, rgba([R,G,B of primary],0.15) 0%, transparent 70%);
    pointer-events: none;"></div>

  <div style="max-width: 1200px; margin: 0 auto; position: relative; z-index: 1;">
    <!-- 上部の小さいラベル: アクセントカラーで -->
    <p style="margin: 0 0 16px; font-size: 13px; color: [アクセントカラー]; letter-spacing: 0.18em; font-weight: 600;">
      タグライン
    </p>
    <h1 style="margin: 0 0 24px; font-size: 72px; font-weight: 800; line-height: 1.05; letter-spacing: -0.03em; color: #FFFFFF;">
      キャッチコピー
    </h1>
    <p style="margin: 0 0 48px; font-size: 18px; color: rgba(255,255,255,0.65); line-height: 1.8; max-width: 560px;">
      サブコピー
    </p>
  </div>
</section>
```

### 技法 2: 明るい背景 Hero（親しみ・カジュアル・サービス系に有効）

```html
<!-- background-color は DESIGN.md の雰囲気から選ぶ -->
<section id="hero" style="background-color: [ブランドの淡い背景色]; padding: 120px 40px 80px;">
  <div style="max-width: 1200px; margin: 0 auto; display: flex; gap: 64px; align-items: center; flex-wrap: wrap;">
    <div style="flex: 1 1 480px;">
      <!-- タグチップ: ブランドカラーの淡い背景 + 濃いテキスト -->
      <span style="display: inline-block; padding: 6px 16px;
        background: [primary の 20% 透過]; color: [primary の濃い色];
        font-size: 13px; font-weight: 700; border-radius: 999px; margin-bottom: 24px;">
        タグライン
      </span>
      <h1 style="margin: 0 0 20px; font-size: 64px; font-weight: 900; line-height: 1.1; letter-spacing: -0.02em; color: [テキスト色];">
        キャッチコピー
      </h1>
    </div>
    <div style="flex: 1 1 400px;">
      <!-- 画像プレースホルダー: ブランドカラーのグラデーション -->
      <div style="width: 100%; aspect-ratio: 4/3;
        background: linear-gradient(135deg, [primary 薄め], [secondary 薄め]);
        border-radius: 16px; display: flex; align-items: center; justify-content: center;">
        <span style="color: [primary]; font-size: 14px; opacity: 0.6;">[画像: ヒービジュアル]</span>
      </div>
    </div>
  </div>
</section>
```

### 技法 3: セクション背景の使い分け

同じ背景が続かないよう、DESIGN.md の世界観に合わせてバリエーションを設計する。
**ここで示すのは「構造の原則」であり、色は必ずプロジェクトから導く。**

```
[Hero]       → DESIGN.md の世界観で最もインパクトが出る背景（暗 or 明）
[主要情報]   → 白 or オフホワイト（読みやすさ優先）
[数字・実績] → ブランドカラーを薄くした背景（アクセントとして）
[声・信頼]   → 極薄グレー or クリーム系（落ち着き）
[CTA]        → 最もコントラストが高い背景（行動喚起）
[Footer]     → 最も暗いトーン
```

### 技法 4: カードの奥行き表現

```html
<!-- 技法A: shadow カード（背景が白いときに有効） -->
<div style="background: #FFFFFF; border-radius: 16px; padding: 32px;
  box-shadow: 0 1px 3px rgba(0,0,0,0.06), 0 8px 24px rgba(0,0,0,0.08);">
</div>

<!-- 技法B: アクセントボーダー（ブランドカラーを上線に使う） -->
<div style="background: #FFFFFF; border-radius: 12px; padding: 28px;
  border-top: 4px solid [primaryカラー]; box-shadow: 0 2px 12px rgba(0,0,0,0.06);">
</div>

<!-- 技法C: 背景色カード（セクション背景が暗いときは明るいカード） -->
<div style="background: rgba(255,255,255,0.08); border-radius: 16px; padding: 32px;
  border: 1px solid rgba(255,255,255,0.12);">
</div>
```

### 技法 5: 見出しの階層と強弱

```html
<div style="margin-bottom: 64px;">
  <!-- 上部ラベル: アクセントカラー + 字間広め -->
  <p style="margin: 0 0 12px; font-size: 13px; font-weight: 700;
    letter-spacing: 0.18em; text-transform: uppercase; color: [アクセントカラー];">
    SECTION LABEL
  </p>
  <!-- メイン見出し: 太く・字間詰め -->
  <h2 style="margin: 0 0 16px; font-size: 48px; font-weight: 800;
    letter-spacing: -0.02em; line-height: 1.1; color: [テキスト色];">
    セクションタイトル
  </h2>
  <!-- サブテキスト: 薄いグレー・読みやすい行間 -->
  <p style="margin: 0; font-size: 18px; color: [薄いテキスト色]; line-height: 1.7; max-width: 600px;">
    サポートテキスト
  </p>
</div>
```

### 技法 6: 数字・実績バンド

```html
<!-- 背景色は DESIGN.md から選択。暗めのブランドカラーが映える -->
<div style="background: [ブランドの濃い背景色]; padding: 80px 40px; border-radius: 24px;">
  <div style="max-width: 1200px; margin: 0 auto; display: flex; gap: 48px; justify-content: center; flex-wrap: wrap; text-align: center;">
    <div>
      <p style="margin: 0 0 4px; font-size: 64px; font-weight: 900; color: #FFFFFF; line-height: 1; letter-spacing: -0.02em;">
        1,200<span style="font-size: 32px; color: [アクセント];">+</span>
      </p>
      <p style="margin: 0; font-size: 14px; color: rgba(255,255,255,0.6); letter-spacing: 0.08em;">実績件数</p>
    </div>
  </div>
</div>
```

### 技法 7: CTA セクション

```html
<!-- background は DESIGN.md の CTA 方針から。グラデーションが有効なケースが多い -->
<section style="background: linear-gradient(135deg, [primary], [secondary]); padding: 100px 40px;">
  <div style="max-width: 700px; margin: 0 auto; text-align: center;">
    <h2 style="margin: 0 0 20px; font-size: 48px; font-weight: 800; color: #FFFFFF; letter-spacing: -0.02em; line-height: 1.2;">
      行動を促すコピー
    </h2>
    <a href="#" style="display: inline-block; padding: 20px 56px;
      background: #FFFFFF; color: [primary]; font-weight: 800; font-size: 18px;
      text-decoration: none; border-radius: 8px;">
      メインCTA
    </a>
  </div>
</section>
```

---

## デザイントークン記録（必須）

HTMLの冒頭コメントに記録する:

```html
<!--
  DESIGN TOKENS: [サイト名]

  ブランドの意図: （このデザインが体現する価値観・感情）

  Colors:
  - Primary:    #XXXXXX（根拠: ブランドカラー / ○○を表現）
  - Secondary:  #XXXXXX
  - Background: #XXXXXX
  - Text:       #XXXXXX
  - Accent/CTA: #XXXXXX

  Typography:
  - Hero:   XXpx / weight 800 / tracking -0.03em
  - H2:     XXpx / weight 700 / tracking -0.02em
  - Body:   16-18px / weight 400 / line-height 1.7

  Spacing: 8pxグリッド（セクションは 80px〜120px）
  Max-width: 1200px
-->
```

---

## 絶対ルール

| # | ルール |
|---|---|
| 1 | **CSSは全てインライン**（`style=""`のみ）。`<style>` / 外部CSS禁止 |
| 2 | **単一HTMLファイルで完結** |
| 3 | **外部リソース禁止**（CDN・Google Fonts・外部画像URL禁止） |
| 4 | **`<script>` / `<link>` タグ禁止** |
| 5 | ファイル名は `design-draft.html` |
| 6 | **必ず上書き（write）。追記（append）禁止。** `<!DOCTYPE html>` は1回のみ |

---

## フォント（システムフォントのみ）

```css
/* 日本語 */
font-family: 'Hiragino Sans', 'Hiragino Kaku Gothic ProN', 'Yu Gothic', sans-serif;
/* 英数字（見出しに混在させると洗練される） */
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
```

---

## DESIGN.md の更新（v1 → v2）

Phase 3 完了後、`DESIGN.md` を確定版（v2）に更新する。
`design-draft.html` の DESIGN TOKENS コメントから値を抽出し、各セクションを具体値で上書きする。ステータスを「確定版（v2）」に変更する。

---

## 出力チェックリスト

- [ ] Hero がワイヤーフレームと視覚的に全く異なるか（色・タイポ・レイアウト）
- [ ] 全セクションが同じ白背景でないか（背景色のバリエーションがあるか）
- [ ] カードに shadow / border-radius / アクセントが適用されているか
- [ ] CTA ボタンが存在感のあるスタイルになっているか
- [ ] 見出しに font-weight 700〜900 が使われているか
- [ ] セクションラベル（小さいキャプション）が見出し前に置かれているか
- [ ] 画像プレースホルダーが `background: linear-gradient(...)` など色付きになっているか（グレーの単色でないか）
- [ ] DESIGN TOKENS コメントが冒頭にあるか
- [ ] `<style>` / `<link>` / `<script>` タグが存在しないか
- [ ] 外部URLが含まれていないか
- [ ] `<!DOCTYPE html>` がファイル内に1回だけ存在するか
